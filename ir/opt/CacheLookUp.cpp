#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/ir/opt/Cache.hpp"
#include "../../include/lib/Singleton.hpp"
#include "../../include/lib/Type.hpp"
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
  for (auto iter_bb = m_func->begin(); iter_bb != m_func->end();) {
    auto bb = *iter_bb;
    ++iter_bb;
    for (auto iter_inst = bb->begin(); iter_inst != bb->end();) {
      auto inst = *iter_inst;
      ++iter_inst;
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
        auto Exit = callee->GetRetBlock();
        auto dom = AM.get<dominance>(m_func);
        auto loops = AM.get<LoopAnalysis>(m_func, dom, std::ref(DeleteLoop));
        if (loops->GetLoops().size() > 0)
          return false;
        if (Exit.size() > 3)
          return false;
        // insert a new entry
        std::vector<Value *> args;
        for (int i = 0; i < callee->GetParams().size(); i++)
          args.push_back(callee->GetParams()[i].get());
        if (args.size() != 2)
          return false;
        _CacheLookUp = new Function(IR_PTR, "CacheLookUp");
        _CacheLookUp->tag = Function::BuildIn;
        Singleton<Module>().Push_Func(_CacheLookUp);
        _CacheLookUp->clear();

        auto EntryBlock = callee->GetBasicBlock().front();
        auto new_entry = new BasicBlock();
        auto new_exit = new BasicBlock();
        auto callCache = new CallInst(_CacheLookUp, args);
        // get the struct
        auto gep = new GetElementPtrInst(callCache->GetType());
        gep->AddArg(callCache);
        gep->AddArg(ConstIRInt::GetNewConstant(3));
        auto load = new LoadInst(gep);
        BinaryInst *cmp = nullptr;
        cmp = BinaryInst::CreateInst(load, BinaryInst::Op_NE,
                                     ConstIRInt::GetNewConstant(0));
        new_entry->push_back(callCache);
        new_entry->push_back(gep);
        new_entry->push_back(load);
        new_entry->push_back(cmp);

        // have cached val, load it
        auto gep_val = new GetElementPtrInst(callCache->GetType());
        gep_val->AddArg(callCache);
        gep_val->AddArg(ConstIRInt::GetNewConstant(2));
        auto cachedval = new LoadInst(gep_val);
        cachedval->SetType(callee->GetType());
        auto ret = new RetInst(cachedval);
        new_entry->push_back(gep_val);
        new_entry->push_back(cachedval);
        new_exit->push_back(ret);
        new_entry->GenerateCondInst(cmp, new_exit, EntryBlock);
        //插入到front，成为新的entry
        callee->GetBasicBlock().insert(callee->GetBasicBlock().begin(),
                                       new_entry);
        callee->push_front(new_entry);
        callee->push_bb(new_exit);
        // didnt find it, store the ret val
        for (auto Retblock : Exit) {
          auto iter = Retblock->rbegin();
          auto ret = dynamic_cast<RetInst *>(*iter);
          assert(ret);
          auto st_mark = new StoreInst(ConstIRInt::GetNewConstant(1),
                                       gep); // mark have cached
          auto st_val = new StoreInst(ret->GetOperand(0), gep_val);

          auto param1_storage = new StoreInst(args[0], callCache);

          auto param2_offset = new GetElementPtrInst(callCache);
          param2_offset->add_use(ConstIRInt::GetNewConstant(1));

          auto param2_storage = new StoreInst(args[1], param2_offset);

          iter = iter.insert_before(st_mark);
          iter = iter.insert_after(st_val);
          iter = iter.insert_after(param1_storage);
          iter = iter.insert_after(param2_offset);
          iter = iter.insert_after(param2_storage);
        }
        return true;
      }
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