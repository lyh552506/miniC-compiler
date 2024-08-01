#include "../../include/ir/opt/LoopUnroll.hpp"
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/lib/Singleton.hpp"
#include "../../include/ir/Analysis/dominant.hpp"
#include <vector>

bool LoopUnroll::Run() {
  dom = AM.get<dominance>(m_func);
  loopAnaly = AM.get<LoopAnalysis>(m_func, dom);
  for (auto iter = loopAnaly->begin(); iter != loopAnaly->end();) {
    auto loop = *iter;
    ++iter;
    if (loop->LoopForm.find(LoopInfo::Rotate) != loop->LoopForm.end())
      auto unroll = ExtractLoopBody(loop);
  }
}

Function *LoopUnroll::ExtractLoopBody(LoopInfo *loop) {
  auto &body = loop->GetLoopBody();
  LoopSimplify::CaculateLoopInfo(loop, loopAnaly);
  if (loop->CantCalcTrait())
    return nullptr;
  if (!dynamic_cast<ConstantData *>(loop->trait.initial) ||
      !dynamic_cast<ConstantData *>(loop->trait.boundary))
    return nullptr;
  auto header = loop->GetHeader();
  auto latch = loopAnaly->GetLatch(loop);
  PhiInst *res = nullptr; // result += const ....
  int cnt = 0;
  for (auto inst : *header) {
    if (auto phi = dynamic_cast<PhiInst *>(inst)) {
      cnt++;
      if (inst == loop->trait.indvar)
        continue;
      res = phi;
      if (cnt > 2) {
        _DEBUG(std::cerr << "Cant Deal To Much Phi" << std::endl;)
        return nullptr;
      }
    } else {
      break;
    }
  }
  InnerDataType ty = InnerDataType::IR_Value_VOID;
  if (res)
    ty = res->GetTypeEnum();
  auto UnrollFunc =
      new Function(ty, Singleton<Module>().GetFuncNameEnum("Loop_Body"));
  Singleton<Module>().Push_Func(UnrollFunc);
  UnrollFunc->clear();
  UnrollFunc->tag = Function::UnrollBody;
  std::unordered_map<Value *, Variable *> Val2Arg;
  auto indvar = loop->trait.indvar;
  Val2Arg[indvar] = new Variable(Variable::Param, indvar->GetType(), "");
  if (res)
    Val2Arg[res] = new Variable(Variable::Param, res->GetType(), "");
  auto judge = [&](Value *target) {
    if (dynamic_cast<BasicBlock *>(target) || dynamic_cast<Function *>(target))
      return false;
    if (Val2Arg.count(target))
      return false;
    if (target->isConst() || target->isGlobal())
      return false;
    auto user = dynamic_cast<User *>(target);
    assert(user);
    if (loop->Contain(user->GetParent()))
      return false;
    return true;
  };
  for (auto bb : body)
    for (auto inst : *bb) {
      if (Val2Arg.count(inst))
        continue;
      for (int i = 0; i < inst->Getuselist().size(); i++) {
        auto op = inst->GetOperand(i);
        if (judge(op))
          Val2Arg[op] = new Variable(Variable::Param, op->GetType(), "");
      }
    }
  for (const auto &[val, arg] : Val2Arg)
    UnrollFunc->PushMyParam(arg);
  auto substitute = new BasicBlock();
  substitute->SetName(header->GetName() + ".Substitute");
  m_func->add_block(substitute);
  for (auto it = header->begin(); it != header->end();) {
    auto inst = *it;
    ++it;
    if (dynamic_cast<PhiInst *>(inst)) {
      inst->EraseFromParent();
      substitute->push_back(inst);
    } else {
      break;
    }
  }
  std::vector<Value *> args;
  for (const auto &[val, arg] : Val2Arg)
    args.push_back(val);
  auto callinst = new CallInst(UnrollFunc, args);
  substitute->push_back(callinst);
  auto loopchange = dynamic_cast<User *>(loop->trait.change);
  assert(loopchange);
  auto change = loopchange->CloneInst();
  substitute->push_back(change);
  loop->trait.change = change;
  auto loopcmp = dynamic_cast<User *>(latch->back()->GetOperand(0));
  assert(loopcmp);
  auto cmp = loopcmp->CloneInst();
  substitute->push_back(cmp);
  BasicBlock *exit = nullptr;
  if (auto cond = dynamic_cast<CondInst *>(latch->back()))
    for (int i = 1; i < 3; i++) {
      if (cond->GetOperand(i) != latch)
        exit = dynamic_cast<BasicBlock *>(cond->GetOperand(i));
    }
  assert(exit);
  auto br = new CondInst(cmp, substitute, exit);
  substitute->push_back(br);
  for (auto &use : cmp->Getuselist()) {
    if (use->GetValue() == loopchange)
      cmp->RSUW(use.get(), change);
  }
  //修改header和exit
  for (auto rev : dom->GetNode(loop->GetHeader()->num).rev)
    if (dom->GetNode(rev).thisBlock != latch) {
      auto prehead = dom->GetNode(rev).thisBlock;
      if (auto cond = dynamic_cast<CondInst *>(prehead->back())) {
        for (int i = 1; i < 3; i++) {
          if (cond->GetOperand(i) == header)
            cond->RSUW(i, substitute);
        }
      } else if (auto uncond = dynamic_cast<UnCondInst *>(prehead->back())) {
        uncond->RSUW(0, substitute);
      }
    }

  for (auto des : dom->GetNode(latch->num).des)
    if (dom->GetNode(des).thisBlock != header)
      for (auto it = dom->GetNode(des).thisBlock->begin();
           it != dom->GetNode(des).thisBlock->end() &&
           dynamic_cast<PhiInst *>(*it);
           ++it) {
        auto phi = dynamic_cast<PhiInst *>(*it);
        auto it1 = std::find_if(
            phi->PhiRecord.begin(), phi->PhiRecord.end(),
            [latch](
                const std::pair<int, std::pair<Value *, BasicBlock *>> &ele) {
              return ele.second.second == latch;
            });
        if (it1 != phi->PhiRecord.end()) {
          it1->second.second = substitute;
          if (it1->second.first == loopchange)
            it1->second.first = change;
          else if (res && it1->second.first == res->ReturnValIn(latch))
            it1->second.first = callinst;
          else {
            assert(0 && "what happened?");
          }
        }
      }
  delete latch->back();
  if (res) {
    auto ret = new RetInst(res->ReturnValIn(latch));
    latch->push_back(ret);
  } else {
    auto ret = new RetInst();
    latch->push_back(ret);
  }
  // deal phi
  for (auto it = substitute->begin();
       it != substitute->end() && dynamic_cast<PhiInst *>(*it); ++it) {
    auto phi = dynamic_cast<PhiInst *>(*it);
    for (int i = 0; i < phi->PhiRecord.size(); i++) {
      if (phi->PhiRecord[i].second == latch)
        phi->Del_Incomes(i);
    }
  }
  for (auto bb : body)
    for (auto inst : *bb) {
      for (auto &use : inst->Getuselist()) {
        if (Val2Arg.find(use->GetValue()) != Val2Arg.end())
          inst->RSUW(use.get(), Val2Arg[use->GetValue()]);
      }
    }
  if (res)
    res->updateIncoming(callinst, substitute);
  loop->trait.indvar->updateIncoming(loop->trait.change, substitute);
  //转移
  for (auto bb : body) {
    bb->EraseFromParent();
    UnrollFunc->push_bb(bb);
  }
  return UnrollFunc;
}
