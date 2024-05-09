#include "RISCVMIR.hpp"
#include "RISCVRegister.hpp"
#include "RISCVType.hpp"
#include "RegAlloc.hpp"
#include <cassert>
#include <utility>

void GraphColor::RunOnFunc() {
  bool condition = true;
  for (auto mbb : *m_func) {
    CaculateLiveness(mbb);
    while (condition) {
      condition = false;
      CaculateLiveness(mbb);
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
      } while (!simplifyWorkList.empty() && !worklistMoves.empty() &&
               !freezeWorkList.empty() && !spillWorkList.empty());
      AssignColors();
      if (!spilledNodes.empty()) {
        RewriteProgram();
        condition = true;
      }
    }
  }
  liveinterval->blockinfo->PrintPass();
  liveinterval->PrintAnalysis();
}

void GraphColor::MakeWorklist() {
  for (auto node : initial) {
    //添加溢出节点
    if (node->GetType() == riscv_i32) {
      if (IG[node].size() > reglist.GetReglistParamInt().size())
        spilledNodes.insert(node);
      else if (MoveRelated(node).size() != 0)
        freezeWorkList.insert(node);
      else
        simplifyWorkList.push_back(node);
    } else if (node->GetType() == riscv_float32) {
      if (IG[node].size() > reglist.GetReglistParamFloat().size())
        spilledNodes.insert(node);
      else if (MoveRelated(node).size() != 0)
        freezeWorkList.insert(node);
      else
        simplifyWorkList.push_back(node);
    }
  }
}

std::unordered_set<RISCVMIR *> GraphColor::MoveRelated(MOperand v) {
  std::unordered_set<RISCVMIR *> tmp;
  for (auto t : moveList) {
    auto move = t.second;
    for (auto inst : move) {
      auto iter = std::find(worklistMoves.begin(), worklistMoves.end(), inst);
      if (activeMoves.find(inst) != activeMoves.end() ||
          iter != worklistMoves.end())
        tmp.insert(inst);
    }
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
      if (IG[tmp].size() < reglist.GetReglistParamInt().size())
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
      if (IG[tmp].size() < reglist.GetReglistParamFloat().size())
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
      if (IG[node].size() >= reglist.GetReglistParamInt().size())
        num++;
    }
    return (num < colors);
  } else if (ty == riscv_float32) {
    int num = 0;
    for (auto node : target) {
      if (IG[node].size() >= reglist.GetReglistParamFloat().size())
        num++;
    }
    return (num < colors);
  } else
    assert(0 && "tpre must be either int or float");
}

void GraphColor::AddWorkList(MOperand v) {
  if (Precolored.find(v) != Precolored.end() && IG[v].size() < colors &&
      MoveRelated(v).size() == 0) {
    freezeWorkList.erase(v);
    PushVecSingleVal(simplifyWorkList, v);
  }
}

void GraphColor::CaculateLiveness(RISCVBasicBlock *mbb) {
  liveinterval->blockinfo->RunOnFunction();
  //计算IG,并且添加precolored集合
  CalInstLive(mbb);
  CalcmoveList(mbb);
  CalcIG(mbb);
  liveinterval->RunOnFunc();
  //计算区间并存入
  auto IntervInfo = liveinterval->GetRegLiveInterval(mbb);
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
MOperand GraphColor::HeuristicFreeze() {}

// rd <-rs变成 rs(rs)
void GraphColor::combine(MOperand rd, MOperand rs, RISCVType ty) {
  if (ty == riscv_i32) {
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
      if (IG[neighbor].size() == reglist.GetReglistParamInt().size() - 1) {
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
    if (IG[rd].size() >= reglist.GetReglistParamInt().size() &&
        freezeWorkList.find(rd) != freezeWorkList.end()) {
      freezeWorkList.erase(rd);
      spillWorkList.insert(rd);
    }
  } else if (ty == riscv_float32) {
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
      if (IG[neighbor].size() == reglist.GetReglistParamFloat().size() - 1) {
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
    if (IG[rd].size() >= reglist.GetReglistParamFloat().size() &&
        freezeWorkList.find(rd) != freezeWorkList.end()) {
      freezeWorkList.erase(rd);
      spillWorkList.insert(rd);
    }
  }
}

void GraphColor::FreezeMoves(MOperand freeze) {
  for (auto mov : MoveRelated(freeze)) {
    // mov: dst<-src
    MOperand dst = dynamic_cast<MOperand>(mov->GetDef());
    MOperand src = nullptr;
    MOperand value;
    //找到除了freeze的另外一个操作数
    if (GetAlias(src) == GetAlias(freeze)) {
      value = GetAlias(dst);
    } else {
      value = GetAlias(src);
    }
    activeMoves.erase(mov);
    frozenMoves.insert(mov);
    if (MoveRelated(value).size() == 0 && IG[value].size() < colors) {
      freezeWorkList.erase(value);
      PushVecSingleVal(simplifyWorkList, value);
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
      if (IG[target].size() == colors - 1) {
        spillWorkList.erase(target);
        std::unordered_set<MOperand> tmp(IG[target].begin(), IG[target].end());
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
      combine(m.first, m.second, m.second->GetType());
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

// TODO waiting for the construct of backend
void GraphColor::AssignColors() {
  while (!selectstack.empty()) {
    MOperand select = selectstack.back();
    selectstack.pop_back();
    std::vector<PhyRegister *> assist(colors);
    //遍历所有的冲突点，查看他们分配的颜色，保证我们分配的颜色一定是不同的
    for (auto adj : IG[select])
      if (coloredNode.find(GetAlias(adj)) != coloredNode.end() ||
          Precolored.find(GetAlias(adj)) != Precolored.end()) {
        // TODO we loss the map with MOperand to Reg
      }
    bool flag = false;
    // std::for_each(assist.begin(), assist.end(), [&flag]() {

    // });
  }
}

void GraphColor::RewriteProgram() {
  for (auto spilled : spilledNodes) {
    // TODO 创建临时变量寄存器的接口
  }
}