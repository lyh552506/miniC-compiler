#include "LoopInfo.hpp"
#include <vector>

#include "CFG.hpp"
#include "my_stl.hpp"

void LoopAnalysis::Analysis() {
  //此处后续遍历支配树
  for (auto curbb : PostOrder) {
    std::vector<BasicBlock *> latch;
    auto node = m_dom->GetNode(curbb->num);
    for (int succbb : node.rev)
      if (m_dom->dominates(curbb, GetCorrespondBlock(succbb)))  // find a loop!
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
          if (bb == curbb) continue;
          loop->InsertLoopBody(bb);
          for (int rev : n.rev) WorkLists.push_back(GetCorrespondBlock(rev));
        } else {
          //得到最外层
          while (tmp->GetParent() != nullptr) tmp = tmp->GetParent();
          if (tmp == loop)  //已经处理过
            continue;
          tmp->setParent(loop);
          loop->setSubLoop(tmp);
          for (auto x : tmp->GetLoopBody()) loop->InsertLoopBody(x);
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
  if (iter != Loops.end()) return iter->second;
  return nullptr;
}

void LoopAnalysis::setLoop(BasicBlock *bb, LoopInfo *loop) {
  if (Loops.find(bb) != Loops.end()) return;
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
  if (iter == Loops.end()) return nullptr;
  return iter->second->GetHeader();
}

void LoopAnalysis::LoopAnaly() {
  for (auto lps : LoopRecord) {
    LoopInfo *root = lps;
    while (root->GetParent() != nullptr) root = root->GetParent();
    CalculateLoopDepth(root, 1);
  }
}

void LoopAnalysis::CloneToBB() {
  for (auto loops : LoopRecord) {
    int loopdepth = loops->GetLoopDepth();
    loops->GetHeader()->LoopDepth = loopdepth;
    for (auto contain : loops->GetLoopBody()) contain->LoopDepth = loopdepth;
  }
}

void LoopAnalysis::CalculateLoopDepth(LoopInfo *loop, int depth) {
  if (!loop->IsVisited()) {
    loop->AddLoopDepth(depth);
    loop->setVisited(true);
    for (auto sub : loop->GetSubLoop()) CalculateLoopDepth(sub, depth + 1);
  }
  return;
}

BasicBlock *LoopAnalysis::GetPreHeader(LoopInfo *loopinfo) {
  BasicBlock *preheader = nullptr;
  if (loopinfo->Pre_Header != nullptr) return loopinfo->Pre_Header;
  BasicBlock *header = loopinfo->GetHeader();
  for (auto rev : m_dom->GetNode(header->num).rev) {
    //出现前驱不属于这个循环的情况
    if (Loops.find(GetCorrespondBlock(rev)) == Loops.end()) {
      if (preheader == nullptr) {
        preheader = GetCorrespondBlock(rev);
        continue;
      }
      if (preheader != GetCorrespondBlock(rev)) {
        preheader = nullptr;
        return preheader;
      }
    }
  }
  if (preheader != nullptr) loopinfo->setPreHeader(preheader);
  return preheader;
}

std::vector<BasicBlock*> LoopAnalysis::GetExit(LoopInfo *loopinfo) {
  std::vector<BasicBlock *> workList;
  for (auto bb : loopinfo->ContainBlocks) {
    for (auto des : m_dom->GetNode(bb->num).des) {
      BasicBlock* B=m_dom->GetNode(des).thisBlock;
      if(Loops[B]!=loopinfo)
        PushVecSingleVal(workList,B);
    }
  }
  return workList;
}

//打印格式：
// num of loops
// each loop nodes
void LoopAnalysis::PrintPass() {
  std::cout << "---------------------Loop Analysis-----------------------\n";
  std::cout << "Num Of Loops:" << LoopRecord.size() << "\n";
  for (int i = 0; i < LoopRecord.size(); i++) {
    auto tmp = LoopRecord[i];
    std::cout << "Loop Depth:" << tmp->GetLoopDepth() << "\n";
    std::cout << "Loop Head:" << tmp->GetHeader()->GetName() << "\n";
    std::cout << "Loop Body:";
    for (auto x : tmp->GetLoopBody())
      if (x != tmp->GetHeader()) std::cout << x->GetName() << " ";
    std::cout << "\n\r";
  }
}