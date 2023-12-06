#pragma once
#include"dominant.hpp"

class PromoteMem2Reg {
public:
  PromoteMem2Reg(dominance &dom,std::vector<AllocaInst *> Allocas) : m_dom(dom),DeadAlloca(0),SingleStore(0),m_Allocas(Allocas.begin(),Allocas.end()) //不能直接赋值，这样会转移所有权
  {}
  
  void run();
  
  /// @brief 将对应的alloca语句的index的alloca消除
  void RemoveFromAllocaList(int& index);
  /// @brief  用STORE的右值直接替换使用LOAD指令的那些值
  bool Rewrite_IO_SingleBlock();//TODO 
  /// @brief 插入phi之前先进行一波预处理，避免一些无效插入
  void PreWorkingAfterInsertPhi(std::vector<BasicBlock*> DefineBlock);//TODO

  dominance &m_dom;
  std::vector<AllocaInst *> m_Allocas;
  int DeadAlloca;//Number of dead alloca's removed
  int SingleStore;//Number of alloca's promoted with a single store
};

/// @brief 检验送入的alloca指令能否被promote
bool IsAllocaPromotable();

//记录alloca
class AllocaInfo {
public:
   std::vector<BasicBlock*> DefineBlocks;
   std::vector<BasicBlock*> UsingBlocks;

   BasicBlock* OnlyDefine;//只存在一个store语句在一个basicblock里
   bool IO_OnlySigleBlock;//ALLOC出来的局部变量的读或者写都只存在一个基本块中
   
   void AnalyzeAlloca(AllocaInst* Inst);

};

void RunPromoteMem2Reg(dominance &dom,std::vector<AllocaInst *> Allocas);
/// @brief  被定义基本块所支配的所有LOAD都要被替换为STORE语句中的那个右值
bool RewriteSingleStoreAlloca();//TODO 