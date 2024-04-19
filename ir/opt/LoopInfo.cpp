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
        LoopInfo *tmp = LookUp(bb);
        if (tmp == nullptr) {
          setLoop(bb, loop);
          if (bb == curbb)
            continue;
          loop->InsertLoopBody(bb);
          for (int rev : n.rev)
            WorkLists.push_back(GetCorrespondBlock(rev));
        } else {
          //得到最外层
          while (tmp->GetParent() != nullptr)
            tmp = tmp->GetParent();
          if (tmp == loop) //已经处理过
            continue;
          tmp->setParent(loop);
          loop->setSubLoop(tmp);
          for (auto x : tmp->GetLoopBody())
            loop->InsertLoopBody(x);
          BasicBlock *header = tmp->GetHeader();
          n = m_dom->GetNode(header->num);
          for (int rev : n.rev)
            if (LookUp(GetCorrespondBlock(rev)) != tmp)
              WorkLists.push_back(GetCorrespondBlock(rev));
        }
      }
      LoopRecord.push_back(std::move(loop));
    }
  }
}

LoopInfo *LoopAnalysis::LookUp(BasicBlock *bb) {
  auto iter = Loops.find(bb);
  if (iter != Loops.end())
    return iter->second;
  return nullptr;
}

void LoopAnalysis::setLoop(BasicBlock *bb, LoopInfo *loop) {
  if (Loops.find(bb) != Loops.end())
    return;
  Loops.emplace(bb, loop);
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

BasicBlock *LoopAnalysis::FindLoopHeader(BasicBlock *bb) {
  auto iter = Loops.find(bb);
  if (iter == Loops.end())
    return nullptr;
  return iter->second->GetHeader();
}

void LoopAnalysis::LoopAnaly() {
  for (auto lps : LoopRecord) {
    LoopInfo *root = lps;
    while (root->GetParent() != nullptr)
      root = root->GetParent();
    CalculateLoopDepth(root, 1);
  }
}

void LoopAnalysis::CalculateLoopDepth(LoopInfo *loop, int depth) {
  if (!loop->IsVisited()) {
    loop->AddLoopDepth(depth);
    loop->setVisited(true);
    for (auto sub : loop->GetSubLoop())
      CalculateLoopDepth(sub, depth + 1);
  }
  return;
}
//打印格式：
// num of loops
// each loop nodes
void LoopAnalysis::PrintPass() {
  #ifdef DEBUG
  std::cout << "---------------------Loop Analysis-----------------------\n";
  std::cout << "Num Of Loops:" << LoopRecord.size() << "\n";
  for (int i = 0; i < LoopRecord.size(); i++) {
    auto tmp = LoopRecord[i];
    std::cout << "Loop Depth:" << tmp->GetLoopDepth() << "\n";
    std::cout << "Loop Head:" <<tmp->GetHeader()->GetName() << "\n";
    std::cout << "Loop Body:";
    for (auto x : tmp->GetLoopBody())
      if (x != tmp->GetHeader())
        std::cout << x->GetName() << " ";
    std::cout << "\n\r";
  }
  #endif
}