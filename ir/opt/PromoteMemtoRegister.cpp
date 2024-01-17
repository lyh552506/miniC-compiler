#include "PromoteMemtoRegister.hpp"

void PromoteMem2Reg::RemoveFromAllocaList(int &index) {
  m_Allocas[index] = m_Allocas.back();
  m_Allocas.pop_back();
  index--;
}

void PromoteMem2Reg::run() {
  AllocaInfo Info;
  BlockInfo BBInfo;
  IDF idf(m_dom);
  // starting to deal alloca with promotable,this place are method3,method4
  for (int i = 0; i != m_Allocas.size(); i++) {
    AllocaInst *AI = m_Allocas[i];
    // do some basic opt
    if (!AI->IsUsed()) // if not used,then delete
    {
      // AI->DeletFromList();
      AI->EraseFromParent();
      RemoveFromAllocaList(i);
      DeadAlloca++;
      continue;
    }
    //看下哪些基本块在使用这个ALLOC，哪些基本块定义了这个ALLOC
    Info.AnalyzeAlloca(AI);

    if (Info.DefineBlocks.size() == 1) { //只有一个定义基本块
      if (RewriteSingleStoreAlloca(Info, AI, BBInfo)) {
        SingleStore++; // rewrite success
        RemoveFromAllocaList(i);
        // Singleton<Module>().Test();
        // return;
        continue;
      }
    }
    if (Info.IO_OnlySingleBlock &&
        Rewrite_IO_SingleBlock(
            Info, AI,
            BBInfo)) { // ALLOC出来的局部变量的读或者写都只存在一个基本块中
      RemoveFromAllocaList(i);
      continue;
    }

    AllocaToIndex[m_Allocas[i]] = i;

    std::set<BasicBlock *> DefineBlock(Info.DefineBlocks.begin(),
                                       Info.DefineBlocks.end());
    std::set<BasicBlock *> LiveInBlocks;
    PreWorkingAfterInsertPhi(DefineBlock, BBInfo, Info, AI, LiveInBlocks);
    std::vector<BasicBlock *> PhiBlocks;

    idf.SetDefBB(DefineBlock);
    idf.SetLiveInBlock(LiveInBlocks);
    auto& vec = Func.GetBasicBlock();
    idf.SetBBs(vec);
    for (int dex = 0; dex < PhiBlocks.size(); dex++)
      InsertPhiNode(PhiBlocks[dex], i);
  }

  //下面开始为重命名做准备
  std::vector<Value *> AllocaDict;
  for (int x = 0; x < m_Allocas.size(); x++)
    AllocaDict[x] = UndefValue::get(
        m_Allocas[x]->GetType()); //首先对所有待处理的Alloca标记为Undef

  std::vector<RenamePass> WorkLists; //采用工作表法，传入EntryBlock
  // WorkLists.emplace_back(Func.front_block(), nullptr, std::move(AllocaDict));
  WorkLists.emplace_back(Func.front_block(), nullptr, AllocaDict);
  do {
    auto tmp = std::move(WorkLists.back()); // FIXME maybe have some problems
    WorkLists.pop_back();
    Rename(tmp.CurBlock, tmp.Pred, tmp.IncomingVal, WorkLists);
  } while (!WorkLists.empty());
}

void PromoteMem2Reg::Rename(BasicBlock *BB, BasicBlock *Pred,
                            std::vector<Value *> &IncomingVal,
                            std::vector<RenamePass>& WorkLists) {
  while (1) {
    //当前块存在Phi指令
    if (PhiInst *Phi = dynamic_cast<PhiInst *>(BB->front())) {
      if (PhiToAlloca.count(Phi)) {
        // auto tmp = m_dom.GetNode(Pred->num);
        // int length = std::count(tmp.des.begin(), tmp.des.end(),
        //                         BB->num); //找到前驱有几个通往当前BB的Edge

        for (auto Inst = BB->begin(); Inst != BB->end();) {
          int Allocanum = PhiToAlloca[Phi];
          Phi->updateIncoming(IncomingVal[Allocanum], BB);

          // IncomingVal[Allocanum]=Phi;

          ++Inst;
          PhiInst *Phi = dynamic_cast<PhiInst *>(*Inst);
          if (!Phi)
            break;
        }
      }
    }

    if (!RenameVisited.insert(BB).second)
      return;
    // 下面的for循环是在做替换。
    // 比如 %a = alloca i32
    //		%0 = load i32 %a
    //		store i32 5, i32* %0
    //		store i32* %0, i32* %1
    //		那么就会变成：
    //		store i32 5, i32* %1
    //		else分支中的store同上，做完这一切之后，删除相对应的load和store
    for (auto inst = BB->begin(); inst != BB->end(); ++inst) {
      User *user = *inst;
      if (LoadInst *LI = dynamic_cast<LoadInst *>(user)) {
        Value *Src = LI->GetSrc();
        AllocaInst *AI = dynamic_cast<AllocaInst *>(Src); // src---->%a
        if (!AI)
          continue;

        auto it = AllocaToIndex.find(AI);
        if (it == AllocaToIndex.end())
          continue;

        Value *RepL = IncomingVal[it->second]; //使用Alloca的value来替换
        LI->RAUW(RepL);
        LI->EraseFromParent();
      } else if (StoreInst *ST = dynamic_cast<StoreInst *>(user)) {
        auto& des = ST->Getuselist();
        Value *Des = des[1]->GetValue(); //获取Store的第二个操作数
        AllocaInst *AI = dynamic_cast<AllocaInst *>(Des);
        if (!AI)
          continue;

        auto it = AllocaToIndex.find(AI);
        if (it == AllocaToIndex.end())
          continue;

        Value *RepL =
            ST->Getuselist()[0]->GetValue(); //使用Store的第一个操作数来替换
        IncomingVal[it->second] = RepL; //--->更新前面初始化的undef

        ST->EraseFromParent();
      }
    }

    //将BB的后继添加到worklist继续循环处理
    auto cur = m_dom.GetNode(BB->num);
    if (cur.des.empty())
      return;

    auto It = cur.des.begin();

    Pred = BB;
    BB = m_dom.GetNode(*It++).thisBlock;

    while (It != cur.des.end()) {
      WorkLists.emplace_back(BB, Pred, IncomingVal);
      ++It;
    }
  }
}

bool PromoteMem2Reg::InsertPhiNode(BasicBlock *bb, int AllocaNum) {
  auto& vect = Func.GetBasicBlock();
  auto it = std::find_if(vect.begin(), vect.end(),
                         [bb](std::unique_ptr<BasicBlock> &base) -> bool {
                           return base.get() == bb;
                         }); // get index

  int index = std::distance(vect.begin(), it); //获取下标
  PhiInst *&Phi = PrePhiNode[index];
  if (Phi)
    return false;
  AllocaInst *target = m_Allocas[AllocaNum];
  Phi = PhiInst::NewPhiNode(bb->front(), bb,
                            target->GetType()); // insert into the head of block
  PhiToAlloca[Phi] = AllocaNum;
  return true;
}

bool PromoteMem2Reg::Rewrite_IO_SingleBlock(AllocaInfo &Info, AllocaInst *AI,
                                            BlockInfo &BBInfo) {
  std::vector<std::pair<int, StoreInst *>> StoreInstWithIndex;
  //遍历alloca的所有user
  // for (User *user : AI->GetUsers()) {
  for (Use *use : AI->GetUserlist()) {
    User *user = use->GetUser();
    if (StoreInst *SI = dynamic_cast<StoreInst *>(user))
      StoreInstWithIndex.push_back(std::make_pair(BBInfo.GetInstIndex(SI), SI));
  }
  std::sort(StoreInstWithIndex.begin(), StoreInstWithIndex.end(),
            [](const std::pair<int, StoreInst *> &T1,
               const std::pair<int, StoreInst *> &T2) -> bool {
              return T1.first < T2.first;
            }); //方便进行后续的二分搜索

  //for (User *user : AI->GetUsers()) {
  for (Use *use : AI->GetUserlist()) {
    User* user=use->GetUser();
    if (LoadInst *LI = dynamic_cast<LoadInst *>(user)) {
      int loadindex = BBInfo.GetInstIndex(LI);
      auto it = std::lower_bound(
          StoreInstWithIndex.begin(), StoreInstWithIndex.end(),
          std::make_pair(loadindex, static_cast<StoreInst *>(nullptr)),
          [](const std::pair<int, StoreInst *> &T1,
             const std::pair<int, StoreInst *> &T2) -> bool {
            return T1.first < T2.first;
          }); // find the first value which index is bigger than the inst in
              // container
      if (it == StoreInstWithIndex.begin()) {
        if (!StoreInstWithIndex.empty()) // no stores
          // LI->ReplaceAllUsersWith(UndefValue::get(LI->CopyType().get()));
          continue;
        else            // no store before load
          return false; /// @note why is this
      } else {
        LI->RAUW(
            std::prev(it)->second->Getuselist()[0]->GetValue());
        // LI->EraseFromBlock();
        LI->EraseFromParent();
      }
    }
  }
}

void AllocaInfo::AnalyzeAlloca(AllocaInst *AI) {
  init();
  //遍历这个allocaInst的user链
  // for (User *user : AI->GetUsers()) {
  for (Use *use : AI->GetUserlist()) {
    User* user=use->GetUser();
    BasicBlock *BB;
    if (StoreInst *SI = dynamic_cast<StoreInst *>(user)) {
      DefineBlocks.push_back(SI->GetParent());
      BB = SI->GetParent();
      OnlyStore = SI;
      AllocaPtrValue = SI->Getuselist()[0]->GetValue();
    } else { //由于IsAllocaPromotable，所以只会是storeinst或者loadinst
      LoadInst *LI = dynamic_cast<LoadInst *>(user);
      BB = LI->GetParent();
      UsingBlocks.push_back(BB);
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


  Value *val = OnlySt->Getuselist()[0]->GetValue();
  User *u = dynamic_cast<User *>(val);
  if (u == nullptr)
    GlobalVal = true; //判断store语句的第一个操作数是否是全局变量/常量
  BasicBlock *StoreBB = OnlySt->GetParent();

  Info.UsingBlocks.clear();
  //for (User *user : AI->GetUsers()) {
  for (Use *use : AI->GetUserlist()){
    User* user=use->GetUser();  
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
    LI->RAUW(val);
    LI->EraseFromParent();     //可以将这个LoadInstruction删除了
  }
  if (!Info.UsingBlocks.empty())
    return false;

  OnlySt->EraseFromParent();//结束后删除alloca和store
  AI->EraseFromParent();
  return true;
}

/// @brief preworking befor insert phi(compute live-in blocks) //TODO waiting ti repair
void PromoteMem2Reg::PreWorkingAfterInsertPhi(
    std::set<BasicBlock *> &DefineBlock, BlockInfo &BBInfo, AllocaInfo &Info,
    AllocaInst *AI, std::set<BasicBlock *> &LiveInBlocks) {
  std::vector<BasicBlock *> LiveIn(Info.UsingBlocks.begin(),
                                   Info.UsingBlocks.end());
  for (int i = 0, length = LiveIn.size(); i != length; i++) {
    BasicBlock *BB = LiveIn[i];
    if (DefineBlock.find(BB) == DefineBlock.end())
      continue; //当前use的block没有define，不能简化

    for (auto it = BB->begin();; ++it) {
      User *user = *it;
      if (StoreInst *ST = dynamic_cast<StoreInst *>(
              user)) { //相当于直接给这个变量赋了一个确定值,不再需要phi
        if (ST->GetDef() != AI)
          continue;

        LiveIn[i] = LiveIn.back();
        LiveIn.pop_back();
        --i, --length;
        break;
      }

      if (LoadInst *LI = dynamic_cast<LoadInst *>(user)) {
        if (LI->GetDef() == AI)
          break;
      }
    }
  }
  //  递归将这些基本块的前驱全部加进来，包括没有load当前alloca的基本块，因为alloca当然能直接流过这些不load它的基本块。
  //	当然，有store这个alloca变量的基本块就不能加进来了，不然上面的操作白做了。
  //	为什么要加入前驱？
  //	比如基本块B和基本C都用了变量a，且B和C的前驱基本块是A，即：
  //						  A
  //					  /   \
  //					 B     C
  //	那么正常来说，我们会在B和C都添加PHI节点，一共2个，但是，其实在A基本块中只需要添加一次即可。
  while (!LiveIn.empty()) {
    BasicBlock *bb = LiveIn.back();
    User* li=bb->front();

    //LoadInst* li=dynamic_cast<LoadInst*>(l);
    
    LiveIn.pop_back();
    if (!LiveInBlocks.insert(bb).second) //插入当前block
      continue;
    dominance::Node &node = m_dom.GetNode(bb->num);
    //遍历他的前驱,以简化phi函数的插入
    for (auto it : node.rev) {
      BasicBlock *rev = m_dom.GetNode(it).thisBlock;

      //遍历到目前的前驱块刚好是定义块，则不添加
      if (DefineBlock.find(rev) != DefineBlock.end())
        continue;

      LiveIn.push_back(rev);
    }
  }
}

bool IsAllocaPromotable(AllocaInst *AI) {
  //for (User *user : AI->GetUsers()) {
  for (Use *use : AI->GetUserlist()){
    User* user=use->GetUser();
    if (LoadInst *LI = dynamic_cast<LoadInst *>(user)) {
      assert(LI&&"LoadInst can not be nullptr");
      // do nothing
    } else if (StoreInst *SI = dynamic_cast<StoreInst *>(user)) {
      // if (SI->GetOperand(0) == AI) // can not let the first operand be
      // AllocaInst
      if (SI->Getuselist()[0]->GetValue() == AI)
        return false;
    } else {
      return false;
    }
  }
  return true;//到这步也可能是AI没有user，所以后续需要做一下判断
}

bool BlockInfo::IsAllocaRelated(User *Inst) {
  if (LoadInst *LI = dynamic_cast<LoadInst *>(Inst)) { // if read this alloca
    AllocaInst *AI = dynamic_cast<AllocaInst *>(LI->GetSrc());
    if (AI != nullptr)
      return true;
  } else if (StoreInst *ST =
                 dynamic_cast<StoreInst *>(Inst)) { // if store to this alloca
    // AllocaInst *AI = dynamic_cast<AllocaInst *>(ST->GetOperand(1));
    AllocaInst *AI =
        dynamic_cast<AllocaInst *>(ST->Getuselist()[1]->GetValue());
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
  BasicBlock *BB = Inst->GetParent();
}


/// @brief 提供当前块bb和指令inst，返回当前指令所在bb的index
int PromoteMem2Reg::CaculateIndex(BasicBlock *CurBlock, User *use) {
  int index = 0;
  std::vector<std::pair<User *, int>> InstNum;
  for (auto Instructs : *CurBlock) {
    User *user = Instructs;
    // TODO
  }
}