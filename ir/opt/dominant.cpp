#include "dominant.hpp"
//一个basicblock的所以前驱即找他的userlist
//所有后继找这个basicblock块的最后一个跳转语句


void dominance::computeDF(int x) {
  for (auto de : node[x].des) { // 找到结点x的所有后继结点，计算DF_local
    if (node[de].idom != x) { // de是x的一个后继并且x不是de的严格支配节点
      df[x].df.push_front(de);
    }
  }
  // 计算DP_up
  for (auto child : node[x].idom_child) {
    computeDF(child);
    for (auto frontier : df[child].df) {
      if (node[frontier].idom != x || x == frontier) {
        df[x].df.push_front(frontier);
      }
    }
  }
}

void dominance::Init(int m, Function &function) {
  // auto &bbs = function.GetBasicBlock();
  // for (auto &bb : bbs) {
  //   auto &Insts = bb->GetInsts();
  // }
  for (int i = 0; i < m; i++) { // u-->v
    int u, v;
    scanf("%d%d", &u, &v); // TODO 需要适配后续CFG流图
    node[u].des.push_front(v);
    node[v].rev.push_front(u);
  }
}

void dominance::DFS(int pos) {
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

void dominance::DFS_new(){
  int DfsIn=0,DfsOut=0;
  std::vector<std::pair<int,std::forward_list<int>::iterator>> worklists;
  std::forward_list<int>::iterator it1=node[1].des.begin();
  worklists.push_back(std::make_pair(1,it1));//push root node
  node[1].DfsIn=++DfsIn;
  //vertex[DfsIn]=1;
  while(!worklists.empty()){
    int index=worklists.back().first;
    std::forward_list<int>::iterator it=worklists.back().second;
    if(it==node[index].des.end()){//孩子全部访问完毕，则添加dfsout
       node[index].DfsOut=++DfsOut;
       worklists.pop_back();   
    }else{
      
    }
  }
}

void dominance::find_dom() {
  int n, fat;
  for (int i = block_num; i > 1; i--) { // 从dfs最大的结点开始
    int sdom_cadidate = 999999;
    n = vertex[i]; // 获取dfs序对应的结点号
    fat = node[n].father;
    for (auto front : node[n].rev) {
      if (node[front].dfnum != 0) {
        sdom_cadidate =
            std::min(sdom_cadidate, SDOM(eval(front))); // 半必经结点定理
      }
    }
    node[n].sdom = sdom_cadidate; // 注意此处记录的是dfs序
    bucket[vertex[sdom_cadidate]].push_back(
        n); // 所以此处需要进行转换vertex[sdom_cadidate]
    dsu[n].ancestor = fat;
    for (auto s : bucket[fat]) { // 必经结点定理
      if (SDOM(eval(s)) == SDOM(s)) {
        IDOM(s) = fat; // idom(s)==sdom(s)==fat
      } else {
        IDOM(s) = eval(s); // 留到第四步处理
      }
    }
    bucket[fat].clear();
  }
  // 按照标号从小到大再跑一次，得到所有点的idom
  for (int i = 2; i <= block_num; i++) {
    int N = vertex[i];
    SDOM(N) = vertex[SDOM(N)]; // 将sdom的内容更新为dfs序对应的结点号
    if (IDOM(N) != SDOM(N)) {
      IDOM(N) = IDOM(IDOM(N));
    }
  }
}

void dominance::build_tree() {
  for (int i = 2; i <= block_num; i++) {
    int idom = IDOM(i);
    if (idom > 0) {
      node[idom].idom_child.push_front(i);
    }
  }
}

/// @brief 预备phi函数关系
void dom_begin() {
  int n, m; // CFG的结点数和边数
  dominance Dom{n, m};
  // Dom.Init(m);      // 记录有向边的关系
  Dom.DFS(1);       // 起始节点的序号记为1
  Dom.find_dom();   // 寻找支配节点
  Dom.build_tree(); // 构建支配树
  Dom.computeDF(1);
}
