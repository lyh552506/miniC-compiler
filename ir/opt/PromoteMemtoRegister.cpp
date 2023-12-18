#include "PromoteMemtoRegister.hpp"

void PromoteMem2Reg::RemoveFromAllocaList(int &index) {
  m_Allocas[index] = m_Allocas.back();
  m_Allocas.pop_back();
  index--;
}

void PromoteMem2Reg::run() {
  AllocaInfo Info;
  BlockInfo BBInfo;
  // starting to deal alloca with promotable,this place are method3,method4
  for (int i = 0; i != m_Allocas.size(); i++) {
    AllocaInst *AI = m_Allocas[i];
    // do some basic opt
    if (!AI->IsUsed()) // if not used,then delete
    {
      AI->DeletFromList();
      RemoveFromAllocaList(i);
      DeadAlloca++;
      continue;
    }
    //看下哪些基本块在使用这些ALLOC，哪些基本块定义了这个ALLOC
    Info.AnalyzeAlloca(AI);
    if (Info.DefineBlocks.size() == 1) { //只有一个定义基本块
      if (RewriteSingleStoreAlloca(Info, AI,BBInfo)) {
        SingleStore++; // rewrite success
        RemoveFromAllocaList(i);
        continue;
      }
    }
    if (Info.IO_OnlySingleBlock &&
        Rewrite_IO_SingleBlock(
            Info, AI,BBInfo)) { // ALLOC出来的局部变量的读或者写都只存在一个基本块中
      RemoveFromAllocaList(i);
      continue;
    }
    std::vector<BasicBlock *> DefineBlock(Info.DefineBlocks.begin(),
                                          Info.DefineBlocks.end());
    PreWorkingAfterInsertPhi(DefineBlock);
  }
}

bool PromoteMem2Reg::Rewrite_IO_SingleBlock(AllocaInfo &Info, AllocaInst *AI,BlockInfo& BBInfo) {
  std::vector<std::pair<int, StoreInst *>> AllStoreInst;
  //遍历alloca的所有use-def
  for (User *user : AI->GetUsers()) {
    if (StoreInst *SI = dynamic_cast<StoreInst *>(user)) {
      // int index=CaculateIndex(); //TODO
    }
  }
}

void AllocaInfo::AnalyzeAlloca(AllocaInst *AI) {
  init();
  //遍历这个allocaInst的user链
  for (User *user : AI->GetUsers()) {
    BasicBlock *BB;
    if (StoreInst *SI = dynamic_cast<StoreInst *>(user)) {
      DefineBlocks.push_back(SI->GetParent());
      BB = SI->GetParent();
      OnlyStore = SI;
      AllocaPtrValue = SI->GetOperand(0);
    } else { //由于IsAllocaPromotable，所以只会是storeinst或者loadinst
      LoadInst *LI = dynamic_cast<LoadInst *>(user);
      BB = LI->GetParent();
      UsingBlocks.push_back(LI->GetParent());
      AllocaPtrValue = LI;
    }

    if (IO_OnlySingleBlock) {
      if (!OnlyBlock)
        OnlyBlock = BB;
      else if (OnlyBlock != BB)
        IO_OnlySingleBlock = false;
    }
  }
}

bool PromoteMem2Reg::RewriteSingleStoreAlloca(AllocaInfo &Info, AllocaInst *AI,
                                              BlockInfo &BBInfo) {
  StoreInst *OnlySt = Info.OnlyStore;
  int StoreIndex = -1;
  bool GlobalVal;

  Value *val = OnlySt->GetOperand(0);
  User *u = dynamic_cast<User *>(val);
  if (u == nullptr)
    GlobalVal = true; //判断store语句的第一个操作数是否是全局变量/常量
  BasicBlock *StoreBB = OnlySt->GetParent();

  // Info.UsingBlocks.clear();
  for (User *user : AI->GetUsers()) {
    LoadInst *LI = dynamic_cast<LoadInst *>(user);
    if (!LI)
      continue;

    if (!GlobalVal) {
      if (LI->GetParent() ==
          StoreBB) { // load语句和当前的store在同一个块如果不是全局变量，需要寻找store和load的次序关系，此时需要查看二者的先后关系
        if (StoreIndex == -1)
          StoreIndex = CaculateIndex(StoreBB, OnlySt);
        int LoadIndex = CaculateIndex(StoreBB, LI);
        if (LoadIndex <
            StoreIndex) { //如果load比store还早一些出现，那么出现undef
          Info.UsingBlocks.push_back(StoreBB);
          continue;
        }
      } else if (
          LI->GetParent() != StoreBB &&
          !m_dom.dominates(
              StoreBB,
              LI->GetParent())) { // loadinst不在唯一store的bb，并且其所在bb不被支配
        Info.UsingBlocks.push_back(LI->GetParent());
        continue;
      }
    }
    LI->ReplaceAllUsersWith(val); // TODO
    LI->EraseFromBlock();         //可以将这个LoadInstruction删除了
  }
  if (!Info.UsingBlocks.empty())
    return false;
  OnlySt->EraseFromBlock(); //结束后删除alloca和store
  AI->EraseFromBlock();
  return true;
}

void PreWorkingAfterInsertPhi(std::vector<BasicBlock *> DefineBlock) {}

bool IsAllocaPromotable(AllocaInst *AI) {
  for (User *user : AI->GetUsers()) {
    if (LoadInst *LI = dynamic_cast<LoadInst *>(user)) {
      // do nothing
    } else if (StoreInst *SI = dynamic_cast<StoreInst *>(user)) {
      if (SI->GetOperand(0) == AI) // can not let the first operand be
                                   // AllocaInst
        return false;
    } else {
      return false;
    }
  }
  return true;
}

bool BlockInfo::IsAllocaRelated(User *Inst) {
  if (LoadInst *LI = dynamic_cast<LoadInst *>(Inst)) { // if read this alloca
    AllocaInst *AI = dynamic_cast<AllocaInst *>(LI->GetSrc());
    if (AI != nullptr)
      return true;
  } else if (StoreInst *ST =
                 dynamic_cast<StoreInst *>(Inst)) { // if store to this alloca
    AllocaInst *AI = dynamic_cast<AllocaInst *>(ST->GetOperand(1));
    if (AI != nullptr)
      return true;
  }
  return false;
}

int BlockInfo::GetInstIndex(User *Inst) {
  if (valid) {
    // std::find(IndexInfo.begin(),IndexInfo.end(),);
    auto it = std::find_if(
        IndexInfo.begin(), IndexInfo.end(),
        [Inst](std::pair<User *, int> &src) { return src.first == Inst; });
    if (it != IndexInfo.end())
      return it->second;
  }
  //目前user查找到当前的bb
  BasicBlock* BB=Inst->GetParent();
  
}