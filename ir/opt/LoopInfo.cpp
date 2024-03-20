#include "LoopInfo.hpp"

void LoopAnalysis::Analysis() {
  //此处后续遍历支配树
  for (auto curbb : PostOrder) {
    std::vector<BasicBlock *> latch;
    auto node = m_dom->GetNode(curbb->num);
    for (int succbb : node.rev)
      if (m_dom->dominates(curbb, GetCorrespondBlock(succbb))) // find a loop!
        latch.push_back(GetCorrespondBlock(succbb));
    if (!latch.empty()) {
      LoopInfo *loop = new LoopInfo(curbb);
      std::vector<BasicBlock *> WorkLists{latch.begin(), latch.end()};
      //此处开始分析
      while (!WorkLists.empty()) {
        BasicBlock *bb = WorkLists.back();
        WorkLists.pop_back();
        auto n = m_dom->GetNode(bb->num);
        for (int succbb : n.rev) {
          
        }
      }
    }
  }
}

void LoopAnalysis::PostOrderDT(int entry) {
  auto node = m_dom->GetNode(entry);
  for (int dst : node.idom_child) {
    if (!GetCorrespondBlock(dst)->visited) {
      GetCorrespondBlock(dst)->visited = true;
      PostOrderDT(dst);
    }
  }
  PostOrder.push_back(GetCorrespondBlock(entry));
}
//打印格式：
// num of loops
// each loop nodes
// void LoopInfo::PrintPass() {
//   std::cout << "Num Of Loops:" << Loops.size() << "\n";
//   for (int i = 0; i < Loops.size(); i++) {
//     auto tmp = Loops[i];
//     std::cout << "Loop Head:" << bbs[tmp.first]->GetName() << "\n";
//     std::cout << "Loop Body:";
//     for (auto x : tmp.second)
//       if (x != tmp.first)
//         std::cout << bbs[x]->GetName() << " ";
//     std::cout << "\n\r";
//   }
// }