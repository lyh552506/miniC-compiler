#include "../include/backend/RISCVFrameContext.hpp"
#include "../include/backend/RISCVMIR.hpp"
#include "../include/backend/RISCVMOperand.hpp"
#include "../include/backend/RISCVRegister.hpp"
#include "../include/backend/RISCVType.hpp"
#include "../include/backend/RegAlloc.hpp"
#include "../util/my_stl.hpp"
#include <algorithm>
#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <iostream>
#include <ostream>
#include <unordered_set>
void GraphColor::RunOnFunc() {
  bool condition = true;
  GC_init();
  for (auto b : *m_func)
    CalCulateSucc(b);
  CaculateTopu(m_func->front());
  std::reverse(topu.begin(), topu.end());
  while (condition) {
    condition = false;
    CaculateLiveness();
    MakeWorklist();
    do {
      if (!simplifyWorkList.empty())
        simplify();
      else if (!worklistMoves.empty())
        coalesce();
      else if (!freezeWorkList.empty())
        freeze();
      else if (!spillWorkList.empty())
        spill();
    } while (!simplifyWorkList.empty() || !worklistMoves.empty() ||
             !freezeWorkList.empty() || !spillWorkList.empty());
    for (auto sp : SpillStack) {
      auto it = std::find(selectstack.begin(), selectstack.end(), sp);
      if (it == selectstack.end())
        assert(0);
      selectstack.erase(it);
    }
    std::reverse(SpillStack.begin(), SpillStack.end());
    selectstack.insert(selectstack.end(), SpillStack.begin(), SpillStack.end());
    AssignColors();
    if (!spilledNodes.empty()) {
      // CaculateSpillLiveness();
      SpillNodeInMir();
      condition = true;
    }
  }
  RewriteProgram();
}

void GraphColor::MakeWorklist() {
  for (auto node : initial) {
    //添加溢出节点
    if (Degree[node] > GetRegNums(node))
      spillWorkList.insert(node);
    else if (MoveRelated(node).size() != 0)
      freezeWorkList.insert(node);
    else {
      simplifyWorkList.push_back(node);
    }
  }
}

std::unordered_set<RISCVMIR *> GraphColor::MoveRelated(MOperand v) {
  std::unordered_set<RISCVMIR *> tmp;
  if (moveList.find(v) == moveList.end())
    return tmp;
  for (auto inst : moveList[v]) {
    auto iter = std::find(worklistMoves.begin(), worklistMoves.end(), inst);
    if (activeMoves.find(inst) != activeMoves.end() ||
        iter != worklistMoves.end())
      tmp.insert(inst);
  }
  return tmp;
}

MOperand GraphColor::GetAlias(MOperand v) {
  //当前v存在于coalescedNodes，则返回v的alias
  if (coalescedNodes.find(v) != coalescedNodes.end()) {
    return GetAlias(alias[v]);
  } else {
    return v;
  }
}

//实行George的启发式合并
bool GraphColor::GeorgeCheck(MOperand dst, MOperand src, RISCVType ty) {
  if (ty == riscv_i32 || ty == riscv_ptr || ty == riscv_i64) {
    auto x = Adjacent(src);
    for (auto tmp : x) {
      bool ok = false;
      if (Degree[tmp] < reglist.GetReglistInt().size())
        ok |= true;
      if (Precolored.find(tmp) != Precolored.end())
        ok |= true;
      auto &adj = adjSet[dst];
      if (adj.find(tmp) != adj.end())
        ok |= true;
      if (ok != true)
        return false;
    }
  } else if (ty == riscv_float32) {
    auto x = Adjacent(src);
    for (auto tmp : x) {
      bool ok = false;
      if (Degree[tmp] < reglist.GetReglistFloat().size())
        ok |= true;
      if (Precolored.find(tmp) != Precolored.end())
        ok |= true;
      auto &adj = adjSet[dst];
      if (adj.find(tmp) != adj.end())
        ok |= true;
      if (ok != true)
        return false;
    }
  } else {
    assert(0 && "type must be either int or float");
  }
  return true;
}
//实行Briggs的启发合并
bool GraphColor::BriggsCheck(MOperand dst, MOperand src, RISCVType ty) {
  auto tmp = Adjacent(dst);
  std::unordered_set<MOperand> target{tmp.begin(), tmp.end()};
  tmp = Adjacent(src);
  target.insert(tmp.begin(), tmp.end());
  if (ty == riscv_i32 | ty == riscv_ptr || ty == riscv_i64) {
    int num = 0;
    for (auto node : target) {
      if (Degree[node] >= reglist.GetReglistInt().size())
        num++;
    }
    return (num < reglist.GetReglistInt().size());
  } else if (ty == riscv_float32) {
    int num = 0;
    for (auto node : target) {
      if (Degree[node] >= reglist.GetReglistFloat().size())
        num++;
    }
    return (num < reglist.GetReglistFloat().size());
  } else
    return true;
}

void GraphColor::AddWorkList(MOperand v) {
  if (Precolored.find(v) == Precolored.end() && Degree[v] < GetRegNums(v) &&
      MoveRelated(v).size() == 0) {
    freezeWorkList.erase(v);
    PushVecSingleVal(simplifyWorkList, v);
  }
}

void GraphColor::CaculateLiveness() {
  LiveInfoInit();
  RunOnFunction();
  //计算IG,并且添加precolored集合
  Build();
  RunOnFunc_();
  for (const auto b : *m_func) {
    CaculateLiveInterval(b);
  }
}

void GraphColor::CaculateLiveInterval(RISCVBasicBlock *mbb) {
  //计算区间并存入
  auto &IntervInfo = GetRegLiveInterval(mbb);
  for (auto &[val, vec] : IntervInfo) {
    if (!GlobalLiveRange.count(val)) {
      GlobalLiveRange[val].start = INT32_MAX;
      GlobalLiveRange[val].end = INT32_MIN;
    }
    unsigned int length = 0;
    for (auto v : vec) {
      if (v.start < GlobalLiveRange[val].start)
        GlobalLiveRange[val].start = v.start;
      if (v.end > GlobalLiveRange[val].end)
        GlobalLiveRange[val].end = v.end;
      length += v.end - v.start;
    }
    ValsInterval[val] = length;
  }
}

// TODO spill node的启发式函数
/*
  需要考虑的点：
  1.活跃interval区间越大越优先选择溢出
  2.度数越高越优先选择溢出
  3.是否需要考虑loopcounter循环嵌套数
*/
MOperand GraphColor::HeuristicSpill() {
  float max = 0;
  Register *sp = nullptr;
  for (auto spill : spillWorkList) {
    auto vspill = dynamic_cast<VirRegister *>(spill);
    // if (AlreadySpill.find(vspill) != AlreadySpill.end())
    //   continue;
    // return spill;
    float weight = 0;
    //考虑degree
    int degree = Degree[spill];
    if (degree < 0)
      assert(0);
    weight += (degree * DegreeWeight);
    //考虑interval区间
    int intervalLength = ValsInterval[spill];
    weight += (intervalLength * livenessWeight);
    weight +=
        (vspill->GetPenaltySpill() + vspill->GetPenaltyReload()) * SpillWeight;
    //考虑嵌套层数
    int loopdepth; // TODO
    if (max < weight) {
      max = weight;
      sp = spill;
      continue;
    }
    // weight /= std::pow(LoopWeight, loopdepth);
  }
  if (!sp)
    for (auto spill : spillWorkList)
      return spill;
  return sp;
}

// TODO选择freeze node的启发式函数
/*
 */
MOperand GraphColor::HeuristicFreeze() { return *(freezeWorkList.begin()); }

void GraphColor::SetRegState(PhyRegister *reg, RISCVType ty) {
  RegType[reg] = ty;
}

int GraphColor::GetRegNums(MOperand v) {
  if (v->GetType() == riscv_i32 || v->GetType() == riscv_ptr || v->GetType() == riscv_i64)
    return reglist.GetReglistInt().size();
  else if (v->GetType() == riscv_float32)
    return reglist.GetReglistFloat().size();
  else if (v->GetType() == riscv_none) {
    auto preg = dynamic_cast<PhyRegister *>(v);
    auto tp = RegType[preg];
    assert(tp != RISCVType::riscv_none && "error");
    return (tp == riscv_i32 || tp == riscv_i64) ? reglist.GetReglistInt().size()
                           : reglist.GetReglistFloat().size();
  }
  assert("excetion case");
  return 0;
}

int GraphColor::GetRegNums(RISCVType ty) {
  if (ty == riscv_i32 || ty == riscv_ptr || ty == riscv_i64)
    return reglist.GetReglistInt().size();
  if (ty == riscv_float32)
    return reglist.GetReglistFloat().size();
  assert(0);
}

// rd <-rs变成 rs(rs)
void GraphColor::combine(MOperand rd, MOperand rs) {
  if (rd->GetType() == riscv_none && rs->GetType() != riscv_none)
    RegType[dynamic_cast<PhyRegister *>(rd)] = rs->GetType();
  else if (rd->GetType() != riscv_none && rs->GetType() == riscv_none)
    RegType[dynamic_cast<PhyRegister *>(rs)] = rd->GetType();
  if (freezeWorkList.find(rs) != freezeWorkList.end())
    freezeWorkList.erase(rs);
  else
    spillWorkList.erase(rs);
  coalescedNodes.insert(rs);
  alias[rs] = rd;
  //更新合并后的movelist,干涉图
  for (auto mv : moveList[rs]) {
    moveList[rd].insert(mv);
  }
  for (auto mov : MoveRelated(rs))
    if (activeMoves.find(mov) != activeMoves.end()) {
      activeMoves.erase(mov);
      PushVecSingleVal(worklistMoves, mov);
    }

  auto t = Adjacent(rs);
  std::unordered_set<MOperand> tmp(t.begin(), t.end());
  // EnableMove
  for (auto node : AdjList[rs]) {
    // Add Edge
    AddEdge(node, rd);
    DecrementDegree(node);
  }
  if (Degree[rd] >= GetRegNums(rs) &&
      (freezeWorkList.find(rd) != freezeWorkList.end())) {
    freezeWorkList.erase(rd);
    spillWorkList.insert(rd);
  }
}

void GraphColor::FreezeMoves(MOperand freeze) {
  auto tmp = MoveRelated(freeze);
  for (auto mov : tmp) {
    // mov: dst<-src
    MOperand dst = dynamic_cast<MOperand>(mov->GetDef());
    MOperand src = dynamic_cast<MOperand>(mov->GetOperand(0));
    MOperand value;
    //找到除了freeze的另外一个操作数
    if (GetAlias(src) == GetAlias(freeze)) {
      value = GetAlias(dst);
    } else {
      value = GetAlias(src);
    }
    activeMoves.erase(mov);
    frozenMoves.insert(mov);
    if (MoveRelated(value).size() == 0) {
      if ((value->GetType() == riscv_i32 &&
              Degree[value] < reglist.GetReglistInt().size()) ||
              (value->GetType() == riscv_i64 &&
              Degree[value] < reglist.GetReglistInt().size()) ||
          (value->GetType() == riscv_float32 &&
              Degree[value] < reglist.GetReglistFloat().size()) ||
          (value->GetType() == riscv_ptr &&
              Degree[value] < reglist.GetReglistInt().size())) {
        freezeWorkList.erase(value);
        PushVecSingleVal(simplifyWorkList, value);
      }
    }
  }
}

void GraphColor::simplify() {
  auto val = simplifyWorkList.back();
  simplifyWorkList.pop_back();
  selectstack.push_back(val);
  _DEBUG(std::cerr << "SelectStack Insert: " << val->GetName() << std::endl;)
  //此时需要更新冲突图上和当前val相邻的边(DecrementDegree)
  auto adj = Adjacent(val);
  for (auto target : AdjList[val]) {
    DecrementDegree(target);
  }
}

void GraphColor::coalesce() {
  // only consider the mv inst in worklistmoves
  for (int i = 0; i < worklistMoves.size(); i++) {
    using MoveOperand = std::pair<MOperand, MOperand>;
    MoveOperand m;
    RISCVMIR *mv = worklistMoves[i];
    // rd <- rs
    MOperand rd = dynamic_cast<MOperand>(mv->GetDef()->ignoreLA());
    MOperand rs = dynamic_cast<MOperand>(mv->GetOperand(0)->ignoreLA());
    rd = GetAlias(rd);
    rs = GetAlias(rs);
    if (Precolored.find(rs) != Precolored.end()) {
      m = std::make_pair(rs, rd);
    } else {
      m = std::make_pair(rd, rs);
    }
    vec_pop(worklistMoves, i);
    if (m.first == m.second) {
      // means we use the : r1 <- r1 ,chich can be simplify
      coalescedMoves.push_back(mv);
      AddWorkList(m.first);
    } else if (Precolored.find(m.second) != Precolored.end() ||
               adjSet[m.first].find(m.second) != adjSet[m.first].end()) {
      // two oprand are all reg or the rs and rd are in IG
      constrainedMoves.insert(mv);
      AddWorkList(m.first);
      AddWorkList(m.second);
    } else if ((Precolored.find(m.first) != Precolored.end() &&
                GeorgeCheck(m.second, m.first, m.second->GetType())) ||
               (Precolored.find(m.first) == Precolored.end() &&
                BriggsCheck(m.second, m.first, m.first->GetType()))) {
      coalescedMoves.push_back(mv);
      combine(m.first, m.second);
      AddWorkList(m.first);
    } else {
      //不满足我们的合并情况
      activeMoves.insert(mv);
    }
  }
}

void GraphColor::freeze() {
  auto freeze = HeuristicFreeze();
  freezeWorkList.erase(freeze);
  PushVecSingleVal(simplifyWorkList, freeze);
  //放弃对这个freeze节点合并的希望，将他看成是传送无关节点
  FreezeMoves(freeze);
}

void GraphColor::spill() {
  auto spill = HeuristicSpill();
  if (spill == nullptr)
    return;
  spillWorkList.erase(spill);
  _DEBUG(std::cerr << "Choose To Spill element: " << spill->GetName()
                   << std::endl;)
  SpillStack.push_back(spill);
  PushVecSingleVal(simplifyWorkList, spill);
  FreezeMoves(spill);
}

void GraphColor::AssignColors() {
  while (!selectstack.empty()) {
    MOperand select = selectstack.front();
    RISCVType ty = select->GetType();
    selectstack.erase(selectstack.begin());
    std::unordered_set<MOperand> int_assist{reglist.GetReglistInt().begin(),
                                            reglist.GetReglistInt().end()};
    std::unordered_set<MOperand> float_assist{reglist.GetReglistFloat().begin(),
                                              reglist.GetReglistFloat().end()};
    //遍历所有的冲突点，查看他们分配的颜色，保证我们分配的颜色一定是不同的
    for (auto adj : AdjList[select])
      if (coloredNode.find(GetAlias(adj)) != coloredNode.end() ||
          Precolored.find(GetAlias(adj)) != Precolored.end()) {
        if (color.find(dynamic_cast<MOperand>(GetAlias(adj))) == color.end())
          assert(0);
        if (ty == riscv_i32 || ty == riscv_ptr || ty == riscv_i64)
          int_assist.erase(color[GetAlias(adj)]);
        else if (ty == riscv_float32)
          float_assist.erase(color[GetAlias(adj)]);
      }
    bool flag = false;
    if (ty == riscv_i32 || ty == riscv_ptr || ty == riscv_i64) {
      if (int_assist.size() == 0)
        spilledNodes.insert(select);
      else {
        coloredNode.insert(select);
        color[select] = SelectPhyReg(select, ty, int_assist);
        _DEBUG(std::cerr << "Assign reg(int): " << color[select]->GetName()
                         << " To " << select->GetName() << std::endl;)
      }
    } else if (ty == riscv_float32) {
      if (float_assist.size() == 0)
        spilledNodes.insert(select);
      else {
        coloredNode.insert(select);
        color[select] = SelectPhyReg(select, ty, float_assist);
        _DEBUG(std::cerr << "Assign reg(float): " << color[select]->GetName()
                         << " To " << select->GetName() << std::endl;)
      }
    }
  }
  for (auto caols : coalescedNodes) {
    if (caols->GetName() == ".31")
      int i = 0;
    color[caols] = color[GetAlias(caols)];
  }
}

void GraphColor::SpillNodeInMir() {
  std::unordered_set<VirRegister *> temps;
  for (const auto mbb : topu) {
    for (auto mir_begin = mbb->begin(), mir_end = mbb->end();
         mir_begin != mir_end;) {
      auto mir = *mir_begin;
      if (mir->GetOpcode() == RISCVMIR::call ||
          mir->GetOpcode() == RISCVMIR::ret ||
          mir->GetOpcode() == RISCVMIR::_j) {
        ++mir_begin;
        continue;
      }
      if (mir->GetDef() != nullptr &&
          dynamic_cast<VirRegister *>(mir->GetDef()) &&
          spilledNodes.find(dynamic_cast<VirRegister *>(mir->GetDef())) !=
              spilledNodes.end()) {
        auto op = dynamic_cast<VirRegister *>(mir->GetDef());
        auto sd = CreateSpillMir(mir->GetDef(), temps);
        mir_begin.insert_after(sd);
        _DEBUG(std::cerr
                   << "Spilling "
                   << dynamic_cast<VirRegister *>(mir->GetDef())->GetName()
                   << ", Use Vreg "
                   << dynamic_cast<VirRegister *>(sd->GetOperand(0))->GetName()
                   << " To Replace" << std::endl;)
        mir->SetDef(sd->GetOperand(0));
        if (mir->GetOpcode() == RISCVMIR::RISCVISA::mv ||
            mir->GetOpcode() == RISCVMIR::RISCVISA::_fmv_s)
          NotMove.insert(mir);
      }
      for (int i = 0; i < mir->GetOperandSize(); i++) {
        auto operand = mir->GetOperand(i);
        if (mir->GetOperand(i) != nullptr &&
            dynamic_cast<VirRegister *>(mir->GetOperand(i)) &&
            spilledNodes.find(dynamic_cast<VirRegister *>(
                mir->GetOperand(i))) != spilledNodes.end()) {
          //存在operand(i)并且operand(i)是一个已经spill节点
          auto op = dynamic_cast<VirRegister *>(mir->GetOperand(i));
          // assert(SpillToken.find(op) != SpillToken.end());
          auto ld = CreateLoadMir(mir->GetOperand(i), temps);
          mir_begin.insert_before(ld);
          _DEBUG(
              std::cerr
                  << "Find a Spilled Node "
                  << dynamic_cast<VirRegister *>(mir->GetOperand(i))->GetName()
                  << ", Use Vreg "
                  << dynamic_cast<VirRegister *>(ld->GetDef())->GetName()
                  << " To Replace" << std::endl;)
          mir->SetOperand(i, ld->GetDef());
          if (mir->GetOpcode() == RISCVMIR::RISCVISA::mv ||
              mir->GetOpcode() == RISCVMIR::RISCVISA::_fmv_s)
            NotMove.insert(mir);
        }
      }
      ++mir_begin;
    }
  }
  spilledNodes.clear();
  initial.clear();
  initial.insert(coloredNode.begin(), coloredNode.end());
  initial.insert(coalescedNodes.begin(), coalescedNodes.end());
  initial.insert(temps.begin(), temps.end());
  coalescedNodes.clear();
  coloredNode.clear();
}

RISCVMIR *GraphColor::CreateSpillMir(RISCVMOperand *spill,
                                     std::unordered_set<VirRegister *> &temps) {
  auto vreg = dynamic_cast<VirRegister *>(spill);
  assert(vreg && "the chosen operand must be a vreg");
  // assert(AlreadySpill.find(vreg) == AlreadySpill.end() && "no spill before");

  if (auto specialmop = m_func->GetSpecialUsageMOperand(vreg)) {
    auto mir = new RISCVMIR(RISCVMIR::MarkDead);
    auto newreg = ctx.createVReg(vreg->GetType());
    mir->AddOperand(newreg);
    temps.insert(newreg);
    // AlreadySpill[vreg] = mir;
    return mir;
  }

  VirRegister *reg = new VirRegister(vreg->GetType());
  temps.insert(reg);
  RISCVMIR *sd = nullptr;
  if (spill->GetType() == RISCVType::riscv_i32 ||
      spill->GetType() == RISCVType::riscv_ptr ||
      spill->GetType() == RISCVType::riscv_i64 )
    sd = new RISCVMIR(RISCVMIR::RISCVISA::_sd);
  else if (spill->GetType() == RISCVType::riscv_float32)
    sd = new RISCVMIR(RISCVMIR::RISCVISA::_fsw);
  sd->AddOperand(reg);
  auto spillnode = m_func->GetFrame()->spill(vreg);
  sd->AddOperand(spillnode);
  // AlreadySpill[vreg] = sd;
  return sd;
}

RISCVMIR *GraphColor::CreateLoadMir(RISCVMOperand *load,
                                    std::unordered_set<VirRegister *> &temps) {
  auto vreg = dynamic_cast<VirRegister *>(load);
  assert(vreg && "the chosen operand must be a vreg");
  // assert(AlreadySpill.find(vreg) != AlreadySpill.end() && "no spill before");

  if (auto specialmop = m_func->GetSpecialUsageMOperand(vreg)) {
    auto mir = m_func->CreateSpecialUsageMIR(specialmop);
    temps.insert(mir->GetDef()->as<VirRegister>());
    return mir;
  }

  VirRegister *reg = new VirRegister(vreg->GetType());
  temps.insert(reg);
  RISCVMIR *lw = nullptr;
  if (load->GetType() == RISCVType::riscv_i32 ||
      load->GetType() == RISCVType::riscv_ptr ||
      load->GetType() == RISCVType::riscv_i64 )
    lw = new RISCVMIR(RISCVMIR::RISCVISA::_ld);
  else if (load->GetType() == RISCVType::riscv_float32)
    lw = new RISCVMIR(RISCVMIR::RISCVISA::_flw);
  // auto loadnode = AlreadySpill[vreg]->GetOperand(1);
  auto spillnode = m_func->GetFrame()->spill(vreg);
  lw->SetDef(reg);
  lw->AddOperand(spillnode);
  return lw;
}

void GraphColor::RewriteProgram() {
  for (const auto mbb : topu) {
    for (auto mirit = mbb->begin(); mirit != mbb->end();) {
      auto mir = *mirit;
      ++mirit;
      if (mir->GetOpcode() == RISCVMIR::call)
        continue;
      if (mir->GetDef() != nullptr &&
          dynamic_cast<VirRegister *>(mir->GetDef())) {
        if (color.find(dynamic_cast<MOperand>(mir->GetDef())) == color.end())
          assert(0);
        auto replace = color[dynamic_cast<MOperand>(mir->GetDef())];
        _DEBUG(
            std::cerr << "REPLACE Vreg "
                      << dynamic_cast<VirRegister *>(mir->GetDef())->GetName()
                      << " To Preg " << replace->GetName() << std::endl;)
        mir->SetDef(replace);
      }
      for (int i = 0; i < mir->GetOperandSize(); i++) {
        auto operand = mir->GetOperand(i);
        if (dynamic_cast<VirRegister *>(operand)) {
          if (color.find(dynamic_cast<MOperand>(operand)) == color.end())
            assert(0);
          auto replace = color[dynamic_cast<MOperand>(operand)];
          _DEBUG(std::cerr << "REPLACE Vreg "
                           << dynamic_cast<VirRegister *>(operand)->GetName()
                           << " To Preg " << replace->GetName() << std::endl;)
          mir->SetOperand(i, replace);
        } else if (auto lareg = dynamic_cast<LARegister *>(operand)) {
          if (lareg->GetVreg() == nullptr)
            continue;
          if (color.find(dynamic_cast<MOperand>(lareg->GetVreg())) ==
              color.end())
            assert(0);
          auto replace = color[dynamic_cast<MOperand>(lareg->GetVreg())];
          lareg->SetReg(replace);
        } else if (auto stackreg = dynamic_cast<StackRegister *>(operand)) {
          if (stackreg->GetVreg() == nullptr)
            continue;
          if (color.find(dynamic_cast<MOperand>(stackreg->GetVreg())) ==
              color.end())
            assert(0);
          auto replace = color[dynamic_cast<MOperand>(stackreg->GetVreg())];
          stackreg->SetPreg(replace);
        }
      }
      if ((mir->GetOpcode() == RISCVMIR::mv ||
           mir->GetOpcode() == RISCVMIR::_fmv_s) &&
          mir->GetDef() == mir->GetOperand(0)) {
        delete mir;
      }
    }
  }
}

//单独抽离成一个函数，后续有调用规约修改的时候我们再更改
PhyRegister *GraphColor::SelectPhyReg(MOperand vreg, RISCVType ty,
                                      std::unordered_set<MOperand> &assist) {
  std::unordered_set<PhyRegister *> MoveTarget;
  if (moveList.find(vreg) != moveList.end()) {
    const auto &MovReg = moveList[vreg];
    for (auto v : MovReg) {
      auto def = v->GetDef();
      auto op = v->GetOperand(0);
      if (auto st = dynamic_cast<StackRegister *>(def)) {
        def = st->GetVreg();
      }
      if (auto st = dynamic_cast<StackRegister *>(op)) {
        op = st->GetVreg();
      }
      if (def == vreg) {
        if (auto p_op = dynamic_cast<PhyRegister *>(op))
          MoveTarget.insert(p_op);
      } else if (vreg == op) {
        if (auto p_def = dynamic_cast<PhyRegister *>(def))
          MoveTarget.insert(p_def);
      } else {
        // assert(0);
      }
    }
  }
  if (ty == riscv_i32 || ty == riscv_ptr || ty == riscv_i64) {
    if (!MoveTarget.empty()) {
      for (auto reg : MoveTarget) {
        if (assist.find(reg) != assist.end()) {
          return reg;
        }
      }
    }
    for (auto reg : reglist.GetReglistInt()) {
      if (assist.find(reg) != assist.end()) {
        return reg;
      }
    }
  } else if (ty == riscv_float32) {
    if (!MoveTarget.empty()) {
      for (auto reg : MoveTarget) {
        if (assist.find(reg) != assist.end()) {
          return reg;
        }
      }
    }
    for (auto reg : reglist.GetReglistFloat()) {
      if (assist.find(reg) != assist.end())
        return reg;
    }
  }
  assert(0);
}

void GraphColor::Print() {
  for (auto v : color) {
    if (dynamic_cast<VirRegister *>(v.first))
      std::cout << "Replace " << v.first->GetName() << "  with  "
                << v.second->GetName() << std::endl;
  }
}

void GraphColor::CaculateTopu(RISCVBasicBlock *mbb) {
  if (!assist.insert(mbb).second)
    return;
  for (auto des : SuccBlocks[mbb]) {
    CaculateTopu(des);
  }
  topu.push_back(mbb);
}

void GraphColor::GC_init() {
  ValsInterval.clear();
  freezeWorkList.clear();
  worklistMoves.clear();
  simplifyWorkList.clear();
  spillWorkList.clear();
  spilledNodes.clear();
  initial.clear();
  coalescedNodes.clear();
  constrainedMoves.clear();
  coalescedMoves.clear();
  frozenMoves.clear();
  coloredNode.clear();
  AdjList.clear();
  selectstack.clear();
  belongs.clear();
  activeMoves.clear();
  alias.clear();
  RegType.clear();
  // AlreadySpill.clear();
  InstLive.clear();
  Precolored.clear();
  color.clear();
  moveList.clear();
  instNum.clear();
  RegLiveness.clear();
  assist.clear();
  topu.clear();
}

std::set<MOperand> GraphColor::Adjacent(MOperand val) {
  std::set<MOperand> tmp;
  for (auto _val : AdjList[val]) {
    auto it_1 = std::find(selectstack.begin(), selectstack.end(), _val);
    if (it_1 == selectstack.end() &&
        coalescedNodes.find(_val) == coalescedNodes.end()) {
      tmp.insert(_val);
    }
  }
  return tmp;
}

void GraphColor::DecrementDegree(MOperand target) {
  Degree[target]--;
  //这里注意需要检查一下更新后的相邻边是否只有color-1
  if (target->GetType() == riscv_i32 || target->GetType() == riscv_ptr || riscv_i64) {
    if (Degree[target] == (GetRegNums(riscv_i32) - 1)) {
      auto x = Adjacent(target);
      std::unordered_set<MOperand> tmp(x.begin(), x.end());
      tmp.insert(target);
      // EnableMove
      for (auto node : tmp)
        for (auto mov : MoveRelated(node)) {
          if (activeMoves.find(mov) != activeMoves.end()) {
            activeMoves.erase(mov);
            PushVecSingleVal(worklistMoves, mov);
          }
        }
      spillWorkList.erase(target);
      if (MoveRelated(target).size() != 0) {
        freezeWorkList.insert(target);
      } else {
        simplifyWorkList.push_back(target);
      }
    }
  } else if (target->GetType() == riscv_float32) {
    if (Degree[target] == (GetRegNums(riscv_float32) - 1)) {
      auto x = Adjacent(target);
      std::unordered_set<MOperand> tmp(x.begin(), x.end());
      tmp.insert(target);
      // EnableMove
      for (auto node : tmp)
        for (auto mov : MoveRelated(node)) {
          if (activeMoves.find(mov) != activeMoves.end()) {
            activeMoves.erase(mov);
            PushVecSingleVal(worklistMoves, mov);
          }
        }
      spillWorkList.erase(target);
      if (MoveRelated(target).size() != 0) {
        freezeWorkList.insert(target);
      } else {
        simplifyWorkList.push_back(target);
      }
    }
  }
}

void GraphColor::CaculateSpillLiveness() {
  SpillToken.clear();
  int token = 0;
  if (spilledNodes.size() == 1) {
    SpillToken[*(spilledNodes.begin())] = token;
    return;
  }
  for (const auto spill : spilledNodes)
    for (const auto other : spilledNodes) {
      if (spill == other)
        continue;
      if (!IsHasInterference(spill, other)) {
        if (SpillToken.find(spill) == SpillToken.end() &&
            SpillToken.find(other) == SpillToken.end()) {
          SpillToken[spill] = token;
          SpillToken[other] = token++;
        } else if (SpillToken.find(spill) != SpillToken.end() &&
                   SpillToken.find(other) == SpillToken.end()) {
          SpillToken[other] = SpillToken[spill];
        } else if (SpillToken.find(spill) == SpillToken.end() &&
                   SpillToken.find(other) != SpillToken.end()) {
          SpillToken[spill] = SpillToken[other];
        }
      } else {
        if (SpillToken.find(spill) == SpillToken.end() &&
            SpillToken.find(other) == SpillToken.end()) {
          SpillToken[spill] = token++;
          SpillToken[other] = token++;
        } else if (SpillToken.find(spill) != SpillToken.end() &&
                   SpillToken.find(other) == SpillToken.end()) {
          SpillToken[other] = token++;
        } else if (SpillToken.find(spill) == SpillToken.end() &&
                   SpillToken.find(other) != SpillToken.end()) {
          SpillToken[spill] = token++;
        }
      }
    }
}

void GraphColor::LiveInfoInit()
{
    BlockLivein.clear();
    BlockLiveout.clear();
    BlockInfo.clear();
    RegLiveness.clear();
    instNum.clear();
    InstLive.clear();
    ValsInterval.clear();
    freezeWorkList.clear();
    worklistMoves.clear();
    simplifyWorkList.clear();
    spillWorkList.clear();
    spillWorkList.clear();
    spilledNodes.clear();
    initial.clear();
    coalescedNodes.clear();
    constrainedMoves.clear();
    coalescedMoves.clear();
    frozenMoves.clear();
    coloredNode.clear();
    AdjList.clear();
    selectstack.clear();
    belongs.clear();
    activeMoves.clear();
    alias.clear();
    RegType.clear();
    // AlreadySpill.clear();
    InstLive.clear();
    Precolored.clear();
    color.clear();
    moveList.clear();
    instNum.clear();
    RegLiveness.clear();
    assist.clear();
    Degree.clear();
    adjSet.clear();
    SpillStack.clear();
}