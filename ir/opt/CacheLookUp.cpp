#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "Cache.hpp"
#include "Type.hpp"
#include <cassert>
Function *CacheLookUp::_CacheLookUp = nullptr;
bool CacheLookUp::AlreadyInsert = false;

bool CacheLookUp::Run() {
  // For Test ,Now we just insert a single cache
  if (AlreadyInsert)
    return false;
  auto Side = AM.get<SideEffect>(&Singleton<Module>(), false);
  if (!InsertCache())
    return false;
  AlreadyInsert = true;
  return false;
}

bool CacheLookUp::InsertCache() {
  //   auto m_dom = AM.get<dominance>(m_func);
  for (auto bb : *m_func)
    for (auto inst : *bb) {
      if (auto call = dynamic_cast<CallInst *>(inst)) {
        auto name = call->GetOperand(0)->GetName();
        if (name == "getint" || name == "getch" || name == "getfloat" ||
            name == "getfarray" || name == "putint" || name == "putfloat" ||
            name == "putarray" || name == "putfarray" || name == "putf" ||
            name == "getarray" || name == "putch" ||
            name == "_sysy_starttime" || name == "_sysy_stoptime" ||
            name == "llvm.memcpy.p0.p0.i32")
          return false;
        auto callee = dynamic_cast<Function *>(call->GetOperand(0));
        if (callee->HasSideEffect || callee->MemRead() || callee->MemWrite())
          return false;
        auto ty = call->GetTypeEnum();
        if (ty == IR_Value_VOID)
          return false;

        _CacheLookUp = new Function(ty, "CacheLookUp");
        Singleton<Module>().Push_Func(_CacheLookUp);
        // tmp add
        _CacheLookUp->clear();
        auto tmp = new BasicBlock();
        RetInst *tmp_ret = nullptr;
        if (ty == IR_Value_INT)
          tmp_ret = new RetInst(ConstIRInt::GetNewConstant(RetNone));
        else
          tmp_ret = new RetInst(ConstIRFloat::GetNewConstant(RetNone));
        tmp->push_back(tmp_ret);
        _CacheLookUp->push_bb(tmp);
        // insert a new entry
        std::vector<Value *> args;
        for (int i = 0; i < callee->GetParams().size(); i++)
          args.push_back(callee->GetParams()[i].get());
        if (args.size() > 5)
          return false;
        auto EntryBlock = callee->GetBasicBlock().front();
        auto new_entry = new BasicBlock();
        auto new_exit = new BasicBlock();
        auto callCache = new CallInst(_CacheLookUp, args);
        BinaryInst *cmp = nullptr;
        if (ty == IR_Value_INT)
          cmp = BinaryInst::CreateInst(callCache, BinaryInst::Op_NE,
                                       ConstIRInt::GetNewConstant(RetNone));
        else
          cmp = BinaryInst::CreateInst(callCache, BinaryInst::Op_NE,
                                       ConstIRFloat::GetNewConstant(RetNone));
        auto ret = new RetInst(callCache);
        new_entry->push_back(callCache);
        new_entry->push_back(cmp);
        new_entry->GenerateCondInst(cmp, new_exit, EntryBlock);
        new_exit->push_back(ret);
        //插入到front，成为新的entry
        callee->GetBasicBlock().insert(callee->GetBasicBlock().begin(),
                                       new_entry);
        callee->push_front(new_entry);

        callee->push_bb(new_exit);

        return true;
      }
    }
  return false;
}

bool CacheLookUp::checkRecursive(Function *target) {
  for (auto block : *target)
    for (auto inst : *block) {
      if (auto call = dynamic_cast<CallInst *>(inst)) {
        auto callee = dynamic_cast<Function *>(call->GetOperand(0));
        if (callee != target)
          return false;
      }
    }
  return true;
}