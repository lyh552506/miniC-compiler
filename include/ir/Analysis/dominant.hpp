#pragma once
#include <algorithm>
#include <forward_list>
#include <iostream>
#include <iterator>
#include <list>
#include <memory.h>
#include <queue>
#include <set>
#include <typeinfo>
#include <unordered_set>
#include <utility>
#include <vector>

#include "../../lib/CFG.hpp"
#include "../opt/PassManagerBase.hpp"
#include "../../../util/my_stl.hpp"

class dominance : public _AnalysisManagerBase<dominance, Function> {
  friend class IDF;

public:
  class DSU { //并查集实现路径压缩
  public:
    int ancestor;
    int min_sdom;
    void init() {
      ancestor = 0;
      min_sdom = 0;
    }
  };
  class Node {
  public:
    int dfnum;  //记录dfs序
    int father; //此处是dfs序中遍历的father，区别rev链表
    int sdom;
    int idom; // 记录支配树父亲节点
    int DfsIn, DfsOut;
    int visited;
    BasicBlock *thisBlock;
    std::forward_list<int> des;        // 记录该结点的下一个结点
    std::forward_list<int> rev;        // 记录该节点的上一个结点
    std::forward_list<int> idom_child; // 支配树上的孩子
    void init() {
      dfnum = 0;
      father = 0;
      sdom = 0;
      idom = 0;
      DfsIn = 0;
      DfsOut = 0;
      visited = 0;
      thisBlock = nullptr;
      des.clear();
      rev.clear();
      idom_child.clear();
    }
    Node()
        : father{0}, des{}, rev{}, sdom{0}, idom{0},
          idom_child{}, visited{0}, DfsIn{0}, DfsOut{0}, thisBlock{nullptr} {}
  };
  class DF {
  public:
    std::forward_list<int> df;
    DF() = default;
  };
  std::vector<Node> node;

private:
  int vertex[91000] = {0};        // 记录dfs对应的结点
  std::vector<int> bucket[20000]; // bucket[u]代表sdom为u的点集
  std::vector<DSU> dsu;           //辅助数据结构实现路径压缩
  // std::vector<DF> df;                  //存储每个结点的必经结点边界
  std::vector<std::vector<int>> Dest; // CFG中的后继
  std::vector<Node *> dfs_dom;
  Function *thisFunc;
  int block_num, count; // count是当前的dfs序号
  bool IsDFSValid;

public:
  Node &GetNode(int index) {
    static Node error{};
    error.thisBlock = nullptr;
    if (index >= node.size())
      return error;
    return node[index];
  }
  std::vector<std::vector<int>> &GetDest() { return Dest; }
  int &updateBlockNum() { return block_num; }
  void *GetResult(Function *func);
  void UpdateRevDst(int current, int pred);
  std::vector<Node *> DFS_Dom();

private:
  void init();
  /// @brief 获取每个节点的DFS序，同时初始化sdom为自己
  /// @param pos
  void DFS(int pos);
  /// @brief 路径压缩，并更新最小sdom
  /// @param x
  int find(int x) {
    if (x == dsu[x].ancestor)
      return x;
    int tmp = dsu[x].ancestor;
    dsu[x].ancestor = find(dsu[x].ancestor); // 并查集压缩路径
    if (SDOM(MIN_SDOM(x)) > SDOM(MIN_SDOM(tmp))) // 当前节点x的最小半支配节点
      MIN_SDOM(x) = MIN_SDOM(tmp);
    return dsu[x].ancestor;
  }

  /// @brief 进行路径压缩更新，并返回最近sdom
  /// @param x
  int eval(int x) {
    find(x);
    return MIN_SDOM(x);
  }

  /// @brief 支配节点查找
  void find_dom();

  /// @brief 建立支配树
  void build_tree();

  void DfsDominator(int root);

public:
  /// @brief 判断bb1是否支配bb2
  bool dominates(BasicBlock *bb1, BasicBlock *bb2);
  bool needToUpdate = false;
  void RunOnFunction();
  void PrintPass() {
#ifdef SYSY_MIDDLE_END_DEBUG
    std::cerr << "--------mem2reg--------" << std::endl;
    Singleton<Module>().Test();
#endif
  }
  dominance(Function *Func)
      : count{1}, node(Func->Size()), block_num(Func->Size()), dsu(20000),
        // df(blockNum + 1),
        thisFunc{Func}, Dest(Func->Size() + 1), IsDFSValid(false) {}
  void dom_begin();
  ~dominance() {}
};
bool promoteMemoryToRegister(Function &func, dominance &dom);