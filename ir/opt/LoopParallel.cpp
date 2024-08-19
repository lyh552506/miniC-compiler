#include "../../include/ir/opt/LoopParallel.hpp"
#include "../../include/ir/Analysis/AliasAnalysis.hpp"
#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/ir/opt/LoopSimplify.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/lib/Type.hpp"
#include "../../util/my_stl.hpp"
#include "../../include/ir/opt/New_passManager.hpp"
#include <algorithm>
#include <cassert>
#include <cmath>
#include <cstdlib>
#include <unordered_map>
#include <unordered_set>
#include <vector>
Variable *LoopParallel::Storage_int = nullptr;
Variable *LoopParallel::Storage_float = nullptr;
// only analysis main function, so inline must take place before this pass
bool LoopParallel::Run() {
  if (m_func->tag != Function::Normal)
    return false;
  bool changed = false;
  dom = AM.get<dominance>(m_func);
  loopAnaly = AM.get<LoopAnalysis>(m_func, dom, std::ref(DeleteLoop));

  if (m_func->GetName() != "main")
    return false;
  for (auto bb : *m_func)
    for (auto iter = bb->begin();
         iter != bb->end() && dynamic_cast<PhiInst *>(*iter);) {
      auto phi = dynamic_cast<PhiInst *>(*iter);
      ++iter;
      Value *val = nullptr;
      for (auto &use : phi->Getuselist()) {
        if (!val)
          val = use->GetValue();
        else {
          if (val != use->GetValue()) {
            val = nullptr;
            break;
          }
        }
      }
      if (val) {
        phi->RAUW(val);
        delete phi;
      }
    }
  std::vector<LoopInfo *> loops{loopAnaly->begin(), loopAnaly->end()};
  std::sort(loops.begin(), loops.end(), [&](LoopInfo *l, LoopInfo *r) {
    return dom->dominates(l->GetHeader(), r->GetHeader());
  });
  for (auto loop : loops) {
    if (ExcutedLoops.find(loop->GetHeader()) == ExcutedLoops.end() &&
        CanBeParallel(loop)) {
      // std::cerr << "Find a Parallelable Loop: " << loop->GetHeader()->GetName()
                // << "\n";
      SubstitudeTrait.Init();
      auto call = ExtractLoopParallelBody(loop);
      MakeWorkThread(loop->trait.initial, loop->trait.boundary, call);
      return true;
    }
  }
  return changed;
}

bool LoopParallel::CanBeParallel(LoopInfo *loop) {
  if (!AM.FindAttr(loop->GetHeader(), Rotate))
    return false;
  auto header = loop->GetHeader();
  auto latch = loopAnaly->GetLatch(loop);
  LoopSimplify::CaculateLoopInfo(loop, loopAnaly);
  assert(latch && header);
  PhiInst *resPhi = nullptr;
  int cnt = 0;
  for (auto inst : *header) {
    if (auto phi = dynamic_cast<PhiInst *>(inst)) {
      cnt++;
      if (inst == loop->trait.indvar)
        continue;
      resPhi = phi;
      if (cnt > 2) {
        _DEBUG(std::cerr << "Cant Deal To Much Phi" << std::endl;)
        return false;
      }
    } else {
      break;
    }
  }

  auto cmp = dynamic_cast<BinaryInst *>(loop->trait.cmp);
  if (!cmp)
    return false;
  switch (cmp->getopration()) {
  default:
    return false;
  case BinaryInst::Op_L:
  case BinaryInst::Op_G:
  case BinaryInst::Op_LE:
  case BinaryInst::Op_GE:
    break;
  }
  // special trait
  auto in = dynamic_cast<ConstIRInt *>(loop->trait.initial);
  auto bou = dynamic_cast<ConstIRInt *>(loop->trait.boundary);
  if (in && bou) {
    auto indata = in->GetVal(), boudata = bou->GetVal();
    auto bin = dynamic_cast<BinaryInst *>(loop->trait.change);
    auto op = bin->getopration();
    auto step = loop->trait.step;
    int iteration = 0;
    switch (op) {
    case BinaryInst::Op_Add:
      iteration = (boudata - indata + step + (step > 0 ? -1 : 1)) / step;
      break;
    case BinaryInst::Op_Sub:
      iteration = (indata - boudata + step + (step > 0 ? -1 : 1)) / step;
      break;
    case BinaryInst::Op_Mul:
      iteration = std::log(boudata / indata) / std::log(step);
      break;
    case BinaryInst::Op_Div:
      iteration = std::log(indata / boudata) / std::log(step);
      break;
    default:
      assert(0 && "what op?");
    }
    if (iteration <= 100)
      return false;
  }
  bool Outer = false;
  bool Inner = false;
  bool NoBinary = true;
  if (resPhi) {
    // return false;  //tmp choice
    auto res = resPhi->ReturnValIn(latch);
    // res必须是加
    if (!dynamic_cast<BinaryInst *>(res))
      return false;
    auto bin = dynamic_cast<BinaryInst *>(res);
    if (bin->getopration() != BinaryInst::Op_Add)
      return false;
    std::set<Value *> assist{resPhi, res};
    for (auto use : res->GetUserlist()) {
      auto UserBB = use->GetUser()->GetParent();
      if (!loop->Contain(UserBB))
        Outer = true;
      if (assist.find(use->GetUser()) == assist.end() &&
          loop->Contain(UserBB)) {
        // if (Inner)
        //   return false; // 30_many
        auto userbin = dynamic_cast<BinaryInst *>(use->GetUser());
        if (!userbin || userbin->getopration() != BinaryInst::Op_Add)
          return false;
        Inner = true;
      }
      if (auto bin = dynamic_cast<BinaryInst *>(res)) {
        NoBinary = false;
      }
    }
    for (auto use : resPhi->GetUserlist()) {
      auto UserBB = use->GetUser()->GetParent();
      if (!loop->Contain(UserBB))
        Outer = true;
      if (assist.find(use->GetUser()) == assist.end() && loop->Contain(UserBB))
        Inner = true;
    }
    if (Outer && Inner)
      return false;
    if (NoBinary)
      return false;
    ShoudPreserveRes = true;
  }

  auto ex = loopAnaly->GetExit(loop);
  for (auto bb : loop->GetLoopBody())
    for (auto des : dom->GetNode(bb->num).des) {
      auto desBB = dom->GetNode(des).thisBlock;
      if (!loop->Contain(desBB) && bb != latch)
        return false;
    }
  std::unordered_set<Value *> Ignore{loop->trait.indvar, loop->trait.change};
  if (resPhi) {
    Ignore.insert(resPhi);
    Ignore.insert(resPhi->ReturnValIn(latch));
  }
  for (auto bb : loop->GetLoopBody())
    for (auto inst : *bb) {
      if (Ignore.find(inst) != Ignore.end())
        continue;
      for (auto use : inst->GetUserlist()) {
        if (!loop->Contain(use->GetUser()->GetParent()))
          return false;
      }
    }

  if (loop->CantCalcTrait())
    return false;
  if (!DependencyAnalysis(loop))
    return false;
  return true;
}

CallInst *LoopParallel::ExtractLoopParallelBody(LoopInfo *loop) {
  auto &body = loop->GetLoopBody();
  Val2Arg.clear();
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
  if (res) {
    ty = res->GetTypeEnum();
    SubstitudeTrait.res = res;
  }
  auto ParallelFunc =
      new Function(ty, Singleton<Module>().GetFuncNameEnum("Loop_Body"));
  Singleton<Module>().Push_Func(ParallelFunc);
  ParallelFunc->clear();
  ParallelFunc->tag = Function::LoopBody;
  auto indvar = loop->trait.indvar;
  SubstitudeTrait.indvar = indvar;
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
  auto substitute = new BasicBlock();
  substitute->SetName(header->GetName() + ".Substitute");
  m_func->add_block(substitute);
  SubstitudeTrait.head = substitute;
  for (const auto &[val, arg] : Val2Arg)
    ParallelFunc->PushMyParam(arg);
  for (auto it = header->begin(); it != header->end();) {
    auto inst = *it;
    ++it;
    if (auto phi = dynamic_cast<PhiInst *>(inst)) {
      inst->EraseFromParent();
      substitute->push_back(inst);
    } else {
      break;
    }
  }

  // Preserve Result
  if (ShoudPreserveRes) {
    // auto loadG = new LoadInst(Storage);
    for (auto rev : dom->GetNode(latch->num).rev) {
      if (dom->GetNode(rev).thisBlock != latch) {
        auto init = res->ReturnValIn(dom->GetNode(rev).thisBlock);
        StoreInst *StoreG = nullptr;
        if (res->GetTypeEnum() == IR_Value_INT)
          StoreG = new StoreInst(init, Storage_int);
        else
          StoreG = new StoreInst(init, Storage_float);
        substitute->push_back(StoreG);
      }
    }
  }
  std::vector<Value *> args;
  for (const auto &[val, arg] : Val2Arg)
    args.push_back(val);
  auto callinst = new CallInst(ParallelFunc, args);
  substitute->push_back(callinst);
  SubstitudeTrait.call = callinst;

  auto loopchange = dynamic_cast<User *>(loop->trait.change);
  SubstitudeTrait.change = loopchange;
  auto loopcmp = dynamic_cast<BinaryInst *>(latch->back()->GetOperand(0));
  assert(loopcmp);
  auto cmp = loopcmp->CloneInst();
  SubstitudeTrait.step = loop->trait.step;
  SubstitudeTrait.boundary = loop->trait.boundary;
  SubstitudeTrait.cmp = dynamic_cast<BinaryInst *>(cmp);
  // find the bound value
  auto bound = GetBoundVal(loopcmp->getopration(), loop, loopcmp);
  SubstitudeTrait.CmpEqual = loop->trait.CmpEqual;
  for (auto use : loopchange->GetUserlist()) {
    auto userBB = use->GetUser()->GetParent();
    auto user = use->GetUser();
    if (!loop->Contain(userBB) && userBB != substitute &&
        dynamic_cast<PhiInst *>(user)) {
      auto phi = dynamic_cast<PhiInst *>(user);
      phi->ReplaceVal(use, bound);
    }
  }

  BasicBlock *_exit = nullptr;
  if (auto cond = dynamic_cast<CondInst *>(latch->back()))
    for (int i = 1; i < 3; i++) {
      if (cond->GetOperand(i) != latch)
        _exit = dynamic_cast<BasicBlock *>(cond->GetOperand(i));
    }
  assert(_exit);
  auto br = new UnCondInst(_exit);
  substitute->push_back(br);

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
  auto Exit = loopAnaly->GetExit(loop);

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
            phi->RSUW(it1->first, bound);
            it1->second.first = bound;
          }
        }
        // else if (res && it1->second.first == res->ReturnValIn(latch)) {
        //   phi->RSUW(it1->first, callinst);
        //   it1->second.first = callinst;
        // } else if (!res && dynamic_cast<PhiInst *>(it1->second.first)) {
        //   auto phi_res = dynamic_cast<PhiInst *>(it1->second.first);
        //   if (phi_res->GetParent() == latch) {
        //     // res only have store, no use
        //     res = phi_res;
        //     ParallelFunc->SetType(res->GetType());
        //     callinst->SetType(res->GetType());
        //     phi_res->RSUW(it1->first, callinst);
        //     it1->second.first = callinst;
        //     NoUse = true;
        //   }
        // }
        // else {
        //   continue;
        // loop rotate dont insert new Exit, so this situation can be:
        //    prehead
        //     /      \
            // header   \
            //    \     /
        //      Exit (phi.lcssa=[header],[prehead])
        //     }
        //   }
        // }
      }
  RetInst *ret = nullptr;
  if (res) {
    auto resval = res->ReturnValIn(latch);
    resval->RAUW(callinst);
    ret = new RetInst(resval);
  } else {
    ret = new RetInst();
  }
  delete latch->back();
  latch->push_back(ret);
  for (auto it = substitute->begin();
       it != substitute->end() && dynamic_cast<PhiInst *>(*it); ++it) {
    auto phi = dynamic_cast<PhiInst *>(*it);
    phi->EraseRecordByBlock(latch);
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
  }
  for (auto bb : loop->GetLoopBody())
    ExcutedLoops.insert(bb);
  loopAnaly->DeleteLoop(loop);
  return callinst;
}

bool LoopParallel::DependencyAnalysis(LoopInfo *loop) {
  std::unordered_map<Value *, std::pair<Value *, Value *>> PointerAnaly;
  std::unordered_map<LoadInst *, StoreInst *> ldst;
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
        else
          continue;
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
                return false;
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
              ldst[ld] = st;
              ld = nullptr;
              st = nullptr;
            }
          }
        }
  }
  // if (!ldst.empty())
  //   return false;
  // Can Parallel , Try change to atomic
  std::vector<Value *> Erase;
  for (auto &[ld, st] : ldst) {
    // match pattern like:
    //   %2=load %1, %3=%2 op other, store %3,%1
    assert(ld->GetUserlist().GetSize() == 1 &&
           st->GetOperand(1) == ld->GetOperand(0));
    auto bin = dynamic_cast<BinaryInst *>(ld->GetUserlist().Front()->GetUser());
    auto StoreVal = st->GetOperand(0);
    auto operand = st->GetOperand(1);
    if (!bin || bin != StoreVal)
      break;
    if (bin->GetUserListSize() != 1)
      return false;
    if (bin->getopration() != BinaryInst::Op_Add)
      return false;
    _DEBUG(std::cerr << "Match Load Store!" << std::endl;)
    auto change =
        bin->GetOperand(0) == ld ? bin->GetOperand(1) : bin->GetOperand(0);
    auto Atomic = new BinaryInst(operand, bin->getopration(), change, true);
    BasicBlock::mylist<BasicBlock, User>::iterator insert_pos(st);
    insert_pos.insert_before(Atomic);
    Erase.push_back(st);
    Erase.push_back(bin);
    Erase.push_back(ld);
  }
  for (auto iter = Erase.begin(); iter != Erase.end();) {
    auto inst = *iter;
    inst->RAUW(UndefValue::get(inst->GetType()));
    ++iter;
    delete inst;
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

void LoopParallel::MakeWorkThread(Value *begin, Value *end,
                                  CallInst *loop_body) {
  std::set<Value *> Ignore;
  auto head = SubstitudeTrait.head;
  bool HasRes = SubstitudeTrait.res == nullptr ? false : true;
  std::unordered_map<Value *, Variable *> ValMap;
  auto Parallel =
      new Function(InnerDataType::IR_Value_VOID,
                   Singleton<Module>().GetFuncNameEnum("Parallel_Target"));
  auto beg = new Variable(Variable::Param, IntType::NewIntTypeGet(), "");
  auto en = new Variable(Variable::Param, IntType::NewIntTypeGet(), "");
  Parallel->PushMyParam(beg); // beg
  Parallel->PushMyParam(en);  // end
  // ValMap[begin] = beg;
  // ValMap[end] = en;
  if (SubstitudeTrait.CmpEqual)
    Parallel->CmpEqual = true;
  Singleton<Module>().Push_Func(Parallel);
  Parallel->clear();
  Parallel->tag = Function::ParallelBody;
  auto Entry = new BasicBlock();
  Parallel->push_bb(Entry);
  auto While_Loop = new BasicBlock();
  Parallel->push_bb(While_Loop);
  auto Exit = new BasicBlock();
  Parallel->push_bb(Exit);
  Entry->SetName(Entry->GetName() + ".Entry");
  While_Loop->SetName(While_Loop->GetName() + ".While_Loop");
  Exit->SetName(Exit->GetName() + ".Exit");
  Entry->GenerateUnCondInst(While_Loop);

  if (ShoudPreserveRes) {
    auto st = SubstitudeTrait.res->GetTypeEnum() == IR_Value_INT
                  ? Storage_int
                  : Storage_float;
    auto loadG = new LoadInst(st);
    auto iter = head->rbegin();
    iter.insert_before(loadG);
    loop_body->RAUW(loadG);
    // TODO当前只支持add的res变量
    auto add2res = new BinaryInst(st, BinaryInst::Op_Add, loop_body, true);
    Exit->push_back(add2res);
    Ignore.insert(loadG);
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
  auto Indvar = PhiInst::NewPhiNode(SubstitudeTrait.change->GetType());
  auto cmp = SubstitudeTrait.cmp;
  auto op = cmp->GetOperand(1) == SubstitudeTrait.boundary
                ? cmp->getopration()
                : ReverOp(cmp->getopration());
  auto loopchange = SubstitudeTrait.change->CloneInst();
  loopchange->RSUW(0, Indvar);
  auto new_cmp = BinaryInst::CreateInst(loopchange, op, en);
  PhiInst *res = nullptr;
  Indvar->updateIncoming(beg, Entry);
  Indvar->updateIncoming(loopchange, While_Loop);

  While_Loop->push_back(Indvar);
  SubstitudeTrait.indvar->RAUW(Indvar);
  delete SubstitudeTrait.indvar;
  PhiInst *new_res = nullptr;

  if (HasRes) {
    assert(SubstitudeTrait.res->PhiRecord.size() == 1);
    // auto orig = SubstitudeTrait.res->GetOperand(0);
    auto orig = FindResInitial(SubstitudeTrait.res);
    if (!orig->isConstZero()) {
      auto st = SubstitudeTrait.res->GetTypeEnum() == IR_Value_INT
                    ? Storage_int
                    : Storage_float;
      StoreInst *init_0 = nullptr;
      if (SubstitudeTrait.res->GetTypeEnum() == IR_Value_INT)
        init_0 = new StoreInst(ConstIRInt::GetNewConstant(0), st);
      else
        init_0 = new StoreInst(ConstIRFloat::GetNewConstant(0), st);
      Entry->push_front(init_0);
    }
    new_res = PhiInst::NewPhiNode(SubstitudeTrait.res->GetType());
    new_res->updateIncoming(orig, Entry);
    new_res->updateIncoming(SubstitudeTrait.call, While_Loop);
    While_Loop->push_back(new_res);
    SubstitudeTrait.res->RAUW(new_res);
  }
  // maping
  std::unordered_set<User *> Worklist{loop_body};
  Worklist.insert(loopchange);
  // WA case:./testcases/functional/62_percolation.sy
  // Reason : when begin and end is const, const step will be faultly RSUW to
  // beg and en No need to insert new_cmp for it has already been successfully
  // adjusted Worklist.insert(new_cmp);
  if (HasRes)
    Worklist.insert(new_res);
  for (auto inst : Worklist) {
    for (int i = 0; i < inst->Getuselist().size(); i++) {
      auto op = inst->GetOperand(i);
      if (res)
        if (op == res)
          continue;
      if (ValMap.find(op) == ValMap.end() &&
          Judge(loop_body->GetParent(), op) && op != Indvar &&
          op != loopchange && op != new_res) {
        ValMap[op] = new Variable(Variable::Param, op->GetType(), "");
      }
    }
  }
  for (auto inst : Worklist) {
    for (auto &use : inst->Getuselist()) {
      if (ValMap.find(use->GetValue()) != ValMap.end()) {
        if (auto phi = dynamic_cast<PhiInst *>(inst))
          phi->ReplaceVal(use.get(), ValMap[use->GetValue()]);
        else
          inst->RSUW(use.get(), ValMap[use->GetValue()]);
      }
    }
  }
  // add arg
  std::vector<Value *> args{begin, end};
  for (const auto &[val, arg] : ValMap)
    args.push_back(val);
  for (const auto [val, arg] : ValMap)
    Parallel->PushMyParam(arg);

  // replace
  for (auto iter = head->begin(); iter != head->end();) {
    auto inst = *iter;
    ++iter;
    if (dynamic_cast<UnCondInst *>(inst) || dynamic_cast<LoadInst *>(inst) ||
        dynamic_cast<StoreInst *>(inst)) {
      continue;
    }
    if (auto phi = dynamic_cast<PhiInst *>(inst)) {
      assert(phi->PhiRecord.size() == 1);
      continue;
    }
    inst->EraseFromParent();
    While_Loop->push_back(inst);
  }

  While_Loop->push_back(loopchange);
  While_Loop->push_back(new_cmp);
  While_Loop->GenerateCondInst(new_cmp, While_Loop, Exit);
  auto callinst = new CallInst(Parallel, args);
  auto it = head->rbegin();
  if (HasRes)
    --it;
  it.insert_before(callinst);
  Exit->GenerateRetInst();
  return;
}

bool LoopParallel::Judge(BasicBlock *bb, Value *target) {
  if (dynamic_cast<BasicBlock *>(target) || dynamic_cast<Function *>(target))
    return false;
  auto name = target->GetName();
  if (name == "getint" || name == "getch" || name == "getfloat" ||
      name == "getfarray" || name == "putint" || name == "putfloat" ||
      name == "putarray" || name == "putfarray" || name == "putf" ||
      name == "getarray" || name == "putch" || name == "_sysy_starttime" ||
      name == "_sysy_stoptime" || name == "llvm.memcpy.p0.p0.i32")
    return false;
  if (target->isConst() || target->isGlobal())
    return false;
  auto user = dynamic_cast<User *>(target);
  assert(user);
  if (user->GetParent() == bb)
    return false;
  return true;
}

void LoopParallel::SimplifyPhi(LoopInfo *loop) {
  auto Exit = loopAnaly->GetExit(loop);
  auto bound = loop->trait.boundary;
  auto change = loop->trait.change;
  if (loop->trait.step && loop->trait.step == 1)
    for (auto use : change->GetUserlist()) {
      auto user = use->GetUser();
      auto it = std::find(Exit.begin(), Exit.end(), user->GetParent());
      if (it != Exit.end() && dynamic_cast<PhiInst *>(user)) {
        auto phi = dynamic_cast<PhiInst *>(user);
        phi->ReplaceVal(use, bound);
      }
    }
}

bool LoopParallel::TempChoice(LoopInfo *loop) {
  for (auto bb : loop->GetLoopBody())
    for (auto inst : *bb)
      for (auto use : inst->GetUserlist()) {
        auto userBB = use->GetUser()->GetParent();
        if (!loop->Contain(userBB))
          return false;
      }
  return true;
}

Value *LoopParallel::GetBoundVal(BinaryInst::Operation op, LoopInfo *loop,
                                 User *cmp) {
  auto latch = loopAnaly->GetLatch(loop);
  auto step = loop->trait.step;
  auto Bound = loop->trait.boundary;
  auto initial = loop->trait.initial;
  // auto new_exit = new BasicBlock();
  // new_exit->SetName(new_exit->GetName() + ".Calc");
  // for (auto rev : dom->GetNode(loop->GetHeader()->num).rev) {
  //   auto revBB = dom->GetNode(rev).thisBlock;
  //   if (!loop->Contain(revBB)) {
  //     if (!prehead)
  //       prehead = revBB;
  //     else
  //       assert(0);
  //   }
  // }
  // for (auto des : dom->GetNode(latch->num).des) {
  //   auto revBB = dom->GetNode(des).thisBlock;
  //   if (!loop->Contain(revBB)) {
  //     if (!prehead)
  //       prehead = revBB;
  //     else
  //       assert(0);
  //   }
  // }
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
  op = cmp->GetOperand(1) == Bound ? op : ReverOp(op);
  switch (op) {
  case BinaryInst::Op_L:
  case BinaryInst::Op_G:
    if (step != 0) {
      // auto sub = BinaryInst::CreateInst(Bound, BinaryInst::Op_Sub, initial);
      // auto u_div = BinaryInst::CreateInst(sub, BinaryInst::Op_Div,
      //                                     ConstIRInt::GetNewConstant(step));
      // auto mul = BinaryInst::CreateInst(u_div, BinaryInst::Op_Mul,
      //                                   ConstIRInt::GetNewConstant(step));
      // auto add = BinaryInst::CreateInst(mul, BinaryInst::Op_Add, initial);
      // new_exit->push_back(sub);
      // new_exit->push_back(u_div);
      // new_exit->push_back(mul);
      // new_exit->push_back(add);
      // m_func->InsertBlock(latch, Exit, new_exit);
      // return add;
      return Bound;
    }
  case BinaryInst::Op_LE:
  case BinaryInst::Op_GE:
    loop->trait.CmpEqual = true;
    return Bound;
  default:
    assert(0 && "What happened?");
  }
}

void LoopParallel::PreserveResult(LoopInfo *loop) {
  auto header = loop->GetHeader();
  auto latch = loopAnaly->GetLatch(loop);

  LoopSimplify::CaculateLoopInfo(loop, loopAnaly);
  assert(latch && header);
  PhiInst *resPhi = nullptr;
  int cnt = 0;
  for (auto inst : *header) {
    if (auto phi = dynamic_cast<PhiInst *>(inst)) {
      cnt++;
      if (inst == loop->trait.indvar)
        continue;
      resPhi = phi;
    } else {
      break;
    }
  }
}

Value *LoopParallel::FindResInitial(Value *res) {
  if (!dynamic_cast<PhiInst *>(res))
    return res;
  auto phi = dynamic_cast<PhiInst *>(res);
  if (phi->Getuselist().size() == 1) {
    return FindResInitial(phi->Getuselist()[0]->GetValue());
  }
  auto loop = loopAnaly->LookUp(phi->GetParent());
  if (phi->GetParent() != loop->GetHeader())
    assert(0 && "Cant happen");
  for (auto rev : dom->GetNode(phi->GetParent()->num).rev) {
    auto revBB = dom->GetNode(rev).thisBlock;
    if (!loop->Contain(revBB)) {
      auto income = phi->ReturnValIn(revBB);
      return FindResInitial(income);
    }
  }
}