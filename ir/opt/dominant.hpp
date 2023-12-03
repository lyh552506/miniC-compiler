#include <forward_list>
#include<list>
#include <iostream>
#include <memory.h>
#include <vector>
#include<algorithm>
#include <unordered_set>
#include "CFG.hpp"

//SDOM(MIN_SDOM(x))即代表获取离x最近的sdom结点
#define SDOM(x) node[x].sdom //获取x对应结点的sdom
#define MIN_SDOM(x) dsu[x].min_sdom //获取结点最近的sdom的index
#define IDOM(x) node[x].idom  //获取结点的idom

//auto& func=Singleton<Module>().Test();




//纯属yy

struct _Node{
  std::string name;
  std::vector<int> defblock;
  bool operator==(const _Node& other){
    return name==other.name;
  }
};

// class Function{
// public:
//   std::vector<BasicBlock> bbs;
// };

// class BasicBlock{
// public:
//    std::list<Instruction> Inst;
//    std::vector<int> rev;
//    std::vector<int> des;
// };

// class Instruction{
// public:
//    std::vector<_Node> use;
//    std::vector<_Node> def;
// };



// Function function;


class dominance{
public:
    friend class phi_function;
    class DSU{//并查集实现路径压缩
    public:
       int ancestor;
       int min_sdom;
    };
    class Node{
    public:
       int dfnum;//记录dfs序
       int father;//此处是dfs序中遍历的father，区别rev链表
       int sdom;
       int idom;
       std::forward_list<int> des; // 记录该结点的下一个结点
       std::forward_list<int> rev; // 记录该节点的上一个结点
       std::forward_list<int> idom_child;//支配树上的孩子
       Node():dfnum{0}, father{0}, des{}, rev{},sdom{0},idom{0},idom_child{} 
       {}
    }; 
    class DF{
    public:
       std::forward_list<int> df;
       DF()=default;
    };
private:
    std::vector<Node> node;
    std::vector<int> vertex;     // 记录dfs对应的结点
    std::vector<int> bucket[20]; // bucket[u]代表sdom为u的点集
    std::vector<DSU> dsu;        //辅助数据结构实现路径压缩
    std::vector<DF> df;          //存储每个结点的必经结点边界

    int block_num,count;          //count是当前的dfs序号

public:
    /// @brief 从CFG的根节点开始计算出每个节点的dominate frontier
    /// @param x 
    void computeDF(int x);

    /// @brief 初始化边关系
    /// @param m 
    void Init(int m);
    
  /// @brief 获取每个节点的DFS序，同时初始化sdom为自己
  /// @param pos
  void DFS(int pos);
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
  int eval(int x){
    find(x);
    return MIN_SDOM(x);
  }
public:
  /// @brief 支配节点查找
   void find_dom();
   
   /// @brief 建立支配树
   void build_tree();
  dominance(int n, int m):node(n + 1), block_num{n},vertex(n + 1), dsu(n + 1),count{1},df(n+1)
  {
    for (int i = 1; i <= n; i++) {
      dsu[i].ancestor = i;
      dsu[i].min_sdom = i;
    }
  }
};

class phi_function:public dominance{
public:
   std::vector<std::vector<_Node>> var;//记录每一个basicblock的定值的变量
   std::unordered_set<std::string> defsite;

   phi_function(int n,int m):dominance(n,m)
   {}

   void place_phy(){
    for(int block=1;block<=block_num;block++){
      for(auto& v:var[block]){//将一个块的变量定值装入
        if(defsite.find(v.name)!=defsite.end()){
          v.defblock.push_back(block);
          defsite.insert(v.name);
        }
      }

    }

   }
};


void dom_begin();