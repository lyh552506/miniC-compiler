#include "graph_draw.hpp"

// 可着色的数量K
#define K 10



// 寄存器集合(假设有6个可供分配的寄存器)
std::unordered_set<int> Reg = {1, 2, 3, 4, 5, 6};

// 机器寄存器的集合，每个寄存器都预先指派了一种颜色
std::unordered_set<_Node> Precolored;
// 临时寄存器集合，其中的元素既没有预着色，也没有被处理
std::unordered_set<_Node> initial;
// 低度数的传送无关节点表
std::list<_Node> simplifyWorkList;
// 低度数的传送有关节点表
std::unordered_set<_Node> freezeWorkLists;
// 高度数的节点表
std::unordered_set<_Node> spillWorkLists;
// 本轮中要溢出的节点集合
std::unordered_set<_Node> spilledNodes;
// 有可能合并的传送指令
std::list<Instruction> worklistMoves;
// 从一个结点到与该节点相关的传送指令表的映射
std::map<_Node, std::list<Instruction>> moveList;
// 图中冲突边的结合
std::unordered_map<_Node, _Node> AdjSet;
// 图的邻接表的表示

void start() {
  // LivenessAnalysis();
  Function function;
  Build(function);
  MakeWorkList();
  do {
    if (!simplifyWorkList.empty()) {
      Simplify();
    } else if (!worklistMoves.empty()) {
      coalesce();
    } else if (!freezeWorkLists.empty()) {
      Freeze();
    } else if (!spillWorkLists.empty()) {
      SelectSpill();
    }
  } while (!simplifyWorkList.empty() || !worklistMoves.empty() ||
           !freezeWorkLists.empty() || !spillWorkLists.empty());
  AssignColor();
  // 如果在colorassign的时候存在溢出
  if (!spilledNodes.empty()) {
    ReWriteProgram(
        spilledNodes); // 为被溢出的临时变量分配存储单元，并插入访问这些单元的存/取指令
    start();
  } else {
    simplifyInstr(); // 删除无用的move指令
    return;
  }
}

// 根据活跃性变量分析的结果构建冲突图（和位矩阵），并且初始化worklistmoves，使之包含程序之中所有的传送指令
void Build(Function &function) {
  // 遍历每一个basicblock
  for (auto block : function.bbs) {
    auto live = block.liveout;
    // 从后往前开始遍历BasicBlock里面的每个Instuction
    for (auto InstEnd = block.Inst.rbegin(); InstEnd != block.Inst.rend();
         InstEnd++) {
      Instruction &Inst = *InstEnd;
      std::unordered_set<_Node> use = GetInst_Use(Inst);
      _Node &def = GetInst_Def(Inst);
      std::unordered_set<_Node> combine;
      if (IsMoveInstruction(
              Inst)) { // TODO 这一处的实现需要处理后的inst，来查询是否是mov指令
        // TODO live<---live\use(I)

        combine.insert(def);
        combine.insert(use.begin(), use.end()); // 将mov指令的src和dst合并
        for (
            auto n :
            combine) { // 遍历这条指令的src和dst，并将这些结点加入到传送指令集合
          moveList[n].emplace_back(Inst);
        }
        worklistMoves.emplace_back(Inst);
      }
      // TODO live<--live加上def(l)
      // 对于每个当前的def内结点，他与目前的live都冲突
      for (auto l : live) {
        AddEdge(def, l);
      }
      // TODOlive<--use(I)加上(live-def(I))，即更新活跃变量
    }
  }
}

// TODO 判断是否为Move指令
bool IsMoveInstruction(Instruction &Inst) {
  //...........
  return true;
}

// 构建冲突边
void AddEdge(_Node &u, _Node &v) {
  if ((AdjSet[u] != v) && (u != v)) { // 构建冲突关系
    AdjSet[u] = v;
    AdjSet[v] = u;
    auto it1 = Precolored.find(u);
    auto it2 = Precolored.find(v);
    if (it1 != Precolored.end()) { // u不是预着色的机器寄存器
      u.Insert(v);
      u.AddDegree();
    }
    if (it2 != Precolored.end()) { // v不是预着色的机器寄存器
      v.Insert(u);
      v.AddDegree();
    }
  }
}

//给节点进行分类（预处理）
void MakeWorkList() {
  for (auto it = initial.begin(); it != initial.end();) {
    const _Node &node = *it;
    it = initial.erase(it); // erase 返回指向下一个元素的迭代器
    if (node.GetDegree() >= K) { // 归入到高度数结点
      spillWorkLists.emplace(node);
    } else if (IsMoveRelated(node)) {//归入到低度数的传送有关节点
      freezeWorkLists.emplace(node);
    } else{ //低度数的传送无关节点，可以简化
      simplifyWorkList.emplace_back(node);
    }
  }
}

//简化结点
void Simplify() {
    _Node& node=simplifyWorkList.front();
  
}

// 合并
void coalesce() {}

void Freeze() {}

void SelectSpill() {}

void AssignColor() {}

void ReWriteProgram(std::unordered_set<_Node> &myset) {}

// 获取指定指令的Use
std::unordered_set<_Node> GetInst_Use(Instruction &Inst) {}
// 获取指定指令的Def
_Node &GetInst_Def(Instruction &Inst) {}

bool IsMoveRelated(const _Node &node) {
  auto it=moveList.find(node);
  if(it!=moveList.end()&&!it->second.empty()){//当node存在于movelist并且对应的instruction不为空，此时可以判定他是传送相关结点
    return true;
  }
  return false;
}