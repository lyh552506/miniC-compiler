#include "LoopParallel.hpp"
#include "CFG.hpp"
#include "Singleton.hpp"
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
  auto header = loop->GetHeader();
  PhiInst *res = nullptr;
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
  LoopSimplify::CaculateLoopInfo(loop, loopAnaly);
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
  for (auto inst : *header) {
    if (dynamic_cast<PhiInst *>(inst)) {
      inst->EraseFromParent();
      substitute->push_back(inst);
    } else {
      break;
    }
  }
  
}