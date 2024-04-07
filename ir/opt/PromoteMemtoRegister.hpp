#pragma once
#include "../../yacc/parser.hpp"
#include "IDF.hpp"
#include "dominant.hpp"

//记录alloca
class AllocaInfo {
 public:
  std::vector<BasicBlock *> DefineBlocks;
  std::vector<BasicBlock *> UsingBlocks;

  BasicBlock *OnlyBlock;  //只存在一个basicblock里
  StoreInst *OnlyStore;   //如果整个cfg只存在一个store语句
  bool IO_OnlySingleBlock;  // ALLOC出来的局部变量的读或者写都只存在一个基本块中
  Value *
      AllocaPtrValue;  //如果当前的alloca语句存在storeinst中，那么记录下赋值给alloca出的虚拟寄存器的值的指针

  void AnalyzeAlloca(AllocaInst *AI);
  /// @brief 对所有变量进行初始化

  AllocaInfo()
      : DefineBlocks{},
        UsingBlocks{},
        OnlyBlock(nullptr),
        IO_OnlySingleBlock(true),
        AllocaPtrValue(nullptr),
        OnlyStore(nullptr) {}
  void init() {
    DefineBlocks.clear();
    UsingBlocks.clear();
    OnlyBlock = nullptr;
    IO_OnlySingleBlock = true;
    AllocaPtrValue = nullptr;
    OnlyStore = nullptr;
  }
};

struct BlockInfo {
  std::map<User *, int> IndexInfo;
  /// @brief 获取index
  int GetInstIndex(User *Inst);
  /// @brief  判断是否是和alloca相关的读写操作
  bool IsAllocaRelated(User *Inst);

  /// @brief 对于已经删除的指令，同时去除他的index
  void DeleteIndex(User *Inst);

  BlockInfo() = default;
};

struct RenamePass {
  RenamePass(BasicBlock *CurrentBB, BasicBlock *Pred,
             std::vector<Value *> IncomingVal)
      : CurBlock(CurrentBB), Pred(Pred), IncomingVal(IncomingVal) {}

  RenamePass(RenamePass &&other)
      : IncomingVal(other.IncomingVal),
        Pred(other.Pred),
        CurBlock(other.CurBlock) {  //避免重新创建类
    other.Pred = nullptr;
    other.CurBlock = nullptr;
  }

  BasicBlock *CurBlock;
  BasicBlock *Pred;
  std::vector<Value *> IncomingVal;
};

class PromoteMem2Reg {
 public:
  PromoteMem2Reg(dominance &dom, std::vector<AllocaInst *> Allocas,
                 Function &func)
      : m_dom(dom),
        Func(func),
        m_Allocas(Allocas.begin(),
                  Allocas.end())  //不能直接赋值，这样会转移所有权
  {}

  void run();

  /// @brief 将对应的alloca语句的index的alloca消除
  void RemoveFromAllocaList(int &index);
  /// @brief  用STORE的右值直接替换使用LOAD指令的那些值
  bool Rewrite_IO_SingleBlock(AllocaInfo &Info, AllocaInst *AI,
                              BlockInfo &BBInfo);
  /// @brief 插入phi之前先进行一波预处理，避免一些无效插入
  void PreWorkingAfterInsertPhi(std::set<BasicBlock *> &DefineBlock,
                                BlockInfo &BBInfo, AllocaInfo &Info,
                                AllocaInst *AI,
                                std::set<BasicBlock *> &LiveInBlocks);
  /// @brief
  /// 当这个alloca只有一个store语句，被定义基本块所支配的所有LOAD都要被替换为STORE语句中的那个右值
  bool RewriteSingleStoreAlloca(AllocaInfo &Info, AllocaInst *AI,
                                BlockInfo &BBInfo);
  /// @brief 计算指令的index
  int CaculateIndex(BasicBlock *CurBlock, User *use);

  /// @brief 此处的插入phi函数只是先暂且插入一个空壳
  // eg：%1 = PHI i32
  bool InsertPhiNode(BasicBlock *bb, int AllocaNum);

  /// @brief 进一步的设置phi的incoming值，以及重命名
  void Rename(BasicBlock *BB, BasicBlock *Pred,
              std::vector<Value *> &IncomingVal,
              std::vector<RenamePass> &WorkLists);
  /// @brief 处理生成的phi：查看他的incoming，看是否只有一个，如果只有一个，那么就直接替换
  void SimplifyPhi(int& isEliminate,std::vector<PhiInst*>& Erase);

  dominance &m_dom;
  std::vector<AllocaInst *> m_Allocas;        // index->AllocaInst的映射
  std::map<AllocaInst *, int> AllocaToIndex;  // AllocaInst->index的映射
  Function &Func;
  std::map<std::pair<int, int>, PhiInst *>
      PrePhiNode;  //由[Block,AllocaNum]到PhiNode的映射
  std::map<PhiInst *, int> PhiToAlloca;  // Phi函数对应的Alloca指令
  std::set<BasicBlock *> RenameVisited;  //记录重命名时访问过的Block
};

/// @brief 检验送入的alloca指令能否被promote
bool IsAllocaPromotable(AllocaInst *AI);

void RunPromoteMem2Reg(dominance &dom, std::vector<AllocaInst *> Allocas,
                       Function &func);
