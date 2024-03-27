#pragma once
#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "my_stl.hpp"
#include <algorithm>
#include <forward_list>
#include <iostream>
#include <iterator>
#include <list>
#include <memory.h>
#include <set>
#include <typeinfo>
#include <unordered_set>
#include <utility>
#include <vector>


class dominance : public PassManagerBase {
  friend class IDF;

public:
  class DSU { //并查集实现路径压缩
  public:
    int ancestor;
    int min_sdom;
  };
  class Node {
  public:
    int dfnum;  //记录dfs序
    int father; //此处是dfs序中遍历的father，区别rev链表
    int sdom;
    int idom;
    int DfsIn, DfsOut;
    int visited;
    BasicBlock *thisBlock;
    std::forward_list<int> des;        // 记录该结点的下一个结点
    std::forward_list<int> rev;        // 记录该节点的上一个结点
    std::forward_list<int> idom_child; // 支配树上的孩子
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
  int vertex[11000];            // 记录dfs对应的结点
  std::vector<int> bucket[200];       // bucket[u]代表sdom为u的点集
  std::vector<DSU> dsu;               //辅助数据结构实现路径压缩
  std::vector<DF> df;                 //存储每个结点的必经结点边界
  std::vector<std::vector<int>> Dest; // CFG中的后继

  Function *thisFunc;
  int block_num, count; // count是当前的dfs序号
  bool IsDFSValid;

public:
  Node &GetNode(int index) { return node[index]; }
  std::vector<std::vector<int>> &GetDest() { return Dest; }
  void init();
  /// @brief 获取每个节点的DFS序，同时初始化sdom为自己
  /// @param pos
  void DFS(int pos);

  void RunOnFunction();

private:
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

  /// @brief 寻找两个block的lca
  BasicBlock *find_lca(BasicBlock *bb1, BasicBlock *bb2);

  /// @brief 建立支配树
  void build_tree();

  void DfsDominator(int root);

public:
  /// @brief 判断bb1是否支配bb2
  bool dominates(BasicBlock *bb1, BasicBlock *bb2);
  void PrintPass() {
    std::cout << "--------mem2reg--------" << std::endl;
    Singleton<Module>().Test();
  }
  dominance(Function *Func, int blockNum)
      : count{1}, node(blockNum), block_num(blockNum),
        dsu(blockNum + 1), df(blockNum + 1), thisFunc{Func},
        Dest(blockNum + 1) {}
  void dom_begin();
};
bool promoteMemoryToRegister(Function &func, dominance &dom);