#include <forward_list>
#include <iostream>
#include <memory.h>
#include <vector>

//SDOM(MIN_SDOM(x))即代表获取离x最近的sdom结点
#define SDOM(x) node[x].sdom //获取x对应结点的sdom
#define MIN_SDOM(x) dsu[x].min_sdom //获取结点最近的sdom的index
#define IDOM(x) node[x].idom  //获取结点的idom

class dominance{
public:
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
       
       Node():dfnum{0}, father{0}, des{}, rev{},sdom{0},idom{0} 
       {}
    }; 
private:
    std::vector<Node> node;
    std::vector<int> vertex;     // 记录dfs对应的结点
    std::vector<int> bucket[20]; // bucket[u]代表sdom为u的点集
    std::vector<DSU> dsu;        //辅助数据结构实现路径压缩
    int tot_node,count;          //count是当前的dfs序号

public:
    /// @brief 初始化边关系
    /// @param m 
    void Init(int m) {
    for (int i = 0; i < m; i++) { // u-->v
      int u, v;
      scanf("%d%d", &u, &v);//TODO 需要适配后续CFG流图
      node[u].des.push_front(v);
      node[v].rev.push_front(u);
    }
  }
    
  /// @brief 获取每个节点的DFS序，同时初始化sdom为自己
  /// @param pos
  void DFS(int pos) {
    node[pos].dfnum = count;
    node[pos].sdom = count; // 每个节点的sdom先初始化为自己
    vertex[count] = pos;    // 记录每一个dfnum对应的结点
    count++;
    for (auto p : node[pos].des) {
      if (node[p].dfnum == 0) {
        DFS(p);
        node[p].father = pos;
      }
    }
  }
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
   void find_dom() {
    int n, fat;
    for (int i = tot_node; i > 1; i--) { // 从dfs最大的结点开始
      int sdom_cadidate=999999;
      n = vertex[i]; //获取dfs序对应的结点号       
      fat = node[n].father;
      for (auto front : node[n].rev) {
        if(node[front].dfnum!=0){
          sdom_cadidate=std::min(sdom_cadidate,SDOM(eval(front)));//半必经结点定理
        }
      }
      node[n].sdom=sdom_cadidate;//注意此处记录的是dfs序 
      bucket[vertex[sdom_cadidate]].push_back(n);//所以此处需要进行转换vertex[sdom_cadidate]
      dsu[n].ancestor=fat;
      for(auto s:bucket[fat]){//必经结点定理
        if(SDOM(eval(s))==SDOM(s)){
          IDOM(s)=fat; //idom(s)==sdom(s)==fat
        }
        else{
          IDOM(s)=eval(s);//留到第四步处理
        }
      }
      bucket[fat].clear();
    }
      //按照标号从小到大再跑一次，得到所有点的idom
      for(int i=2;i<=tot_node;i++){
        int N=vertex[i];
        SDOM(N)=vertex[SDOM(N)];//将sdom的内容更新为dfs序对应的结点号
        if(IDOM(N)!=SDOM(N)){
          IDOM(N)=IDOM(IDOM(N));
        }
      }
  }

  dominance(int n, int m):node(n + 1), tot_node{n},vertex(n + 1), dsu(n + 1),count{1}
  {
    for (int i = 1; i <= n; i++) {
      dsu[i].ancestor = i;
      dsu[i].min_sdom = i;
    }
  }
};


void dom_begin();