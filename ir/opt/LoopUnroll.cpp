#include "../../include/ir/opt/LoopUnroll.hpp"
#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/ir/Analysis/dominant.hpp"
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/lib/Singleton.hpp"
#include "BlockMerge.hpp"
#include "LoopSimplify.hpp"
#include "Type.hpp"
#include <algorithm>
#include <cassert>
#include <cmath>
#include <cstdlib>
#include <type_traits>
#include <unistd.h>
#include <unordered_map>
#include <vector>

bool LoopUnroll::Run() {
  dom = AM.get<dominance>(m_func);
  loopAnaly = AM.get<LoopAnalysis>(m_func, dom, std::ref(DeleteLoop));
  std::vector<LoopInfo *> loops{loopAnaly->begin(), loopAnaly->end()};
  for (auto iter = loops.begin(); iter != loops.end();) {
    auto loop = *iter;
    ++iter;
    if (AM.FindAttr(loop->GetHeader(), Rotate) && CanBeFullUnroll(loop)) {
      auto unrollbody = ExtractLoopBody(loop);
      if (unrollbody) {
        auto bb = Unroll(loop, unrollbody);
        CleanUp(loop, bb);
        return true;
      }
    } else if (AM.FindAttr(loop->GetHeader(), Rotate) &&
               CanBeHalfUnroll(loop)) {
      auto unrollbody = ExtractLoopBody(loop);
      if (unrollbody) {
        auto bb = Half_Unroll(loop, unrollbody);
        Singleton<Module>().Test();
        std::cout << std::endl;
        return false;
        CleanUp(loop, bb);
        return true;
      }
    }
  }
  return false;
}

CallInst *LoopUnroll::ExtractLoopBody(LoopInfo *loop) {
  auto &body = loop->GetLoopBody();
  Val2Arg.clear();
  auto header = loop->GetHeader();
  auto latch = loopAnaly->GetLatch(loop);
  prehead = loopAnaly->GetPreHeader(loop);
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
  auto UnrollFunc =
      new Function(ty, Singleton<Module>().GetFuncNameEnum("Loop_Body"));
  Singleton<Module>().Push_Func(UnrollFunc);
  UnrollFunc->clear();
  UnrollFunc->tag = Function::UnrollBody;
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
  OriginChange = loopchange;
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
              UnrollFunc->SetType(res->GetType());
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
    UnrollFunc->push_bb(bb);
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

BasicBlock *LoopUnroll::Unroll(LoopInfo *loop, CallInst *UnrollBody) {
  BasicBlock *tmp = nullptr;
  auto iteration = 0;
  auto initial = dynamic_cast<ConstIRInt *>(loop->trait.initial)->GetVal();
  auto bound = dynamic_cast<ConstIRInt *>(loop->trait.boundary)->GetVal();
  auto bin = dynamic_cast<BinaryInst *>(loop->trait.change);
  auto exitBBs = loopAnaly->GetExit(loop);
  assert(exitBBs.size() == 1);
  assert(bin);
  auto exit = exitBBs[0];
  auto op = bin->getopration();
  auto step = loop->trait.step;
  switch (op) {
  case BinaryInst::Op_Add:
    iteration = (bound - initial + step + (step > 0 ? -1 : 1)) / step;
    break;
  case BinaryInst::Op_Sub:
    iteration = (initial - bound + step + (step > 0 ? -1 : 1)) / step;
    break;
  case BinaryInst::Op_Mul:
    iteration = std::log(bound / initial) / std::log(step);
    break;
  case BinaryInst::Op_Div:
    iteration = std::log(initial / bound) / std::log(step);
    break;
  default:
    assert(0 && "what op?");
  }
  std::unordered_map<Value *, Value *> Arg2Orig;
  Value *IndVarOrigin = loop->trait.initial;
  Value *ResOrigin = nullptr;
  if (loop->trait.res)
    ResOrigin = loop->trait.res->ReturnValIn(prehead);
  auto replceArg = [&](User *call, Value *IndVar, Value *Res) {
    for (int i = 1; i < call->Getuselist().size(); i++) {
      auto arg = call->GetOperand(i);
      if (auto phi = dynamic_cast<PhiInst *>(arg)) {
        if (phi == loop->trait.indvar) {
          Arg2Orig[arg] = IndVar;
        } else if (phi == loop->trait.res) {
          Arg2Orig[arg] = Res;
        }
      } else {
        Arg2Orig[arg] = arg;
      }
    }
  };
  replceArg(UnrollBody, IndVarOrigin, ResOrigin);
  BasicBlock::mylist<BasicBlock, User>::iterator call_pos(UnrollBody);
  std::vector<User *> Erase;
  User *cloned = UnrollBody;
  Erase.push_back(cloned);
  Value *CurChange = nullptr;
  for (int i = 0; i < iteration; i++) {
    auto Ret = m_func->InlineCall(dynamic_cast<CallInst *>(cloned), Arg2Orig);
    if (Ret.first != nullptr)
      ResOrigin = Ret.first;
    tmp = Ret.second;
    CurChange = Arg2Orig[OriginChange];
    Arg2Orig.clear();
    cloned = cloned->CloneInst();
    Erase.push_back(cloned);
    call_pos = call_pos.insert_after(cloned);
    replceArg(cloned, CurChange, ResOrigin);
  }
  auto callee = dynamic_cast<Function *>(UnrollBody->GetOperand(0));
  if (ResOrigin)
    UnrollBody->RAUW(ResOrigin);
  loop->trait.indvar->RAUW(UndefValue::get(loop->trait.indvar->GetType()));
  delete loop->trait.indvar;
  if (loop->trait.res) {
    loop->trait.res->RAUW(UndefValue::get(loop->trait.res->GetType()));
    delete loop->trait.res;
  }
  for (auto use : UnrollBody->GetUserlist()) {
    if (use->GetUser()->GetParent() == exit)
      use->GetUser()->RSUW(use, ResOrigin);
  }
  for (auto iter = Erase.begin(); iter != Erase.end();) {
    auto call = *iter;
    ++iter;
    delete call;
  }
  Singleton<Module>().EraseFunction(callee);
  return tmp;
}

bool LoopUnroll::CanBeFullUnroll(LoopInfo *loop) {
  const auto body = loop->GetLoopBody();
  LoopSimplify::CaculateLoopInfo(loop, loopAnaly);
  if (loop->CantCalcTrait())
    return false;
  if (loop->trait.boundary->GetTypeEnum() != IR_Value_INT)
    return false;
  auto header = loop->GetHeader();
  auto latch = loopAnaly->GetLatch(loop);
  if (header != latch)
    return false;
  if (!dynamic_cast<ConstIRInt *>(loop->trait.initial) ||
      !dynamic_cast<ConstIRInt *>(loop->trait.boundary))
    return false;

  int iteration = 0;
  auto initial = dynamic_cast<ConstIRInt *>(loop->trait.initial)->GetVal();
  auto bound = dynamic_cast<ConstIRInt *>(loop->trait.boundary)->GetVal();
  auto bin = dynamic_cast<BinaryInst *>(loop->trait.change);
  auto op = bin->getopration();
  auto step = loop->trait.step;
  switch (op) {
  case BinaryInst::Op_Add:
    iteration = (bound - initial + step + (step > 0 ? -1 : 1)) / step;
    break;
  case BinaryInst::Op_Sub:
    iteration = (initial - bound + step + (step > 0 ? -1 : 1)) / step;
    break;
  case BinaryInst::Op_Mul:
    iteration = std::log(bound / initial) / std::log(step);
    break;
  case BinaryInst::Op_Div:
    iteration = std::log(initial / bound) / std::log(step);
    break;
  default:
    assert(0 && "what op?");
  }
  int cost = CaculatePrice(body, m_func, iteration);
  if (cost > MaxInstCost)
    return false;
  return true;
}

bool LoopUnroll::CanBeHalfUnroll(LoopInfo *loop) {
  const auto body = loop->GetLoopBody();
  LoopSimplify::CaculateLoopInfo(loop, loopAnaly);
  if (loop->CantCalcTrait())
    return false;
  if (loop->trait.boundary->GetTypeEnum() != IR_Value_INT)
    return false;
  auto header = loop->GetHeader();
  auto latch = loopAnaly->GetLatch(loop);
  if (header != latch)
    return false;
  auto op = loop->trait.cmp->getopration();
  switch (op) {
  case BinaryInst::Op_G:
  case BinaryInst::Op_GE:
  case BinaryInst::Op_L:
  case BinaryInst::Op_LE:
    break;
  default:
    return false;
  }
  int iteration = 0;
  int cost = CaculatePrice(body, m_func);
  if (cost > 50)
    HalfUnrollTimes = 4;
  else
    HalfUnrollTimes = 6;
  return true;
}

void LoopUnroll::CleanUp(LoopInfo *loop, BasicBlock *clean) {
  auto cond = dynamic_cast<CondInst *>(clean->back());
  auto Inloop = dynamic_cast<BasicBlock *>(cond->GetOperand(1));
  auto Outloop = dynamic_cast<BasicBlock *>(cond->GetOperand(2));
  if (loop->Contain(Outloop))
    std::swap(Inloop, Outloop);
  auto uncond = new UnCondInst(Outloop);
  delete cond;
  clean->push_back(uncond);
  loopAnaly->DeleteLoop(loop);
}

int LoopUnroll::CaculatePrice(const std::vector<BasicBlock *> &body,
                              Function *curfunc, int Iteration) {
  int cost = 0;
  for (auto bb : body) {
    for (auto inst : *bb) {
      if (dynamic_cast<LoadInst *>(inst) || dynamic_cast<StoreInst *>(inst)) {
        cost += 4;
      } else if (dynamic_cast<GetElementPtrInst *>(inst)) {
        cost += 2;
      } else if (dynamic_cast<CallInst *>(inst)) {
        auto callee = dynamic_cast<Function *>(inst->GetOperand(0));
        if (callee) {
          if (callee == curfunc)
            return MaxInstCost + 1;
          cost += CaculatePrice(body, callee, Iteration);
        } else
          cost += 2;
      } else {
        cost++;
      }
    }
  }
  return cost * Iteration;
}

BasicBlock *LoopUnroll::Half_Unroll(LoopInfo *loop, CallInst *UnrollBody) {
  auto Unroll_Entry = new BasicBlock();
  auto MutiUnrollBlock = new BasicBlock();
  m_func->push_bb(Unroll_Entry);
  m_func->push_bb(MutiUnrollBlock);
  auto Single = loop->GetHeader();
  Unroll_Entry->SetName(Unroll_Entry->GetName() + ".entry");
  MutiUnrollBlock->SetName(MutiUnrollBlock->GetName() + ".muti");
  auto head = loop->GetHeader();
  auto bound = loop->trait.boundary;
  auto op = loop->trait.cmp->getopration();
  auto initial = loop->trait.initial;
  bool NeedReverse = false;
  User *new_call = nullptr;
  BasicBlock *tmp = nullptr;
  std::unordered_map<Value *, Value *> HeaderValMap;
  // check the bound side, bound is not promised to be rhs
  if (bound == loop->trait.cmp->GetOperand(0)) {
    NeedReverse = true;
  }
  auto ReverOp = [](BinaryInst::Operation _op) {
    switch (_op) {
    case BinaryInst::Op_L:
      return BinaryInst::Op_G;
    case BinaryInst::Op_G:
      return BinaryInst::Op_L;
    case BinaryInst::Op_GE:
      return BinaryInst::Op_LE;
    case BinaryInst::Op_LE:
      return BinaryInst::Op_GE;
    default:
      assert(0 && "What happened?");
    }
  };
  if (NeedReverse)
    op = ReverOp(op);
  BinaryInst *cmp = nullptr;
  switch (op) {
  // cmp initial > bound
  case BinaryInst::Op_G:
  case BinaryInst::Op_GE: {
    auto add = BinaryInst::CreateInst(
        bound, BinaryInst::Op_Add, ConstIRInt::GetNewConstant(HalfUnrollTimes));
    cmp = BinaryInst::CreateInst(initial, op, add);
    Unroll_Entry->push_back(add);
    Unroll_Entry->push_back(cmp);
  } break;
  // cmp initial < bound
  case BinaryInst::Op_L:
  case BinaryInst::Op_LE: {
    auto sub = BinaryInst::CreateInst(
        bound, BinaryInst::Op_Sub, ConstIRInt::GetNewConstant(HalfUnrollTimes));
    cmp = BinaryInst::CreateInst(initial, op, sub);
    Unroll_Entry->push_back(sub);
    Unroll_Entry->push_back(cmp);
  } break;
  }
  Unroll_Entry->GenerateCondInst(cmp, MutiUnrollBlock, Single);

  std::unordered_map<Value *, Value *> Arg2Orig;
  Value *IndVarOrigin = loop->trait.initial;
  Value *ResOrigin = nullptr;
  if (loop->trait.res)
    ResOrigin = loop->trait.res->ReturnValIn(prehead);

  // map the new block
  PhiInst *new_indvar = nullptr, *new_res = nullptr;
  bool insert = false;
  for (auto inst : *head) {
    if (auto phi = dynamic_cast<PhiInst *>(inst)) {
      if (phi == loop->trait.indvar) {
        new_indvar = PhiInst::NewPhiNode(loop->trait.indvar->GetType());
        new_indvar->updateIncoming(IndVarOrigin, Unroll_Entry);
        MutiUnrollBlock->push_back(new_indvar);
        insert = true;
        HeaderValMap[loop->trait.indvar] = new_indvar;
      } else if (phi == loop->trait.res && insert) {
        new_res = PhiInst::NewPhiNode(loop->trait.res->GetType());
        new_res->updateIncoming(ResOrigin, Unroll_Entry);
        MutiUnrollBlock->push_back(new_res);
        HeaderValMap[loop->trait.res] = new_res;
      }
    } else {
      auto new_inst = inst->CloneInst();
      HeaderValMap[inst] = new_inst;
      if (inst == UnrollBody)
        new_call = new_inst;
      for (int i = 0; i < new_inst->Getuselist().size(); i++) {
        if (HeaderValMap.find(new_inst->GetOperand(i)) != HeaderValMap.end()) {
          new_inst->RSUW(i, HeaderValMap[new_inst->GetOperand(i)]);
        }
      }
      MutiUnrollBlock->push_back(new_inst);
    }
  }
  auto replceArg = [&](User *call, Value *IndVar, Value *Res) {
    for (int i = 1; i < call->Getuselist().size(); i++) {
      auto arg = call->GetOperand(i);
      if (auto phi = dynamic_cast<PhiInst *>(arg)) {
        if (phi == new_indvar) {
          Arg2Orig[arg] = IndVar;
        } else if (phi == new_res) {
          Arg2Orig[arg] = Res;
        }
      } else {
        Arg2Orig[arg] = arg;
      }
    }
  };

  replceArg(new_call, IndVarOrigin, ResOrigin);
  BasicBlock::mylist<BasicBlock, User>::iterator call_pos(new_call);
  std::vector<User *> Erase;
  User *cloned = new_call;
  Erase.push_back(cloned);
  Value *CurChange = nullptr;
  for (int i = 0; i < HalfUnrollTimes; i++) {
    auto Ret = m_func->InlineCall(dynamic_cast<CallInst *>(cloned), Arg2Orig);
    if (Ret.first != nullptr)
      ResOrigin = Ret.first;
    tmp = Ret.second;
    CurChange = Arg2Orig[OriginChange];
    Arg2Orig.clear();
    cloned = cloned->CloneInst();
    Erase.push_back(cloned);
    call_pos = call_pos.insert_after(cloned);
    replceArg(cloned, CurChange, ResOrigin);
  }
  for (auto iter = Erase.begin(); iter != Erase.end();) {
    auto call = *iter;
    ++iter;
    delete call;
  }
  //TODO 插入cmp和branch指令，维护rotate形式
  
}