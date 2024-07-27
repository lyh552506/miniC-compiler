#include "LoopParallel.hpp"
#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <set>
#include <string>
#include <unistd.h>
#include <unordered_map>
#include <vector>

// only analysis main function, so inline must take place before this pass
bool LoopParallel::Run() {
  bool changed = false;
  if (m_func->GetName() != "main")
    return false;
  dom = AM.get<dominance>(m_func);
  loopAnaly = AM.get<LoopAnalysis>(m_func, dom);
  for (auto loop : *loopAnaly) {
    ExtractLoopParallelBody(loop);
  }
  return changed;
}

void LoopParallel::ExtractLoopParallelBody(LoopInfo *loop) {
  auto &body = loop->GetLoopBody();
  LoopSimplify::CaculateLoopInfo(loop, loopAnaly);
  auto header = loop->GetHeader();
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
        return;
      }
    } else {
      break;
    }
  }
  InnerDataType ty = InnerDataType::IR_Value_VOID;
  if (res)
    ty = res->GetTypeEnum();
  auto ParallFunc =
      new Function(ty, Singleton<Module>().GetFuncNameEnum("Loop_Body"));
  Singleton<Module>().Push_Func(ParallFunc);
  std::unordered_map<Value *, Variable *> Val2Arg;
  auto indvar = loop->trait.indvar;
  Val2Arg[indvar] = new Variable(Variable::Param, indvar->GetType(), "");
  if (res)
    Val2Arg[res] = new Variable(Variable::Param, res->GetType(), "");
  auto judge = [&](Value *target) {
    if (dynamic_cast<BasicBlock *>(target))
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
    ParallFunc->PushMyParam(arg);
  auto substitute = new BasicBlock();
  substitute->SetName(substitute->GetName() + ".Substitute");
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
  auto callinst = new CallInst(ParallFunc, args);
  substitute->push_back(callinst);
  auto loopchange = dynamic_cast<User *>(loop->trait.change);
  assert(loopchange);
  auto change = loopchange->CloneInst();
  substitute->push_back(change);
  auto loopcmp = dynamic_cast<User *>(loop->GetHeader()->back()->GetOperand(0));
  assert(loopcmp);
  auto cmp = loopcmp->CloneInst();
  substitute->push_back(cmp);
  auto latch = loopAnaly->GetLatch(loop);
  BasicBlock *exit = nullptr;
  if (auto cond = dynamic_cast<CondInst *>(latch->back()))
    for (int i = 1; i < 3; i++) {
      if (cond->GetOperand(i) != latch)
        exit = dynamic_cast<BasicBlock *>(cond->GetOperand(i));
    }
  assert(exit);
  auto br = new CondInst(cmp, substitute, exit);
  substitute->push_back(br);
  //修改header和exit
  
}