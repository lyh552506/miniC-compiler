#include "dominant.hpp"

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

/// @brief 判断bb1是否dominate bb2
bool dominance::dominates(BasicBlock *bb1, BasicBlock *bb2) {
  Node& node_1=node[bb1->num];
  int N=bb2->num;
  for(auto t:node_1.idom_child)
    if(t==N)
     return true;
  return false;
}
