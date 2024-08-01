#include "../../include/ir/opt/PromoteMemtoRegister.hpp"
#include "../../include/ir/opt/IDF.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include <algorithm>

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
    auto AI = m_Allocas[i];
    // do some basic opt
    if (!AI->IsUsed()) // if not used,then delete
    {
      delete AI;
      RemoveFromAllocaList(i);
      continue;
    }
    //看下哪些基本块在使用这个ALLOC，哪些基本块定义了这个ALLOC
    Info.AnalyzeAlloca(AI);

    if (Info.DefineBlocks.size() == 1) { //只有一个定义基本块
      if (RewriteSingleStoreAlloca(Info, AI, BBInfo)) {
        RemoveFromAllocaList(i);
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
    auto &vec = Func.GetBasicBlock();
    idf.SetBBs(vec);
    idf.caculateIDF(PhiBlocks);
    for (int dex = 0; dex < PhiBlocks.size(); dex++)
      InsertPhiNode(PhiBlocks[dex], i);
  }

  //下面开始为重命名做准备
  std::vector<Value *> AllocaDict(m_Allocas.size());
  for (int x = 0; x < m_Allocas.size(); x++)
    AllocaDict[x] = UndefValue::get(
        dynamic_cast<HasSubType *>(m_Allocas[x]->GetType())->GetSubType());

  std::vector<RenamePass> WorkLists; //采用工作表法，传入EntryBlock
  WorkLists.emplace_back(*(Func.begin()), nullptr, AllocaDict);
  do {
    auto tmp = std::move(WorkLists.back());
    WorkLists.pop_back();
    Rename(tmp.CurBlock, tmp.Pred, tmp.IncomingVal, WorkLists);
  } while (!WorkLists.empty());

  //替换phi之后前面的alloca可能已经没有user了，需要删除
  for (int i = 0; i < m_Allocas.size(); i++) {
    auto clean = m_Allocas[i];
    if (!clean->IsUsed()) {
      delete clean;
    }
  }
  int isEliminate = 1;
  while (isEliminate) {
    std::vector<PhiInst *> Erase;
    isEliminate = 0;
    SimplifyPhi(isEliminate, Erase);
    for (auto phi : Erase) {
      auto iter =
          std::find_if(PrePhiNode.begin(), PrePhiNode.end(),
                       [phi](auto &pair) { return pair.second == phi; });
      if (iter != PrePhiNode.end())
        PrePhiNode.erase(iter);
    }
  }
  PrePhiNode.clear();
}

void PromoteMem2Reg::SimplifyPhi(int &isEliminate,
                                 std::vector<PhiInst *> &Erase) {
  //遍历所有的phiinst
  for (auto &[_1, phis] : PrePhiNode) {
    bool HasUndef = false;
    Value *origin = nullptr;
    auto &incomes = phis->GetAllPhiVal();
    for (auto &income : incomes) {
      if (dynamic_cast<UndefValue *>(income)) {
        HasUndef = true;
        continue;
      }
      if (income == phis)
        continue;
      if (origin != nullptr && income != origin)
        break;
      origin = income;
    }

    if (origin == nullptr) {
      auto undef = UndefValue::get(phis->GetType());
      Erase.push_back(phis);
      phis->ClearRelation();
      phis->RAUW(undef);
      isEliminate = 1;
      continue;
    }
    //处理类似 phi i32[tmp , undef ,tmp ……]的情况
    //在这里需要判断此处的tmp是否支配phi才能实现替换
    if (HasUndef) {
      if (auto inst = dynamic_cast<User *>(origin))
        if (!m_dom.dominates(inst->GetParent(), phis->GetParent()))
          continue;
      Erase.push_back(phis);
      phis->RAUW(origin);
      delete phis;
      isEliminate = 1;
      continue;
    }
  }
}

void PromoteMem2Reg::Rename(BasicBlock *BB, BasicBlock *Pred,
                            std::vector<Value *> &IncomingVal,
                            std::vector<RenamePass> &WorkLists) {
  while (1) {
    //当前块存在Phi指令
    if (PhiInst *Phi = dynamic_cast<PhiInst *>(*(BB->begin()))) {
      if (PhiToAlloca.count(Phi)) {
        for (auto Inst = BB->begin(); Inst != BB->end();) {
          if (ThisPassInsert.find(Phi) != ThisPassInsert.end()) {
            int Allocanum = PhiToAlloca[Phi];
            Phi->updateIncoming(IncomingVal[Allocanum], Pred);
            IncomingVal[Allocanum] = Phi;
            ++Inst;
            Phi = dynamic_cast<PhiInst *>(*Inst);
            if (!Phi)
              break;
          } else {
            break;
          }
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
    for (auto inst = BB->begin(); inst != BB->end();) {
      User *user = *inst;
      ++inst;
      if (LoadInst *LI = dynamic_cast<LoadInst *>(user)) {
        Value *Src = GetOperand(LI, 0);
        AllocaInst *AI = dynamic_cast<AllocaInst *>(Src); // src---->%a
        if (!AI)
          continue;
        auto it = AllocaToIndex.find(AI);
        if (it == AllocaToIndex.end())
          continue;

        Value *RepL = IncomingVal[it->second]; //使用Alloca的value来替换
        LI->RAUW(RepL);
        delete LI;
      } else if (StoreInst *ST = dynamic_cast<StoreInst *>(user)) {
        auto &des = ST->Getuselist();
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
        delete ST;
      }
    }

    //将BB的后继添加到worklist继续循环处理
    auto cur = m_dom.GetNode(BB->num);
    if (cur.des.empty())
      return;
    //避免重复的visit前驱
    std::set<BasicBlock *> visited;

    auto It = cur.des.begin();
    Pred = BB;
    BB = m_dom.GetNode(*It++).thisBlock;
    visited.insert(BB);

    while (It != cur.des.end()) {
      BasicBlock *tmp = m_dom.GetNode(*It++).thisBlock;
      if (visited.insert(tmp).second) // tmp还未被插入
        WorkLists.emplace_back(tmp, Pred, IncomingVal);
    }
  }
}

bool PromoteMem2Reg::InsertPhiNode(BasicBlock *bb, int AllocaNum) {
  auto &vect = Func.GetBasicBlock();
  auto it = std::find_if(vect.begin(), vect.end(), [bb](BasicBlock *base) {
    return base == bb;
  }); // get index

  int index = std::distance(vect.begin(), it); //获取下标
  PhiInst *&Phi = PrePhiNode[std::make_pair(index, AllocaNum)];
  if (Phi)
    return false;
  AllocaInst *target = m_Allocas[AllocaNum];
  Phi = PhiInst::NewPhiNode(
      bb->front(), bb,
      dynamic_cast<HasSubType *>(target->GetType())->GetSubType());
  PhiToAlloca[Phi] = AllocaNum;
  ThisPassInsert.insert(Phi);
  return true;
}

bool PromoteMem2Reg::Rewrite_IO_SingleBlock(AllocaInfo &Info, AllocaInst *AI,
                                            BlockInfo &BBInfo) {
  std::vector<std::pair<int, StoreInst *>> StoreInstWithIndex;

  //遍历alloca的所有user
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

  for (Use *use : AI->GetUserlist()) {
    User *user = use->GetUser();
    if (LoadInst *LI = dynamic_cast<LoadInst *>(user)) {
      int loadindex = BBInfo.GetInstIndex(LI);
      auto it = std::lower_bound(
          StoreInstWithIndex.begin(), StoreInstWithIndex.end(),
          std::make_pair(loadindex, static_cast<StoreInst *>(nullptr)),
          [](const std::pair<int, StoreInst *> &T1,
             const std::pair<int, StoreInst *> &T2) -> bool {
            return T1.first < T2.first;
          }); // find the first value which index is bigger(or equal) than the
              // inst in container
      if (it == StoreInstWithIndex.begin()) {
        if (StoreInstWithIndex.empty()) // no stores
          LI->RAUW(UndefValue::get(LI->GetType()));
        else // no store before load
          return false;
      } else
        LI->RAUW(std::prev(it)->second->Getuselist()[0]->GetValue());
      delete LI;
      BBInfo.DeleteIndex(LI);
    }
  }

  for (Use *use : AI->GetUserlist()) {
    assert(dynamic_cast<StoreInst *>(use->fat) && "must be a StoreInst");
    StoreInst *st = dynamic_cast<StoreInst *>(use->fat);
    delete st;
    BBInfo.DeleteIndex(st);
  }
  delete AI;
  BBInfo.DeleteIndex(AI);

  return true;
}

void AllocaInfo::AnalyzeAlloca(AllocaInst *AI) {
  init();
  //遍历这个allocaInst的user链
  for (Use *use : AI->GetUserlist()) {
    User *user = use->GetUser();
    BasicBlock *BB;
    if (StoreInst *SI = dynamic_cast<StoreInst *>(user)) {
      DefineBlocks.push_back(SI->GetParent());
      BB = SI->GetParent();
      OnlyStore = SI;
    } else { //由于IsAllocaPromotable，所以只会是storeinst或者loadinst
      LoadInst *LI = dynamic_cast<LoadInst *>(user);
      BB = LI->GetParent();
      UsingBlocks.push_back(BB);
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
  bool GlobalVal = false;

  Value *val = OnlySt->Getuselist()[0]->GetValue();
  User *u = dynamic_cast<User *>(val);
  if (u == nullptr)
    GlobalVal = true; //判断store语句的第一个操作数是否是全局变量/常量
  BasicBlock *StoreBB = OnlySt->GetParent();

  Info.UsingBlocks.clear();

  for (Use *use : AI->GetUserlist()) {
    User *user = use->GetUser();
    LoadInst *LI = dynamic_cast<LoadInst *>(user);
    if (!LI)
      continue;

    if (!GlobalVal) { // load语句和当前的store在同一个块,如果不是全局变量，需要寻找store和load的次序关系
      if (LI->GetParent() == StoreBB) {
        if (StoreIndex == -1)
          StoreIndex = BBInfo.GetInstIndex(OnlySt);
        int LoadIndex = BBInfo.GetInstIndex(LI);
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
    delete LI; //可以将这个LoadInstruction删除了
    BBInfo.DeleteIndex(LI);
  }
  if (!Info.UsingBlocks.empty())
    return false;
  delete OnlySt; //结束后删除alloca和store
  BBInfo.DeleteIndex(OnlySt);
  delete AI;
  BBInfo.DeleteIndex(AI);
  return true;
}

/// @brief preworking befor insert phi(compute live-in blocks)
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
        if (ST->Getuselist()[1]->GetValue() != AI)
          continue;

        LiveIn[i] = LiveIn.back();
        LiveIn.pop_back();
        --i, --length;
        break;
      }

      if (LoadInst *LI = dynamic_cast<LoadInst *>(user)) {
        if (LI->Getuselist()[0]->GetValue() == AI)
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
  // for (User *user : AI->GetUsers()) {
  for (Use *use : AI->GetUserlist()) {
    User *user = use->GetUser();
    if (LoadInst *LI = dynamic_cast<LoadInst *>(user)) {
      assert(LI && "LoadInst can not be nullptr");
      // do nothing
    } else if (StoreInst *SI = dynamic_cast<StoreInst *>(user)) {
      if (SI->Getuselist()[0]->GetValue() == AI)
        return false;
    } else if (GetElementPtrInst *gep =
                   dynamic_cast<GetElementPtrInst *>(user)) {
      // TODO
      return false;
    } else {
      return false;
    }
  }
  return true; //到这步也可能是AI没有user，所以后续需要做一下判断
}

bool BlockInfo::IsAllocaRelated(User *Inst) {
  if (LoadInst *LI = dynamic_cast<LoadInst *>(Inst)) { // if read this alloca
    AllocaInst *AI = dynamic_cast<AllocaInst *>(GetOperand(LI, 0));
    if (AI != nullptr)
      return true;
  } else if (StoreInst *ST =
                 dynamic_cast<StoreInst *>(Inst)) { // if store to this alloca
    AllocaInst *AI =
        dynamic_cast<AllocaInst *>(ST->Getuselist()[1]->GetValue());
    if (AI != nullptr)
      return true;
  }
  return false;
}

/// @brief 提供当前块bb和指令inst，返回当前指令所在bb的index
int BlockInfo::GetInstIndex(User *Inst) {
  auto It = IndexInfo.find(Inst);
  if (It != IndexInfo.end())
    return It->second;

  //目前user查找到当前的bb
  int num = 0;
  BasicBlock *BB = Inst->GetParent();
  for (auto inst = BB->begin(); inst != BB->end(); ++inst) {
    if (dynamic_cast<LoadInst *>(*inst) &&
            dynamic_cast<AllocaInst *>((*inst)->Getuselist()[0]->usee) ||
        dynamic_cast<StoreInst *>(*inst) &&
            dynamic_cast<AllocaInst *>((*inst)->Getuselist()[1]->usee)) {
      IndexInfo[*inst] = num++;
    }
  }
  return IndexInfo[Inst];
}

void BlockInfo::DeleteIndex(User *Inst) { IndexInfo.erase(Inst); }