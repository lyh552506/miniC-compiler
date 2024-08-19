#include "../../include/ir/opt/lcssa.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../util/my_stl.hpp"
#include <algorithm>
#include <cassert>
#include <set>
#include <string>
#include <utility>
#include <vector>

bool LcSSA::Run() {
  // if (m_func->tag != Function::Normal)
  //   return false;
  m_dom = AM.get<dominance>(m_func);
  loops = AM.get<LoopAnalysis>(m_func, m_dom, std::ref(DeleteLoop));
  bool changed = false;
  if (!loops->CanBeOpt())
    return changed;
  for (auto l = loops->begin(); l != loops->end(); ) {
    auto loop = *l;
    l++;
    changed |= DFSLoops(loop);
    AM.AddAttr(loop->GetHeader(), Lcssa);
  }
  return changed;
}

bool LcSSA::DFSLoops(LoopInfo *l) {
  std::vector<User *> FormingInsts;
  for (auto sub : *l) {
    DFSLoops(sub);
  }
  _DEBUG(std::cerr << "Start To Formal Loop: " << l->GetHeader()->GetName()
                   << std::endl;)
  std::set<BasicBlock *> ContainBB{l->GetLoopBody().begin(),
                                   l->GetLoopBody().end()};
  ContainBB.insert(l->GetHeader());
  for (const auto bb : ContainBB) {
    for (const auto inst : *bb) {
      if (inst->GetUserListSize() == 0)
        continue;
      for (const auto user : inst->GetUserlist()) {
        if (ContainBB.find(user->GetUser()->GetParent()) == ContainBB.end()) {
          // if (auto phi = dynamic_cast<PhiInst *>(user->GetUser()))
          //   if (phi->GetName().find("lcssa") != std::string::npos)
          //     continue;
          FormingInsts.push_back(inst);
        }
      }
    }
  }
  if (FormingInsts.empty())
    return false;
  return FormalLcSSA(FormingInsts);
}

bool LcSSA::FormalLcSSA(std::vector<User *> &FormingInsts) {
  int x = 0;
  bool changed = false;
  std::set<User *> Erase;
  while (!FormingInsts.empty()) {
    std::vector<User *> ShouldRedoLater;
    std::set<PhiInst *> AddPhi;
    std::vector<Use *> Rewrite; //记录inst的所有在外部use
    std::set<BasicBlock *> ContainBB;
    auto target = PopBack(FormingInsts);
    auto GetNameEnum = [](Value *val) {
      int p = 0;
      auto name = val->GetName() + ".lcssa." + std::to_string(p++);
      for (auto use : val->GetUserlist()) {
        auto user = use->GetUser();
        if (user->GetName() == name)
          name = val->GetName() + ".lcssa." + std::to_string(p++);
      }
      return name;
    };
    auto l = loops->LookUp(target->GetParent());
    std::vector<BasicBlock *> exit = loops->GetExit(l);
    ContainBB.insert(l->GetLoopBody().begin(), l->GetLoopBody().end());
    ContainBB.insert(l->GetHeader());
    if (exit.size() <= 0)
      return changed;
    for (auto use : target->GetUserlist()) {
      auto pbb = use->GetUser()->GetParent();
      if (auto phi = dynamic_cast<PhiInst *>(use->GetUser())) {
        pbb = phi->ReturnBBIn(use);
      }
      if (!ContainBB.count(pbb))
        Rewrite.push_back(use);
    }
    if (Rewrite.empty())
      continue;
    x = 0;
    for (auto ex : exit) {
      if (!m_dom->dominates(target->GetParent(), ex))
        continue;
      _DEBUG(std::cerr << "Insert a lcssa Phi: "
                       << target->GetName() + ".lcssa." + std::to_string(x)
                       << std::endl;);
      auto phi = PhiInst::NewPhiNode(ex->front(), ex, target->GetType(),
                                     GetNameEnum(target));
      for (auto rev : m_dom->GetNode(ex->num).rev)
        phi->updateIncoming(target, m_dom->GetNode(rev).thisBlock);
      changed |= true;
      if (auto subloop = loops->LookUp(ex))
        if (!l->Contain(subloop)) {
          //插入的phi如果在另一个循环存在，重新考虑处理
          ShouldRedoLater.push_back(phi);
        }
      AddPhi.insert(phi);
    }
    for (auto rewrite : Rewrite) {
      auto user = rewrite->GetUser();
      auto pbb = user->GetParent();
      if (auto phi = dynamic_cast<PhiInst *>(user)) {
        pbb = phi->ReturnBBIn(rewrite);
      }
      //如果直接是在exitbb
      auto it = std::find(exit.begin(), exit.end(), pbb);
      if (it != exit.end()) {
        //此处可以直接替换
        auto _val = rewrite->GetValue();
        assert(dynamic_cast<PhiInst *>(pbb->front()));
        rewrite->RemoveFromUserList(rewrite->GetUser());
        rewrite->SetValue() = pbb->front();
        pbb->front()->GetUserlist().push_front(rewrite);
        if (auto phi = dynamic_cast<PhiInst *>(user)) {
          //更新record
          for (auto &[_1, val] : phi->PhiRecord) {
            if (val.first == _val) {
              val.first = pbb->front();
            }
          }
        }
        continue;
      }
      //需要进一步检查
      std::set<BasicBlock *> ex{exit.begin(), exit.end()};
      InsertedPhis.clear();
      InsertPhis(rewrite, ex);

      for (auto phi : InsertedPhis) {
        if (auto subloop = loops->LookUp(phi->GetParent()))
          if (!l->Contain(subloop))
            ShouldRedoLater.push_back(phi);
      }
    }
    for (auto phi : ShouldRedoLater) {
      if (phi->GetUserListSize() == 0) {
        Erase.insert(phi);
        continue;
      }
      FormingInsts.push_back(phi);
    }
    for (auto phi : AddPhi) {
      if (phi->GetUserListSize() == 0)
        Erase.insert(phi);
    }
  }
  for (auto d : Erase) {
    delete d;
  }
  return changed;
}

void LcSSA::InsertPhis(Use *u, std::set<BasicBlock *> &exit) {
  std::set<BasicBlock *> target;
  std::set<BasicBlock *> visited;
  auto user = u->GetUser();
  auto _val = u->GetValue();
  auto targetBB = user->GetParent();
  if (auto phi = dynamic_cast<PhiInst *>(user))
    targetBB = phi->ReturnBBIn(u);
  FindBBRecursive(exit, target, visited, targetBB);
  assert(!target.empty());
  //开始创建phi函数
  if (target.size() == 1) {
    auto p = *(target.begin());
    assert(dynamic_cast<PhiInst *>(p->front()));
    u->RemoveFromUserList(u->GetUser());
    u->SetValue() = p->front();
    p->front()->GetUserlist().push_front(u);
    if (auto phi = dynamic_cast<PhiInst *>(u->GetUser())) {
      //更新record
      for (auto &[_1, val] : phi->PhiRecord) {
        if (val.first == _val) {
          val.first = p->front();
        }
      }
    }
  } else if (target.size() > 1) {
    BasicBlock *b = nullptr;
    for (auto bb : target) {
      auto des_1 = m_dom->GetNode(bb->num).des.front();
      if (!b) {
        b = m_dom->GetNode(des_1).thisBlock;
        continue;
      }
      if (b != m_dom->GetNode(des_1).thisBlock) {
        b = nullptr;
        continue;
      }
    }
    assert(b && "What happen?");
    auto phi = PhiInst::NewPhiNode(b->front(), b,
                                   (*(target.begin()))->front()->GetType(),
                                   u->GetValue()->GetName() + ".phi.lcssa");
    InsertedPhis.insert(phi);
    for (auto bb : target)
      phi->updateIncoming(bb->front(), bb);
    u->RemoveFromUserList(u->GetUser());
    u->SetValue() = phi;
    phi->GetUserlist().push_front(u);
    if (auto _phi = dynamic_cast<PhiInst *>(u->GetUser())) {
      //更新record
      for (auto &[_1, val] : _phi->PhiRecord) {
        if (val.first == _val) {
          val.first = phi;
        }
      }
    }
  }
}

void LcSSA::FindBBRecursive(std::set<BasicBlock *> &exit,
                            std::set<BasicBlock *> &target,
                            std::set<BasicBlock *> &visited, BasicBlock *bb) {
  if (visited.insert(bb).second) {
    if (exit.find(bb) != exit.end()) {
      target.insert(bb);
      return;
    }
    for (auto prednode : m_dom->GetNode(bb->num).rev) {
      auto predbb = m_dom->GetNode(prednode).thisBlock;
      FindBBRecursive(exit, target, visited, predbb);
    }
  }
}

void LcSSA::FindBBRoot(BasicBlock *src, BasicBlock *dst,
                       std::set<BasicBlock *> &visited,
                       std::stack<BasicBlock *> &assist) {
  for (auto des : m_dom->GetNode(src->num).des) {
    auto succ = m_dom->GetNode(des).thisBlock;
    if (visited.insert(succ).second && succ != dst) {
      assist.push(succ);
      FindBBRoot(succ, dst, visited, assist);
    }
  }
  assist.pop();
}