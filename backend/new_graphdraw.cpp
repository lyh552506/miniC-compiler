#include "RISCVMIR.hpp"
#include "RISCVRegister.hpp"
#include "RISCVType.hpp"
#include "RegAlloc.hpp"
#include <cassert>
#include <unordered_set>

void GraphColor::RunOnFunc() {
  bool condition = true;
  CaculateLiveness();
  for (auto &[key, val] : IG) {
    AdjList[key].insert(val.begin(), val.end());
  }
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
    AssignColors();
    if (!spilledNodes.empty()) {
      SpillNodeInMir();
      condition = true;
    }
  }
  RewriteProgram();
  PrintPass();
  PrintAnalysis();
}

void GraphColor::MakeWorklist() {
  for (auto node : initial) {
    //添加溢出节点
    if (IG[node].size() > GetRegNums(node))
      spilledNodes.insert(node);
    else if (MoveRelated(node).size() != 0)
      freezeWorkList.insert(node);
    else
      simplifyWorkList.push_back(node);
  }
}

std::unordered_set<RISCVMIR *> GraphColor::MoveRelated(MOperand v) {
  std::unordered_set<RISCVMIR *> tmp;
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
  if (ty == riscv_i32) {
    for (auto tmp : IG[src]) {
      bool ok = false;
      if (IG[tmp].size() < reglist.GetReglistInt().size())
        ok |= true;
      if (Precolored.find(tmp) != Precolored.end())
        ok |= true;
      auto &adj = IG[dst];
      auto iter = std::find(adj.begin(), adj.end(), tmp);
      if (iter != adj.end())
        ok |= true;
      if (ok != true)
        return false;
    }
  } else if (ty == riscv_float32) {
    for (auto tmp : IG[src]) {
      bool ok = false;
      if (IG[tmp].size() < reglist.GetReglistFloat().size())
        ok |= true;
      if (Precolored.find(tmp) != Precolored.end())
        ok |= true;
      auto &adj = IG[dst];
      auto iter = std::find(adj.begin(), adj.end(), tmp);
      if (iter != adj.end())
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
bool GraphColor::BriggsCheck(std::unordered_set<MOperand> target,
                             RISCVType ty) {
  if (ty == riscv_i32) {
    int num = 0;
    for (auto node : target) {
      if (IG[node].size() >= reglist.GetReglistInt().size())
        num++;
    }
    return (num < reglist.GetReglistInt().size());
  } else if (ty == riscv_float32) {
    int num = 0;
    for (auto node : target) {
      if (IG[node].size() >= reglist.GetReglistFloat().size())
        num++;
    }
    return (num < reglist.GetReglistFloat().size());
  } else
    assert(0 && "tpre must be either int or float");
}

void GraphColor::AddWorkList(MOperand v) {
  if (Precolored.find(v) == Precolored.end() && IG[v].size() < GetRegNums(v) &&
      MoveRelated(v).size() == 0) {
    freezeWorkList.erase(v);
    PushVecSingleVal(simplifyWorkList, v);
  }
}

void GraphColor::CaculateLiveness() {
  RunOnFunction();
  //计算IG,并且添加precolored集合
  for (auto b : *m_func) {
    CalInstLive(b);
    CalcmoveList(b);
    CalcIG(b);
  }
  RunOnFunc_();
}

void GraphColor::CaculateLiveInterval(RISCVBasicBlock *mbb) {
  //计算区间并存入
  RunOnFunc_();
  auto &IntervInfo = GetRegLiveInterval(mbb);
  for (auto &[val, vec] : IntervInfo) {
    unsigned int length = 0;
    for (auto v : vec)
      length += v.end - v.start;
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
  int max = 0;
  for (auto spill : spillWorkList) {
    float weight = 0;
    //考虑degree
    int degree = IG[spill].size();
    weight += (degree * DegreeWeight) << 2;
    //考虑interval区间
    int intervalLength = ValsInterval[spill];
    weight += (intervalLength * livenessWeight) << 3;
    //考虑嵌套层数
    int loopdepth; // TODO
    // weight /= std::pow(LoopWeight, loopdepth);
  }
}

// TODO选择freeze node的启发式函数
/*
 */
MOperand GraphColor::HeuristicFreeze() { return *(freezeWorkList.begin()); }

void GraphColor::SetRegState(PhyRegister *reg, RISCVType ty) {
  RegType[reg] = ty;
}

int GraphColor::GetRegNums(MOperand v) {
  if (v->GetType() == riscv_i32 || v->GetType() == riscv_ptr)
    return reglist.GetReglistInt().size();
  else if (v->GetType() == riscv_float32)
    return reglist.GetReglistFloat().size();
  else if (v->GetType() == riscv_none) {
    auto preg = dynamic_cast<PhyRegister *>(v);
    auto tp = RegType[preg];
    assert(tp == 0 && "error");
    return tp == riscv_i32 ? reglist.GetReglistInt().size()
                           : reglist.GetReglistFloat().size();
  } else {
    assert("excetion case");
  }
}

int GraphColor::GetRegNums(RISCVType ty) {
  if (ty == riscv_i32 || ty == riscv_ptr)
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
  //更新已合并点的所有临边(DecrementDegree)
  for (int i = 0; i != IG[rs].size(); i++) {
    MOperand neighbor = IG[rs][i];
    PushVecSingleVal(IG[rd], neighbor);
    auto iter = std::find(IG[neighbor].begin(), IG[neighbor].end(), rs);
    if (iter == IG[neighbor].end())
      assert(0 && "wrong with ig");
    IG[neighbor].erase(iter);
    vec_pop(IG[rs], i);
    //减去边后度数恰好不是高度数
    if (IG[neighbor].size() == GetRegNums(rs) - 1) {
      spillWorkList.erase(neighbor);
      std::unordered_set<MOperand> tmp(IG[neighbor].begin(),
                                       IG[neighbor].end());
      tmp.insert(neighbor);
      for (auto node : tmp)
        for (auto mov : MoveRelated(node)) {
          if (activeMoves.find(mov) != activeMoves.end()) {
            activeMoves.erase(mov);
            PushVecSingleVal(worklistMoves, mov);
          }
        }
      if (!MoveRelated(neighbor).empty()) {
        freezeWorkList.insert(neighbor);
      } else {
        PushVecSingleVal(simplifyWorkList, neighbor);
      }
    }
  }
  if (IG[rd].size() >= GetRegNums(rs) &&
      freezeWorkList.find(rd) != freezeWorkList.end()) {
    freezeWorkList.erase(rd);
    spillWorkList.insert(rd);
  }
}

void GraphColor::FreezeMoves(MOperand freeze) {
  for (auto mov : MoveRelated(freeze)) {
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
      if (value->GetType() == riscv_i32 &&
              IG[value].size() < reglist.GetReglistInt().size() ||
          value->GetType() == riscv_float32 &&
              IG[value].size() < reglist.GetReglistFloat().size()) {
        freezeWorkList.erase(value);
        PushVecSingleVal(simplifyWorkList, value);
      } else {
        assert(0 && "appear riscv_none");
      }
    }
  }
}

void GraphColor::simplify() {
  for (int i = 0; i < simplifyWorkList.size(); i++) {
    auto val = simplifyWorkList[i];
    int size = simplifyWorkList.size();
    simplifyWorkList[i] = simplifyWorkList[size - 1];
    simplifyWorkList.pop_back();
    selectstack.push_back(val);
    //此时需要更新冲突图上和当前val相邻的边(DecrementDegree)
    for (int i = 0; i < IG[val].size(); i++) {
      auto target = IG[val][i];
      auto iter = std::find(IG[target].begin(), IG[target].end(), val);
      if (iter == IG[target].end())
        assert(0 && "wrong with ig");
      IG[target].erase(iter);
      vec_pop(IG[val], i);
      //这里注意需要检查一下更新后的相邻边是否只有color-1
      if (target->GetType() == riscv_i32 || target->GetType() == riscv_ptr) {
        if (IG[target].size() == GetRegNums(riscv_i32) - 1) {
          spillWorkList.erase(target);
          std::unordered_set<MOperand> tmp(IG[target].begin(),
                                           IG[target].end());
          tmp.insert(target);
          // EnableMove
          for (auto node : tmp)
            for (auto mov : MoveRelated(node)) {
              if (activeMoves.find(mov) != activeMoves.end()) {
                activeMoves.erase(mov);
                PushVecSingleVal(worklistMoves, mov);
              }
            }
          if (MoveRelated(target).size() != 0) {
            freezeWorkList.insert(target);
          } else {
            simplifyWorkList.push_back(target);
          }
        }
      } else if (target->GetType() == riscv_float32) {
        if (IG[target].size() == reglist.GetReglistFloat().size() - 1) {
          spillWorkList.erase(target);
          std::unordered_set<MOperand> tmp(IG[target].begin(),
                                           IG[target].end());
          tmp.insert(target);
          // EnableMove
          for (auto node : tmp)
            for (auto mov : MoveRelated(node)) {
              if (activeMoves.find(mov) != activeMoves.end()) {
                activeMoves.erase(mov);
                PushVecSingleVal(worklistMoves, mov);
              }
            }
          if (MoveRelated(target).size() != 0) {
            freezeWorkList.insert(target);
          } else {
            simplifyWorkList.push_back(target);
          }
        }
      } else {
        // assert(0 && "appear riscv_none");
      }
    }
  }
}

void GraphColor::coalesce() {
  // only consider the mv inst in worklistmoves
  for (int i = 0; i < worklistMoves.size(); i++) {
    using MoveOperand = std::pair<MOperand, MOperand>;
    MoveOperand m;
    RISCVMIR *mv = worklistMoves[i];
    // rd <- rs
    MOperand rd = dynamic_cast<MOperand>(mv->GetDef());
    MOperand rs = dynamic_cast<MOperand>(mv->GetOperand(0));
    rd = GetAlias(rd);
    rs = GetAlias(rs);
    if (Precolored.find(rs) != Precolored.end()) {
      m = std::make_pair(rs, rd);
    } else {
      m = std::make_pair(rd, rs);
    }
    vec_pop(worklistMoves, i);
    moveList[rs].erase(mv);
    moveList[rd].erase(mv);
    auto iter = std::find(IG[rs].begin(), IG[rs].end(), rd);
    std::unordered_set<MOperand> Adjset(IG[rs].begin(), IG[rs].end());
    for (auto tmp : IG[rd])
      Adjset.insert(tmp);
    if (m.first == m.second) {
      // means we use the : r1 <- r1 ,chich can be simplify
      coalescedMoves.push_back(mv);
      AddWorkList(m.first);
    } else if (Precolored.find(m.second) != Precolored.end() ||
               iter != IG[rs].end()) {
      // two oprand are all reg or the rs and rd are in IG
      constrainedMoves.insert(mv);
      AddWorkList(m.first);
      AddWorkList(m.second);
    } else if ((Precolored.find(m.first) != Precolored.end() &&
                GeorgeCheck(m.second, m.first, m.second->GetType())) ||
               (Precolored.find(m.first) == Precolored.end() &&
                BriggsCheck(Adjset, m.first->GetType()))) {
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
  spillWorkList.erase(spill);
  PushVecSingleVal(simplifyWorkList, spill);
  FreezeMoves(spill);
}

void GraphColor::AssignColors() {
  while (!selectstack.empty()) {
    MOperand select = selectstack.back();
    RISCVType ty = select->GetType();
    selectstack.pop_back();
    std::unordered_set<MOperand> int_assist{reglist.GetReglistInt().begin(),
                                            reglist.GetReglistInt().end()};
    std::unordered_set<MOperand> float_assist{reglist.GetReglistFloat().begin(),
                                              reglist.GetReglistFloat().end()};
    //遍历所有的冲突点，查看他们分配的颜色，保证我们分配的颜色一定是不同的
    for (auto adj : AdjList[select])
      if (coloredNode.find(GetAlias(adj)) != coloredNode.end() ||
          Precolored.find(GetAlias(adj)) != Precolored.end()) {
        if (ty == riscv_i32 || ty == riscv_ptr)
          int_assist.erase(color[adj]);
        else if (ty == riscv_float32)
          float_assist.erase(color[adj]);
      }
    bool flag = false;
    if (ty == riscv_i32 || ty == riscv_ptr) {
      if (int_assist.size() == 0)
        spilledNodes.insert(select);
      else {
        coloredNode.insert(select);
        color[select] = SelectPhyReg(ty, int_assist);
      }
    } else if (ty == riscv_float32) {
      if (float_assist.size() == 0)
        spillWorkList.insert(select);
      else {
        coalescedNodes.insert(select);
        color[select] = SelectPhyReg(ty, float_assist);
      }
    }
  }
  for (auto caols : coalescedNodes)
    color[caols] = color[GetAlias(caols)];
}

void GraphColor::SpillNodeInMir() {
  std::unordered_set<MOperand> temps;
  AlreadySpill.clear();
  for (auto mbb : *m_func) {
    for (auto mir_begin = mbb->begin(), mir_end = mbb->end();
         mir_begin != mir_end;) {
      auto mir = *mir_begin;
      if (mir->GetDef() != nullptr && dynamic_cast<MOperand>(mir->GetDef()) &&
          (spilledNodes.find(dynamic_cast<MOperand>(mir->GetDef())) !=
           spilledNodes.end()) &&
          AlreadySpill.find(dynamic_cast<MOperand>(mir->GetDef())) ==
              AlreadySpill.end()) {
        //存在def并且def是一个准备spill节点
        RISCVMIR *sd = CreateSpillMir(mir->GetDef());
        mir_begin.insert_after(sd);
        temps.insert(dynamic_cast<MOperand>(sd->GetOperand(1)));
      } else if (mir->GetDef() != nullptr &&
                 dynamic_cast<MOperand>(mir->GetDef()) &&
                 (spilledNodes.find(dynamic_cast<MOperand>(mir->GetDef())) !=
                  spilledNodes.end())) {
        //存在def并且def是一个已经spill节点
        RISCVMIR *ld = CreateLoadMir(dynamic_cast<MOperand>(mir->GetDef()));
        mir_begin.insert_before(ld);
        mir->SetDef(ld->GetDef());
        temps.insert(dynamic_cast<MOperand>(ld->GetDef()));
      } else {
        for (int i = 0; i < mir->GetOperandSize(); i++) {
          if (mir->GetOperand(i) != nullptr &&
              dynamic_cast<MOperand>(mir->GetOperand(i)) &&
              (spilledNodes.find(dynamic_cast<MOperand>(mir->GetOperand(i))) !=
               spilledNodes.end()) &&
              AlreadySpill.find(dynamic_cast<MOperand>(mir->GetOperand(i))) ==
                  AlreadySpill.end()) {
            RISCVMIR *sd = CreateSpillMir(mir->GetOperand(i));
            mir_begin.insert_after(sd);
            temps.insert(dynamic_cast<MOperand>(sd->GetOperand(1)));
          } else if (mir->GetOperand(i) != nullptr &&
                     dynamic_cast<MOperand>(mir->GetOperand(i)) &&
                     (spilledNodes.find(dynamic_cast<MOperand>(
                          mir->GetOperand(i))) != spilledNodes.end())) {
            RISCVMIR *ld = CreateLoadMir(mir->GetOperand(i));
            mir_begin.insert_before(ld);
            mir->SetOperand(i, ld->GetDef());
            temps.insert(dynamic_cast<MOperand>(ld->GetDef()));
          }
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

RISCVMIR *GraphColor::CreateSpillMir(RISCVMOperand *spill) {
  auto vreg = dynamic_cast<VirRegister *>(spill);
  assert(vreg && "the chosen operand must be a vreg");
  assert(AlreadySpill.find(vreg) == AlreadySpill.end() && "no spill before");
  RISCVMIR *sd = new RISCVMIR(RISCVMIR::RISCVISA::_sd);
  auto spillnode = m_func->GetFrame()->spill(vreg);
  sd->AddOperand(spillnode);
  sd->AddOperand(vreg);
  AlreadySpill[vreg] = sd;
  return sd;
}

RISCVMIR *GraphColor::CreateLoadMir(RISCVMOperand *load) {
  auto vreg = dynamic_cast<VirRegister *>(load);
  assert(vreg && "the chosen operand must be a vreg");
  assert(AlreadySpill.find(vreg) == AlreadySpill.end() && "no spill before");
  VirRegister *reg = new VirRegister(vreg->GetType());
  RISCVMIR *lw = new RISCVMIR(RISCVMIR::RISCVISA::_ld);
  auto loadnode = AlreadySpill[vreg]->GetOperand(0);
  lw->SetDef(reg);
  lw->AddOperand(loadnode);
  return lw;
}

void GraphColor::RewriteProgram() {
  for (auto mbb : *m_func) {
    for (auto mir : *mbb) {
      if (mir->GetDef() != nullptr &&
          dynamic_cast<VirRegister *>(mir->GetDef())) {
        auto replace = color[dynamic_cast<MOperand>(mir->GetDef())];
#ifdef DEBUG
        std::cerr << "REPLACE Vreg "
                  << dynamic_cast<VirRegister *>(mir->GetDef())->GetName()
                  << " To Preg " << replace->GetName() << std::endl;
#endif
        mir->SetDef(replace);
      }
      for (int i = 0; i < mir->GetOperandSize(); i++) {
        auto operand = mir->GetOperand(i);
        if (dynamic_cast<VirRegister *>(operand)) {
          auto replace = color[dynamic_cast<MOperand>(operand)];
#ifdef DEBUG
          std::cerr << "REPLACE Vreg "
                    << dynamic_cast<VirRegister *>(operand)->GetName()
                    << " To Preg " << replace->GetName() << std::endl;
#endif
          mir->SetOperand(i, replace);
        }
      }
    }
  }
}

//单独抽离成一个函数，后续有调用规约修改的时候我们再更改
PhyRegister *GraphColor::SelectPhyReg(RISCVType ty,
                                      std::unordered_set<MOperand> &assist) {
  if (ty == riscv_i32 || ty == riscv_ptr) {
    for (auto reg : reglist.GetReglistInt()) {
      if (assist.find(reg) != assist.end())
        return reg;
    }
  } else if (ty == riscv_float32) {
    for (auto reg : reglist.GetReglistFloat()) {
      if (assist.find(reg) != assist.end())
        return reg;
    }
  } else {
    assert(0);
  }
}

void GraphColor::Print() {
  for (auto v : color) {
    if (dynamic_cast<VirRegister *>(v.first))
      std::cerr << "Replace " << v.first->GetName() << "  with  "
                << v.second->GetName() << std::endl;
  }
}