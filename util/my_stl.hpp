#pragma once
#include"CFG.hpp"
///@brief 自定义宏，更加方便，需要什么自己加


#define SDOM(x) node[x].sdom        //获取x对应结点的sdom
#define MIN_SDOM(x) dsu[x].min_sdom //获取结点最近的sdom的index
#define IDOM(x) node[x].idom        //获取结点的idom


/// @brief 遍历一个function,每个bb是一个智能指针BasicBlockPtr
#define For_bb_In(function)\
   assert(dynamic_cast<Function*>(function)&&"incoing must be a function* type");\
   auto& BB = function->GetBasicBlock();\
   for(auto& bb:BB)\


/// @brief 遍历一个BB,每个inst是一个User*，
#define For_inst_In(BB)\
   assert(dynamic_cast<BasicBlock*>(BB)&&"incoing must be a BasicBlock* type");\
   for(auto inst:*(BB))\

/// @brief 获取指令的操作数
template<typename T>
Value* GetOperand(T inst,int i){
   User* user=dynamic_cast<User*>(inst);
   assert(user);
   return user->Getuselist()[i]->GetValue();
}
