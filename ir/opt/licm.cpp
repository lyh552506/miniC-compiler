#include "licm.hpp"
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "my_stl.hpp"
#include <algorithm>
#include <cassert>
#include <iostream>
#include <set>
#include <vector>

void LICMPass::RunOnFunction() {
  loop->RunOnFunction();
  for (auto l = loop->begin(); l != loop->end(); l++) {
    RunOnLoop(*l);
  }
}

void LICMPass::RunOnLoop(LoopInfo *l) {
  std::set<BasicBlock *> contain{l->GetLoopBody().begin(),
                                 l->GetLoopBody().end()};
  contain.insert(l->GetHeader());
  auto head = l->GetHeader();
  change |= licmSink(contain, l, head);
  change |= licmHoist(contain, l, head);
}

bool LICMPass::licmSink(const std::set<BasicBlock *> &contain, LoopInfo *l,
                        BasicBlock *bb) {
  if (contain.find(bb) == contain.end())
    return false;
  //找到支配最低节点
  for (auto des : m_dom->GetNode(bb->num).idom_child) {
    auto child = m_dom->GetNode(des).thisBlock;
    change |= licmSink(contain, l, child);
  }
  //只处理当前循环bb
  if (loop->LookUp(bb) != l)
    return false;
  for (auto iter = bb->rbegin(); iter != bb->rend(); --iter) {
    auto inst = *iter;
    if (UserOutSideLoop(contain, inst, l) && CanBeMove(inst)) {
      _DEBUG(std::cerr << "LICM START SINK CODE: " << inst->GetName()
                       << std::endl;)
      std::map<BasicBlock *, User *> InsertNew; //记录每个exit对应的
      for (auto user : inst->GetUserlist()) {
        auto phi = user->GetUser();
        assert(dynamic_cast<PhiInst *>(phi) &&
               "after lcssa user must be PhiInst");
        auto PBB = phi->GetParent();
        User *CloneInst = nullptr;
        if (InsertNew.find(PBB) == InsertNew.end()) {
          if (auto call = dynamic_cast<CallInst *>(inst)) {
            std::vector<Value *> tmp;
            std::for_each(
                call->Getuselist().begin() + 1, call->Getuselist().end(),
                [&tmp](auto &ele) { tmp.push_back(ele->GetValue()); });
            CloneInst = new CallInst(call->Getuselist()[0]->GetValue(), tmp);
          } else if (auto bin = dynamic_cast<BinaryInst *>(inst)) {
            CloneInst = new BinaryInst(bin->GetOperand(0), bin->getopration(),
                                       bin->GetOperand(1));
          } else if (auto gep = dynamic_cast<GetElementPtrInst *>(inst)) {
            std::vector<Value *> tmp;
            for (int i = 1; i < gep->Getuselist().size(); i++) {
              tmp.push_back(GetOperand(gep, i));
            }
            CloneInst = new GetElementPtrInst(GetOperand(gep, 0), tmp);
          } else if (auto ld = dynamic_cast<LoadInst *>(inst)) {
            CloneInst = new LoadInst(GetOperand(inst, 0));
          } else {
            assert(0 && "cant get this place");
          }
          CloneInst->SetName(inst->GetName() + ".licm");
          for (auto it = PBB->begin(); it != PBB->end(); ++it) {
            if (!dynamic_cast<PhiInst *>(*it)) {
              _DEBUG(std::cerr
                         << "LICM Move Invariant: " << CloneInst->GetName()
                         << " To ExitBlock" << PBB->GetName() << std::endl;)
              it.insert_before(CloneInst);
            }
          }
          InsertNew[PBB] = CloneInst;
        } else {
          CloneInst = InsertNew[PBB];
        }
        phi->RAUW(CloneInst);
        delete phi;
      }
      assert(inst->GetUserListSize() == 0);
      delete inst;
    }
  }
  return false;
}

bool LICMPass::licmHoist(const std::set<BasicBlock *> &contain, LoopInfo *l,
                         BasicBlock *bb) {}

bool LICMPass::UserOutSideLoop(const std::set<BasicBlock *> &contain, User *I,
                               LoopInfo *curloop) {
  for (auto use : I->GetUserlist()) {
    auto userbb = use->GetUser()->GetParent();
    //f()
    if (contain.find(userbb) != contain.end())
      return false;
  }
  return true;
}

bool LICMPass::CanBeMove(User *I) {
  if (auto ld = dynamic_cast<LoadInst *>(I)) {
    // TODO 可能需要分析一下地址信息
  } else if (dynamic_cast<StoreInst *>(I)) {
    return false;
  } else if (auto call = dynamic_cast<CallInst *>(I)) {
    if (call->HasSideEffect())
      return false;
  } else if (dynamic_cast<BinaryInst *>(I) ||
             dynamic_cast<GetElementPtrInst *>(I)) {
    return true;
  } else {
    return false;
  }
  return true;
}