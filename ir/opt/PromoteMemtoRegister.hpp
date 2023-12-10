#pragma once
#include"dominant.hpp"


//记录alloca
class AllocaInfo {
public:
   std::vector<BasicBlock*> DefineBlocks;
   std::vector<BasicBlock*> UsingBlocks;//记录undef！

   BasicBlock* OnlyBlock;//只存在一个basicblock里
   StoreInst* OnlyStore;  //如果整个cfg只存在一个store语句
   bool IO_OnlySingleBlock;//ALLOC出来的局部变量的读或者写都只存在一个基本块中
   Value* AllocaPtrValue;//如果当前的alloca语句存在storeinst中，那么记录下赋值给alloca出的虚拟寄存器的值的指针
   
   void AnalyzeAlloca(AllocaInst* AI);
   /// @brief 对所有变量进行初始化
   void init(){
    DefineBlocks.clear();
    UsingBlocks.clear();
    OnlyBlock=nullptr;
    IO_OnlySingleBlock=true;
    AllocaPtrValue=nullptr;
    OnlyStore=nullptr;
   }

};

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
  /// @brief 当这个alloca只有一个store语句，被定义基本块所支配的所有LOAD都要被替换为STORE语句中的那个右值
  bool RewriteSingleStoreAlloca(AllocaInfo& Info,AllocaInst* AI);

  dominance &m_dom;
  std::vector<AllocaInst *> m_Allocas;
  int DeadAlloca;//Number of dead alloca's removed
  int SingleStore;//Number of alloca's promoted with a single store
};

/// @brief 检验送入的alloca指令能否被promote
bool IsAllocaPromotable(AllocaInst* AI);

/// @brief 提供当前块bb和指令inst，返回当前指令所在bb的index
template<typename T>
int CaculateIndex(BasicBlock* CurBlock,T Inst){
  int index=0;
  for(auto& Instructs:CurBlock->GetInsts()){
    User* user=Instructs.get();
    //TODO
  }
}

void RunPromoteMem2Reg(dominance &dom,std::vector<AllocaInst *> Allocas);
