// #include "livenessalysis.hpp"
#include <list>
#include <map>
#include <stack>
#include <string>
#include <unordered_set>
#include <vector>
#include<unordered_map>

enum {
  mov,
  add,
  sub,
  assign,
};

/// @brief 节点类
class _Node {
public:

  _Node():varName{},degree{0}
  {};

  
  enum NodeType {
    spillednode,
    coalescednode,
    colorednode,
  };
  
  bool operator==(const _Node &other)const {
    return other.varName==varName;
  }

  bool operator!=(const _Node &other)const{
    return other.varName!=varName;
  }

  bool operator<(const _Node& other)const {
    return varName<other.varName; 
  }
  char* varName;

  void Insert(_Node& node){
    AdjList.emplace_back(node);
  }

  void AddDegree(){
    degree++;
  }

  int GetDegree() const{
    return degree;
  }

private:
  //std::unordered_set<_Node> AdjSet;//图中冲突边的结合
  int degree{0};//当前结点
  std::list<_Node>AdjList;
};


namespace std {
    template <>
    struct hash<_Node> {
        std::size_t operator()(const _Node& node) const noexcept {
            // 直接使用 std::string 的哈希函数
            return std::hash<std::string>{}(node.varName);
        }
    };
}
struct Instruction {
  int type; // 操作数的类型，是否为move？
  std::string def;
  std::vector<std::string> use;
};

struct BasicBlock {

  std::unordered_set<_Node> liveout; // 记录每一个块的liveout
  std::list<Instruction> Inst;
};

struct Function {
  std::vector<BasicBlock> bbs;
};



/// @brief 低度数的传送无关节点表
// class _simplifyWorkLists {
// public:
//   _simplifyWorkLists() = default;

//   std::unordered_set<_Node> GetLists() { return list; }

// private:
//   std::unordered_set<_Node> list;
// };

// /// @brief 包含从图中删除的临时变量的栈
// class selectStack {
// public:
//   selectStack() = default;

// private:
//   std::stack<_Node> slectNode;
// };

// /// @brief 低度数的但与传送有关的节点表
// class freezeWorklists {

// private:
//   std::unordered_set<_Node> list;
// };

// /// @brief 高度数的节点表
// class spillWorklists {

// private:
//   std::unordered_set<_Node> list;
// };

// /// @brief 在本轮中需要溢出的节点表，每次初始化为空
// class spilledWorklists {
// public:
//   void refresh() { list.clear(); }

// private:
//   std::unordered_set<_Node> list;
// };

// /// @brief 已成功着色的节点集合
// class coloredNode {

// private:
//   std::unordered_set<_Node> nodelist;
// };

// class WorkListsMoves {

// private:
//   std::unordered_set<Instruction *> list;
// };

// TODO 首先构造冲突图，把每个节点分为传送有关和传送无关
void Build(Function &function);
void Simplify();
void coalesce();
void Freeze();
void SelectSpill();
void start();
void MakeWorkList();
void AssignColor();
void ReWriteProgram(std::unordered_set<_Node> &myset);
bool IsMoveInstruction(Instruction &Inst);
void simplifyInstr();
void AddEdge(_Node& u,_Node& v);
std::unordered_set<_Node> GetInst_Use(Instruction &Inst);
_Node& GetInst_Def(Instruction &Inst);
bool IsMoveRelated(const _Node& node);