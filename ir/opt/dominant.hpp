#pragma once
#include "CFG.hpp"
#include <algorithm>
#include <forward_list>
#include <iostream>
#include <list>
#include <memory.h>
#include <set>
#include <typeinfo>
#include <unordered_set>
#include <utility>
#include <vector>
#include "IDF.hpp"

// SDOM(MIN_SDOM(x))即代表获取离x最近的sdom结点
#define SDOM(x) node[x].sdom        //获取x对应结点的sdom
#define MIN_SDOM(x) dsu[x].min_sdom //获取结点最近的sdom的index
#define IDOM(x) node[x].idom        //获取结点的idom

// struct _Node {
//   std::string name;
//   std::vector<int> defblock;
//   bool operator==(const _Node &other) { return name == other.name; }
// };

class dominance {
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

private:
  std::vector<Node> node;
  // std::vector<BasicBlockPtr> nod;
  std::vector<int> vertex;     // 记录dfs对应的结点
  std::vector<int> bucket[20]; // bucket[u]代表sdom为u的点集
  std::vector<DSU> dsu;        //辅助数据结构实现路径压缩
  std::vector<DF> df;          //存储每个结点的必经结点边界
  // BasicBlock* root;            //保存支配树的根节点
  
  Function& thisFunc;
  int block_num, count; // count是当前的dfs序号
  bool IsDFSValid;

public:
  /// @brief 从CFG的根节点开始计算出每个节点的dominate frontier
  /// @param x
  void computeDF(int x);

  /// @brief 输入dfs序，返回对应的block
  BasicBlock *DfsToBB(int d); // TODO

  BasicBlock *DfsToBB(Node *node); // TODO

  Node &GetNode(int index) { return node[index]; }

  /// @brief 初始化边关系
  void Init();

  /// @brief 获取每个节点的DFS序，同时初始化sdom为自己
  /// @param pos
  void DFS(int pos);

  void DFS_new();

  /// @brief 对支配树进行dfs遍历
  void DfsDominator(int root);

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

public:
  /// @brief 支配节点查找
  void find_dom();

  /// @brief 建立支配树
  void build_tree();

  /// @brief 判断bb1是否支配bb2
  bool dominates(BasicBlock *bb1, BasicBlock *bb2);

  /// @brief 插入phi函数
  void place_phi() {}

  dominance(int n, int m,Function& Func)
      : node(n + 1), block_num{n}, vertex(n + 1),
        dsu(n + 1), count{1}, IsDFSValid{false}, df(n + 1) ,thisFunc{Func}{
    for (int i = 1; i <= n; i++) {
      dsu[i].ancestor = i;
      dsu[i].min_sdom = i;
    }
    dom_begin();//标志开始函数
  }

  void dom_begin();
};
