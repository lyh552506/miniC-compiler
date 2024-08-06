#include "../../include/ir/opt/LoopParallel.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "AliasAnalysis.hpp"
#include "LoopSimplify.hpp"
#include "my_stl.hpp"
#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <iostream>
#include <set>
#include <string>
#include <unistd.h>
#include <unordered_map>
#include <vector>

// only analysis main function, so inline must take place before this pass
bool LoopParallel::Run() {
  bool changed = false;
  dom = AM.get<dominance>(m_func);
  loopAnaly = AM.get<LoopAnalysis>(m_func, dom);

  if (m_func->GetName() != "main")
    return false;
  for (auto loop : *loopAnaly) {
    if (CanBeParallel(loop)) {
      std::cerr << "Find a Parallelable Loop!"
                << "\n";
      auto call = ExtractLoopParallelBody(loop);
    }
  }
  return changed;
}

bool LoopParallel::CanBeParallel(LoopInfo *loop) {
  auto header = loop->GetHeader();
  int cnt = 0;
  for (auto inst : *header) {
    if (auto phi = dynamic_cast<PhiInst *>(inst)) {
      cnt++;
      if (inst == loop->trait.indvar)
        continue;
      if (cnt > 2) {
        _DEBUG(std::cerr << "Cant Deal To Much Phi" << std::endl;)
        return false;
      }
    } else {
      break;
    }
  }
  LoopSimplify::CaculateLoopInfo(loop, loopAnaly);
  if (loop->CantCalcTrait())
    return false;
  if (!DependencyAnalysis(loop))
    return false;
  return true;
}

CallInst *LoopParallel::ExtractLoopParallelBody(LoopInfo *loop) {
  auto &body = loop->GetLoopBody();
  std::unordered_map<Value *, Variable *> Val2Arg;
  auto header = loop->GetHeader();
  auto latch = loopAnaly->GetLatch(loop);
  auto prehead = loopAnaly->GetPreHeader(loop);
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
  loop->trait.res = res;
  InnerDataType ty = InnerDataType::IR_Value_VOID;
  if (res)
    ty = res->GetTypeEnum();
  auto ParallelFunc =
      new Function(ty, Singleton<Module>().GetFuncNameEnum("Parall_Body"));
  Singleton<Module>().Push_Func(ParallelFunc);
  ParallelFunc->clear();
  ParallelFunc->tag = Function::UnrollBody;
  auto indvar = loop->trait.indvar;
  Val2Arg[indvar] = new Variable(Variable::Param, indvar->GetType(), "");
  if (res)
    Val2Arg[res] = new Variable(Variable::Param, res->GetType(), "");
  auto judge = [&](Value *target) {
    if (dynamic_cast<BasicBlock *>(target) || dynamic_cast<Function *>(target))
      return false;
    auto name = target->GetName();
    if (name == "getint" || name == "getch" || name == "getfloat" ||
        name == "getfarray" || name == "putint" || name == "putfloat" ||
        name == "putarray" || name == "putfarray" || name == "putf" ||
        name == "getarray" || name == "putch" || name == "_sysy_starttime" ||
        name == "_sysy_stoptime" || name == "llvm.memcpy.p0.p0.i32")
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
    ParallelFunc->PushMyParam(arg);
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
  auto callinst = new CallInst(ParallelFunc, args);
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
  BasicBlock *_exit = nullptr;
  if (auto cond = dynamic_cast<CondInst *>(latch->back()))
    for (int i = 1; i < 3; i++) {
      if (cond->GetOperand(i) != latch)
        _exit = dynamic_cast<BasicBlock *>(cond->GetOperand(i));
    }
  assert(_exit);
  auto br = new CondInst(cmp, substitute, _exit);
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

  bool NoUse = false;
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
          if (it1->second.first == loopchange) {
            phi->RSUW(it1->first, change);
            it1->second.first = change;
          } else if (res && it1->second.first == res->ReturnValIn(latch)) {
            phi->RSUW(it1->first, callinst);
            it1->second.first = callinst;
          } else if (!res && dynamic_cast<PhiInst *>(it1->second.first)) {
            auto phi_res = dynamic_cast<PhiInst *>(it1->second.first);
            if (phi_res->GetParent() == latch) {
              // res only have store, no use
              res = phi_res;
              ParallelFunc->SetType(res->GetType());
              callinst->SetType(res->GetType());
              phi_res->RSUW(it1->first, callinst);
              it1->second.first = callinst;
              NoUse = true;
            }
          } else {
            assert(0 && "what happened?");
          }
        }
      }
  RetInst *ret = nullptr;
  if (res && !NoUse) {
    ret = new RetInst(res->ReturnValIn(latch));
  } else if (res && NoUse) {
    assert(res->GetParent() == latch);
    ret = new RetInst(res);
  } else {
    ret = new RetInst();
  }
  delete latch->back();
  latch->push_back(ret);
  for (auto it = substitute->begin();
       it != substitute->end() && dynamic_cast<PhiInst *>(*it); ++it) {
    auto phi = dynamic_cast<PhiInst *>(*it);
    for (int i = 0; i < phi->PhiRecord.size(); i++) {
      if (phi->PhiRecord[i].second == latch) {
        phi->Del_Incomes(i--);
        phi->FormatPhi();
      }
    }
  }
  for (auto bb : body)
    for (auto inst : *bb) {
      for (auto &use : inst->Getuselist()) {
        if (Val2Arg.find(use->GetValue()) != Val2Arg.end()) {
          if (auto phi = dynamic_cast<PhiInst *>(inst))
            phi->ReplaceVal(use.get(), Val2Arg[use->GetValue()]);
          else
            inst->RSUW(use.get(), Val2Arg[use->GetValue()]);
        }
      }
    }
  if (res && !NoUse)
    res->updateIncoming(callinst, substitute);
  loop->trait.indvar->updateIncoming(loop->trait.change, substitute);
  //转移
  substitute->num = header->num;
  m_func->GetBasicBlock()[header->num] = substitute;
  dom->GetNode(header->num).thisBlock = substitute;
  std::vector<BasicBlock *> tmp{body.begin(), body.end()};
  for (auto iter = tmp.begin(); iter != tmp.end();) {
    auto bb = *iter;
    ++iter;
    bb->EraseFromParent();
    ParallelFunc->push_bb(bb);
    if (bb != header)
      loopAnaly->DeleteBlock(bb);
    else {
      loopAnaly->ReplBlock(bb, substitute);
      loop->setHeader(substitute);
      loopAnaly->setLoop(substitute, loop);
    }
  }
  return callinst;
}

void LoopParallel::ClearLoop(LoopInfo *loop) {
  auto &body = loop->GetLoopBody();
  for (auto it = body.begin(); it != body.end();) {
    auto contain = *it;
    ++it;
    delete contain;
  }
}

bool LoopParallel::DependencyAnalysis(LoopInfo *loop) {
  std::unordered_map<Value *, std::pair<Value *, Value *>> PointerAnaly;
  auto body = loop->GetLoopBody();
  // only trans Load/Store Inst
  auto GetTarget = [](User *inst) {
    if (dynamic_cast<LoadInst *>(inst)) {
      return inst->GetOperand(0);
    } else if (dynamic_cast<StoreInst *>(inst)) {
      return inst->GetOperand(1);
    } else
      assert(0);
  };
  for (auto bb : body)
    for (auto inst : *bb) {
      int tag = 0; // 1->load 2->store
      if (inst->IsTerminateInst())
        break;
      Operand target = nullptr;
      if (dynamic_cast<LoadInst *>(inst)) {
        target = inst->GetOperand(0);
        tag = 1;
      } else if (dynamic_cast<StoreInst *>(inst)) {
        target = inst->GetOperand(1);
        tag = 2;
      } else if (auto call = dynamic_cast<CallInst *>(inst)) {
        if (call->HasSideEffect())
          return false;
      } else
        continue;
      assert(target);
      auto Base = FindPointBase(target);
      if (!Base)
        return false;
      if (tag == 1)
        PointerAnaly[Base].first = inst;
      else if (tag == 2)
        PointerAnaly[Base].second = inst;
    }
  for (const auto &[Base, val] : PointerAnaly) {
    if (!val.first || !val.second)
      continue;
    LoadInst *ld = nullptr;
    StoreInst *st = nullptr;
    for (auto bb : body)
      for (auto inst : *bb)
        if (dynamic_cast<LoadInst *>(inst) || dynamic_cast<StoreInst *>(inst)) {
          auto Target = GetTarget(inst);
          auto _base = FindPointBase(Target);
          if (_base == Base) {
            if (dynamic_cast<LoadInst *>(inst)) {
              if (ld) {
                assert(0 && "What case?");
              }
              ld = dynamic_cast<LoadInst *>(inst);
            } else {
              if (!ld)
                return false;
              st = dynamic_cast<StoreInst *>(inst);
              // %1= arr[i]
              // %2=%1+ const
              // arr[i]=%2
              if (st->GetOperand(1) != ld->GetOperand(0) ||
                  ld->GetUserlist().GetSize() != 1) {
                //可能存在类似arr[i]=arr[i-1] + sum 的例子
                return false;
              }
            }
          }
        }
  }
  return true;
}

// receive Load/Store Inst
// return pointer base if it is arr
Value *LoopParallel::FindPointBase(Value *val) {
  Operand target = nullptr;
  if (auto ld = dynamic_cast<LoadInst *>(val)) {
    target = ld->GetOperand(0);
  } else if (auto st = dynamic_cast<StoreInst *>(val)) {
    target = st->GetOperand(1);
  } else if (val->isGlobal()) {
    return val;
  } else if (auto gep = dynamic_cast<GetElementPtrInst *>(val)) {
    auto base = gep->GetOperand(0);
    while (auto g = dynamic_cast<GetElementPtrInst *>(base))
      base = g->GetOperand(0);
    if (dynamic_cast<LoadInst *>(base))
      return FindPointBase(base);
    return base;
  }
  return nullptr;
}

Function &LoopParallel::GetParallelFunc() {
  static Function func(InnerDataType::IR_Value_VOID, "MainParallel");
  static bool Create = false;
  if (Create) {
    func.clear();
    func.tag = Function::UnrollBody;
    // insert param, waiting for Function Ptr
    // TODO
    Create = true;
  }
  return func;
}