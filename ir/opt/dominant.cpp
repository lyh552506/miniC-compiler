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

void dominance::Init() {
  auto& bbs = thisFunc->GetBasicBlock();
  for (auto &bb : bbs) {
    // List<User> _User = bb->getInstList();
    User *Inst = bb->back(); //获取到最后一条指令
    node[bb->num].thisBlock=bb.get();
    if (CondInst *cond = dynamic_cast<CondInst *>(Inst)) {
      auto& uselist = cond->Getuselist();
      BasicBlock *des_true = dynamic_cast<BasicBlock *>(uselist[1]->GetValue());
      BasicBlock *des_false =
          dynamic_cast<BasicBlock *>(uselist[2]->GetValue());

      node[bb->num].des.push_front(des_true->num);
      node[bb->num].des.push_front(des_false->num);

      node[des_true->num].rev.push_front(bb->num);
      node[des_false->num].rev.push_front(bb->num);

    } else if (UnCondInst *uncond = dynamic_cast<UnCondInst *>(Inst)) {
      auto& uselist = uncond->Getuselist();
      BasicBlock *des = dynamic_cast<BasicBlock *>(uselist[0]->GetValue());

      node[bb->num].des.push_front(des->num);
      node[des->num].rev.push_front(bb->num);
    }
  }

  // for (int i = 0; i < m; i++) { // u-->v
  //   int u, v;
  //   scanf("%d%d", &u, &v); // TODO 需要适配后续CFG流图
  //   node[u].des.push_front(v);
  //   node[v].rev.push_front(u);
  // }
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

void dominance::DfsDominator(int root) {
  int DfsNum = 0;
  std::vector<std::pair<int, std::forward_list<int>::iterator>> worklists;
  std::forward_list<int>::iterator it1 = node[root].idom_child.begin();
  worklists.push_back(std::make_pair(root, it1));
  node[root].DfsIn = DfsNum++;
  while (!worklists.empty()) {
    int index = worklists.back().first;
    std::forward_list<int>::iterator it = worklists.back().second;
    if (it == node[index].des.end()) { //孩子全部访问完毕，则添加dfsout
      node[index].DfsOut = DfsNum++;
      worklists.pop_back();
    } else {
      int nxt = *it;
      ++worklists.back().second;
      worklists.push_back(std::make_pair(nxt, node[nxt].idom_child.begin()));
      node[nxt].DfsIn = DfsNum++;
    }
  }
  IsDFSValid = true;
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
  for (int i = 1; i < block_num; i++) {
    int idom = IDOM(i);
    if (idom >= 0) {
      node[idom].idom_child.push_front(i);
    }
  }
}

/// @brief 准备计算支配树
void dominance::dom_begin() {
  BasicBlock *EntryBB = thisFunc->front_block();
  DFS(EntryBB->num);
  find_dom();   // 寻找支配节点
  build_tree(); // 构建支配树
  // computeDF(1);
}

bool dominance::dominates(BasicBlock *bb1, BasicBlock *bb2) {
  if (!IsDFSValid) {
    DfsDominator(1);
  }
  int node_bb1 = vertex[bb1->dfs];
  int node_bb2 = vertex[bb2->dfs];

  return (node[node_bb1].DfsIn <= node[node_bb2].DfsIn) &&
         (node[node_bb1].DfsOut >= node[node_bb2].DfsOut);
}

BasicBlock *dominance::DfsToBB(int d) {
  int index = vertex[d];
  return node[index].thisBlock;
}