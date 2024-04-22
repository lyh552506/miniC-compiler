#include <algorithm>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include "BaseCFG.hpp"
#include "Mcode.hpp"
#include "RegAlloc.hpp"
class GraphColor {
 public:
  GraphColor(MachineFunction* func, int K) : m_func(func), colors(K) {}
  void RunOnFunc();

 private:
  MachineFunction* m_func;
  int colors;
  void EliminatePhi();
  /// @brief 构建冲突图
  void Build();
  /// @brief 初始化各个工作表
  void MakeWorklist();
  bool IsMoveRelated(Operand v);
  void simplify();
  void coalesce();
  void freeze();
  void spill();
  enum MoveState { coalesced, constrained, frozen, worklist, active };
  // interference graph
  std::unordered_map<Operand, std::vector<RegInfo>> IG;
  // 低度数的传送有关节点表
  std::unordered_set<Operand> freezeWorkList;
  // 有可能合并的传送指令
  std::unordered_set<MachineInst*> worklistMoves;
  // 低度数的传送无关节点表
  std::unordered_set<Operand> simplifyWorkList;
  // 高度数的节点表
  std::unordered_set<Operand> spillWorkList;
  // 本轮中要溢出的节点集合
  std::unordered_set<Operand> spilledNodes;
  // 机器寄存器的集合，每个寄存器都预先指派了一种颜色
  std::unordered_set<Operand> Precolored;
  // 临时寄存器集合，其中的元素既没有预着色，也没有被处理
  std::unordered_set<Operand> initial;
  // 已合并的寄存器集合，当合并u<--v，将v加入到这个集合中，u则被放回到某个工作表中(或反之)
  std::unordered_set<Operand> coalescedNodes;
  //源操作数和目标操作数冲突的传送指令集合
  std::vector<MachineInst*> constrainedMoves;
  //已经合并的传送指令集合
  std::vector<MachineInst*> coalescedMoves;
  //已成功着色的结点集合
  std::unordered_set<Operand> coloredNode;
  // 从图中删除的临时变量的栈
  std::vector<Operand> selectstack;
  //查询每个传送指令属于哪一个集合
  std::unordered_map<MachineInst*, MoveState> belongs;
  // 从一个结点到与该节点相关的传送指令表的映射
  std::unordered_map<Operand, std::vector<MachineInst*>> moveList;
  // 还未做好准备的传送指令集合
  std::unordered_set<MachineInst*> activeMoves;
};

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
    else if (IsMoveRelated(node))
      freezeWorkList.insert(node);
    else
      simplifyWorkList.insert(node);
  }
}

bool GraphColor::IsMoveRelated(Operand v) {
  for (auto t : moveList) {
    auto move = t.second;
    for (auto inst : move) {
      if (activeMoves.find(inst) != activeMoves.end() ||
          worklistMoves.find(inst) != worklistMoves.end())
        return true;
    }
  }
  return false;
}

void GraphColor::simplify() {
  for (auto val : simplifyWorkList) {
    selectstack.push_back(val);
    //此时需要更新冲突图上和当前val相邻的边
    
  }
}