#include "dominant.hpp"

#include "CFG.hpp"
#include "Singleton.hpp"

void dominance::init() {
  auto &bbs = thisFunc->GetBasicBlock();
  block_num=bbs.size();
  node.resize(bbs.size());
  Dest.resize(bbs.size());
  for (auto bb : bbs) 
    node[bb->num].init();
  for (auto bb : bbs) {
    User *Inst = bb->back();  //获取到最后一条指令
    node[bb->num].thisBlock = bb;
    if (CondInst *cond = dynamic_cast<CondInst *>(Inst)) {
      auto &uselist = cond->Getuselist();
      BasicBlock *des_true = dynamic_cast<BasicBlock *>(uselist[1]->GetValue());
      BasicBlock *des_false =
          dynamic_cast<BasicBlock *>(uselist[2]->GetValue());

      Dest[bb->num].push_back(des_true->num);
      Dest[bb->num].push_back(des_false->num);
      node[bb->num].des.push_front(des_true->num);
      node[bb->num].des.push_front(des_false->num);

      node[des_true->num].rev.push_front(bb->num);
      node[des_false->num].rev.push_front(bb->num);

    } else if (UnCondInst *uncond = dynamic_cast<UnCondInst *>(Inst)) {
      auto &uselist = uncond->Getuselist();
      BasicBlock *des = dynamic_cast<BasicBlock *>(uselist[0]->GetValue());

      Dest[bb->num].push_back(des->num);
      node[bb->num].des.push_front(des->num);
      node[des->num].rev.push_front(bb->num);
    }
  }
}

void dominance::RunOnFunction() {
  init();
  for (int i = 1; i <= block_num; i++) {
    dsu[i].ancestor = i;
    dsu[i].min_sdom = i;
  }
  dom_begin();  //标志开始函数
  promoteMemoryToRegister(*thisFunc, *this);
}

void dominance::DFS(int pos) {
  node[pos].dfnum = count;
  node[pos].sdom = count;  // 每个节点的sdom先初始化为自己
  vertex[count] = pos;     // 记录每一个dfnum对应的结点
  count++;
  for (auto p : node[pos].des) {
    if (node[p].dfnum == 0) {
      DFS(p);
      node[p].father = pos;
    }
  }
}

void dominance::find_dom() {
  int n, fat;
  for (int i = block_num; i > 1; i--) {  // 从dfs最大的结点开始
    int sdom_cadidate = 90000;
    n = vertex[i];  // 获取dfs序对应的结点号
    fat = node[n].father;
    for (auto front : node[n].rev) {
      if (node[front].dfnum != 0) {
        sdom_cadidate =
            std::min(sdom_cadidate, SDOM(eval(front)));  // 半必经结点定理
      }
    }
    node[n].sdom = sdom_cadidate;  // 注意此处记录的是dfs序
    bucket[vertex[sdom_cadidate]].push_back(
        n);  // 所以此处需要进行转换vertex[sdom_cadidate]
    dsu[n].ancestor = fat;
    for (auto s : bucket[fat]) {  // 必经结点定理
      if (SDOM(eval(s)) == SDOM(s)) {
        IDOM(s) = fat;  // idom(s)==sdom(s)==fat
      } else {
        IDOM(s) = eval(s);  // 留到第四步处理
      }
    }
    bucket[fat].clear();
  }
  // 按照标号从小到大再跑一次，得到所有点的idom
  for (int i = 2; i <= block_num; i++) {
    int N = vertex[i];
    SDOM(N) = vertex[SDOM(N)];  // 将sdom的内容更新为dfs序对应的结点号
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
  BasicBlock *EntryBB = *(thisFunc->begin());
  DFS(EntryBB->num);
  find_dom();    // 寻找支配节点
  build_tree();  // 构建支配树
}

/// @brief 判断bb1是否dominate bb2
bool dominance::dominates(BasicBlock *bb1, BasicBlock *bb2) {
  DfsDominator(0);
  Node &n1 = node[bb1->num];
  Node &n2 = node[bb2->num];

  return (n1.DfsIn <= n2.DfsIn) && (n1.DfsOut >= n2.DfsOut);
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
    if (it == node[index].des.end()) {  //孩子全部访问完毕，则添加dfsout
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

BasicBlock *dominance::find_lca(BasicBlock *bb1, BasicBlock *bb2) {}