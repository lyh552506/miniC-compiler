#include <algorithm>
#include <cassert>
#include <functional>
#include <optional>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#include "BaseCFG.hpp"
#include "Mcode.hpp"
#include "RegAlloc.hpp"
#include "my_stl.hpp"
// class GraphColor {
//  public:
//   GraphColor(MachineFunction* func, int K) : m_func(func), colors(K) {}
//   void RunOnFunc();

//  private:
//   MachineFunction* m_func;
//   int colors;
//   void EliminatePhi();
//   /// @brief 构建冲突图
//   void Build();
//   /// @brief 初始化各个工作表
//   void MakeWorklist();
//   //返回vector为0则不是move相关
//   std::unordered_set<MachineInst*> MoveRelated(Operand v);
//   void simplify();
//   void coalesce();
//   void freeze();
//   void spill();
//   bool GeorgeCheck(Operand dst, Operand src);
//   bool BriggsCheck(std::unordered_set<Operand> target);
//   void AddWorkList(Operand v);
//   void combine(Operand rd, Operand rs);
//   Operand GetAlias(Operand v);
//   enum MoveState { coalesced, constrained, frozen, worklist, active };
//   // interference graph
//   std::unordered_map<Operand, std::vector<Operand>> IG;
//   // 低度数的传送有关节点表
//   std::unordered_set<Operand> freezeWorkList;
//   // 有可能合并的传送指令
//   std::vector<MachineInst*> worklistMoves;
//   // 低度数的传送无关节点表
//   std::vector<Operand> simplifyWorkList;
//   // 高度数的节点表
//   std::unordered_set<Operand> spillWorkList;
//   // 本轮中要溢出的节点集合
//   std::unordered_set<Operand> spilledNodes;
//   // 机器寄存器的集合，每个寄存器都预先指派了一种颜色
//   std::unordered_set<Operand> Precolored;
//   // 临时寄存器集合，其中的元素既没有预着色，也没有被处理
//   std::unordered_set<Operand> initial;
//   // 已合并的寄存器集合，当合并u<--v，将v加入到这个集合中，u则被放回到某个工作表中(或反之)
//   std::unordered_set<Operand> coalescedNodes;
//   //源操作数和目标操作数冲突的传送指令集合
//   std::unordered_set<MachineInst*> constrainedMoves;
//   //已经合并的传送指令集合
//   std::vector<MachineInst*> coalescedMoves;
//   //已成功着色的结点集合
//   std::unordered_set<Operand> coloredNode;
//   // 从图中删除的临时变量的栈
//   std::vector<Operand> selectstack;
//   //查询每个传送指令属于哪一个集合
//   std::unordered_map<MachineInst*, MoveState> belongs;
//   // 从一个结点到与该节点相关的传送指令表的映射
//   std::unordered_map<Operand, std::unordered_set<MachineInst*>> moveList;
//   // 还未做好准备的传送指令集合
//   std::unordered_set<MachineInst*> activeMoves;
//   //合并后的别名管理
//   std::unordered_map<Operand, Operand> alias;
// };

void GraphColor::RunOnFunc() {
  Build();
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
  } while (simplifyWorkList.empty() && worklistMoves.empty());
}

void GraphColor::MakeWorklist() {
  for (auto node : initial) {
    //添加溢出节点
    if (IG[node].size() > colors)
      spilledNodes.insert(node);
    else if (MoveRelated(node).size() != 0)
      freezeWorkList.insert(node);
    else
      simplifyWorkList.push_back(node);
  }
}

std::unordered_set<MachineInst*> GraphColor::MoveRelated(Operand v) {
  std::unordered_set<MachineInst*> tmp;
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

Operand GraphColor::GetAlias(Operand v) {
  //当前v存在于coalescedNodes，则返回v的alias
  if (coalescedNodes.find(v) != coalescedNodes.end()) {
    return GetAlias(alias[v]);
  } else {
    return v;
  }
}

//实行George的启发式合并
bool GraphColor::GeorgeCheck(Operand dst, Operand src) {
  for (auto tmp : IG[src]) {
    bool ok = false;
    if (IG[tmp].size() < colors) ok |= true;
    if (Precolored.find(tmp) != Precolored.end()) ok |= true;
    auto& adj = IG[dst];
    auto iter = std::find(adj.begin(), adj.end(), tmp);
    if (iter != adj.end()) ok |= true;
    if (ok != true) return false;
  }
  return true;
}
//实行Briggs的启发合并
bool GraphColor::BriggsCheck(std::unordered_set<Operand> target) {
  int num = 0;
  for (auto node : target) {
    if (IG[node].size() >= colors) num++;
  }
  return (num < colors);
}

void GraphColor::AddWorkList(Operand v) {
  if (Precolored.find(v) != Precolored.end() && IG[v].size() < colors &&
      MoveRelated(v).size() == 0) {
    freezeWorkList.erase(v);
    PushVecSingleVal(simplifyWorkList, v);
  }
}
// rd <-rs变成 rs(rs)
void GraphColor::combine(Operand rd, Operand rs) {
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
    Operand neighbor = IG[rs][i];
    PushVecSingleVal(IG[rd], neighbor);
    auto iter = std::find(IG[neighbor].begin(), IG[neighbor].end(), rs);
    if (iter == IG[neighbor].end()) assert(0 && "wrong with ig");
    IG[neighbor].erase(iter);
    vec_pop(IG[rs], i);
    //减去边后度数恰好不是高度数
    if (IG[neighbor].size() == colors - 1) {
      spillWorkList.erase(neighbor);
      std::unordered_set<Operand> tmp(IG[neighbor].begin(), IG[neighbor].end());
      tmp.insert(neighbor);
      for (auto node : tmp)
        for (auto mov : MoveRelated(node)) {
          if (activeMoves.find(mov) != activeMoves.end()) {
            activeMoves.erase(mov);
            PushVecSingleVal(worklistMoves, mov);
          }
        }
      if(!MoveRelated(neighbor).empty()){
        freezeWorkList.insert(neighbor);
      }else{
        PushVecSingleVal(simplifyWorkList,neighbor);
      }
    }
  }
  if(IG[rd].size()>=colors&&freezeWorkList.find(rd)!=freezeWorkList.end()){
    freezeWorkList.erase(rd);
    spillWorkList.insert(rd);
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
      if (iter == IG[target].end()) assert(0 && "wrong with ig");
      IG[target].erase(iter);
      vec_pop(IG[val], i);
      //这里注意需要检查一下更新后的相邻边是否只有color-1
      if (IG[target].size() == colors - 1) {
        spillWorkList.erase(target);
        std::unordered_set<Operand> tmp(IG[target].begin(), IG[target].end());
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
    MachineInst* mv = worklistMoves[i];
    // rd <- rs
    Operand rd = mv->GetRd();
    Operand rs = mv->GetRs1();
    rd = GetAlias(rd);
    rs = GetAlias(rs);
    if (Precolored.find(rs) != Precolored.end()) {
      std::swap(rd, rs);
    }
    vec_pop(worklistMoves, i);
    moveList[rs].erase(mv);
    moveList[rd].erase(mv);
    auto iter = std::find(IG[rs].begin(), IG[rs].end(), rd);
    std::unordered_set<Operand> Adjset(IG[rs].begin(), IG[rs].end());
    for (auto tmp : IG[rd]) Adjset.insert(tmp);
    if (rd == rs) {
      // means we use the : r1 <- r1 ,chich can be simplify
      coalescedMoves.push_back(mv);
      AddWorkList(rd);
    } else if (Precolored.find(rs) != Precolored.end() ||
               iter != IG[rs].end()) {
      // two oprand are all reg or the rs and rd are in IG
      constrainedMoves.insert(mv);
      AddWorkList(rs);
      AddWorkList(rd);
    } else if ((Precolored.find(rs) != Precolored.end() &&
                GeorgeCheck(rd, rs)) ||
               (Precolored.find(rs) == Precolored.end() &&
                BriggsCheck(Adjset))) {
      coalescedMoves.push_back(mv);
      combine(rd, rs);
      AddWorkList(rd);
    } else {
      //不满足我们的合并情况
      activeMoves.insert(mv);
    }
  }
}