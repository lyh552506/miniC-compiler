#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../util/my_stl.hpp"
#include <algorithm>
#include <cassert>
#include <set>
#include <unordered_set>
#include <vector>

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
          // for (auto x : tmp->GetLoopBody())
          //   loop->InsertLoopBody(x);
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

void LoopAnalysis::ExpandSubLoops() {
  for (auto loop : LoopRecord)
    for (auto subloop : loop->GetSubLoop())
      for (auto bb : subloop->ContainBlocks)
        PushVecSingleVal(loop->ContainBlocks, bb);
}

bool LoopAnalysis::IsLoopIncludeBB(LoopInfo *loop, int index) {
  std::set<BasicBlock *> contain{loop->ContainBlocks.begin(),
                                 loop->ContainBlocks.end()};
  contain.insert(loop->GetHeader());
  auto iter =
      std::find(contain.begin(), contain.end(), GetCorrespondBlock(index));
  if (iter == contain.end())
    return false;
  return true;
}

bool LoopAnalysis::IsLoopIncludeBB(LoopInfo *loop, BasicBlock *bb) {
  auto iter =
      std::find(loop->ContainBlocks.begin(), loop->ContainBlocks.end(), bb);
  if (iter == loop->ContainBlocks.end())
    return false;
  return true;
}

bool LoopAnalysis::IsLoopExiting(LoopInfo *loop, BasicBlock *bb) {
  auto exiting = GetExitingBlock(loop);
  auto it = std::find(exiting.begin(), exiting.end(), bb);
  if (it != exiting.end())
    return true;
  return false;
}

bool LoopInfo::Contain(BasicBlock *bb) {
  std::unordered_set<BasicBlock *> assist{this->ContainBlocks.begin(),
                                          this->ContainBlocks.end()};
  assist.insert(Header);
  if (assist.find(bb) != assist.end())
    return true;
  return false;
}

bool LoopInfo::Contain(LoopInfo *loop) {
  if (loop == this)
    return true;
  if (!loop)
    return false;
  return Contain(loop->GetParent());
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

void LoopAnalysis::CloneToBB() {
  for (auto loops : LoopRecord) {
    _DeleteLoop.push_back(loops);
    int loopdepth = loops->GetLoopDepth();
    loops->GetHeader()->LoopDepth = loopdepth;
    for (auto contain : loops->GetLoopBody())
      contain->LoopDepth = loopdepth;
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

BasicBlock *LoopAnalysis::GetPreHeader(LoopInfo *loopinfo, Flag f) {
  BasicBlock *preheader = nullptr;
  if (loopinfo->Pre_Header != nullptr)
    return loopinfo->Pre_Header;
  BasicBlock *header = loopinfo->GetHeader();
  for (auto rev : m_dom->GetNode(header->num).rev) {
    //出现前驱不属于这个循环的情况
    if (!IsLoopIncludeBB(loopinfo, rev)) {
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
  if (preheader && f == Strict) {
    for (auto des : m_dom->GetNode(preheader->num).des)
      if (GetCorrespondBlock(des) != header) {
        preheader = nullptr;
        return preheader;
      }
  }
  if (preheader != nullptr)
    loopinfo->setPreHeader(preheader);
  return preheader;
}

BasicBlock *LoopAnalysis::GetLatch(LoopInfo *loop) {
  auto header = loop->GetHeader();
  auto preheader = GetPreHeader(loop);
  BasicBlock *latch = nullptr;
  for (auto rev : m_dom->GetNode(header->num).rev) {
    auto B = m_dom->GetNode(rev).thisBlock;
    if (B != preheader && loop->Contain(B)) {
      if (!latch)
        latch = B;
      else
        break;
    }
  }
  return latch;
}

std::vector<BasicBlock *> LoopAnalysis::GetExitingBlock(LoopInfo *loopinfo) {
  std::vector<BasicBlock *> exit = GetExit(loopinfo);
  std::vector<BasicBlock *> exiting;
  for (auto bb : exit) {
    for (auto rev : m_dom->GetNode(bb->num).rev) {
      if (IsLoopIncludeBB(loopinfo, rev))
        PushVecSingleVal(exiting, m_dom->GetNode(rev).thisBlock);
    }
  }
  return exiting;
}

std::vector<BasicBlock *> LoopAnalysis::GetExit(LoopInfo *loopinfo) {
  std::vector<BasicBlock *> workList;
  for (auto bb : loopinfo->ContainBlocks) {
    for (auto des : m_dom->GetNode(bb->num).des) {
      BasicBlock *B = m_dom->GetNode(des).thisBlock;
      // auto iter = std::find(loopinfo->ContainBlocks.begin(),
      //                       loopinfo->ContainBlocks.end(), B);
      if (!IsLoopIncludeBB(loopinfo, B))
        PushVecSingleVal(workList, B);
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
      if (x != tmp->GetHeader())
        std::cout << x->GetName() << " ";
    std::cout << "\n\r";
  }
}

void LoopAnalysis::DeleteLoop(LoopInfo *loop) {
  auto parent = loop->GetParent();
  if (parent) {
    auto it = std::find(parent->GetSubLoop().begin(),
                        parent->GetSubLoop().end(), loop);
    assert(it != parent->GetSubLoop().end());
    parent->GetSubLoop().erase(it);
    while (parent) {
      for (auto loopbody : loop->GetLoopBody()) {
        auto iter = std::find(parent->GetLoopBody().begin(),
                              parent->GetLoopBody().end(), loopbody);
        if (iter != parent->GetLoopBody().end()) {
          parent->GetLoopBody().erase(iter);
        }
      }
      parent = parent->GetParent();
    }
  }
  auto it1 = std::find(LoopRecord.begin(), LoopRecord.end(), loop);
  assert(it1 != LoopRecord.end());
  LoopRecord.erase(it1);
  return;
}

void LoopAnalysis::DeleteBlock(BasicBlock *bb) {
  auto loop = LookUp(bb);
  if (!loop)
    return;
  while (loop) {
    loop->DeleteBlock(bb);
    loop = loop->GetParent();
  }
}

void LoopAnalysis::ReplBlock(BasicBlock *Old, BasicBlock *New) {
  auto loop = LookUp(Old);
  if (!loop)
    return;
  while (loop) {
    loop->DeleteBlock(Old);
    loop->InsertLoopBody(New);
    loop = loop->GetParent();
  }
}

bool LoopAnalysis::IsLoopInvariant(const std::set<BasicBlock *> &contain,
                                   User *I, LoopInfo *curloop) {
  bool res =
      std::all_of(I->Getuselist().begin(), I->Getuselist().end(),
                  [curloop, &contain](auto &ele) {
                    auto val = ele->GetValue();
                    if (auto user = dynamic_cast<User *>(val)) {
                      if (user->isParam())
                        return true;
                      if (contain.find(user->GetParent()) != contain.end())
                        return false;
                    }
                    return true;
                  });
  return res;
}