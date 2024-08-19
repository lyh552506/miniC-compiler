#pragma once
#include "../include/lib/CFG.hpp"
#include <cassert>
#include <vector>
///@brief 自定义宏，更加方便，需要什么自己加

#define SDOM(x) node[x].sdom        // 获取x对应结点的sdom
#define MIN_SDOM(x) dsu[x].min_sdom // 获取结点最近的sdom的index
#define IDOM(x) node[x].idom        // 获取结点的idom

#ifdef DEBUG
#define _DEBUG(x) x
#else
#define _DEBUG(x)
#endif

#ifdef __GNUC__
#define TO_STRING(x) #x
#define WARN_LOCATION(msg) _Pragma(TO_STRING(GCC warning msg))
#else
#define WARN_LOCATION(msg)
#endif

/// @brief 遍历一个function,每个bb是一个智能指针BasicBlockPtr
#define For_bb_In(function)                                                    \
  assert(dynamic_cast<Function *>(function) &&                                 \
         "incoing must be a function* type");                                  \
  auto &BB = function->GetBasicBlock();                                        \
  for (auto &bb : BB)

/// @brief 遍历一个BB,每个inst是一个User*，
#define For_inst_In(BB)                                                        \
  assert(dynamic_cast<BasicBlock *>(BB) &&                                     \
         "incoing must be a BasicBlock* type");                                \
  for (auto inst : *(BB))

/// @brief 获取指令的操作数
template <typename T> Value *GetOperand(T inst, int i) {
  User *user = dynamic_cast<User *>(inst);
  assert(user);
  return user->Getuselist()[i]->GetValue();
}

///@brief 获取后继结点个数
// #define GetSuccNum(BB)\
//    dynamic_cast<BasicBlock*>(BB)->back()->Getuselist().size();\

/// @brief 获取前驱节点的个数
#define GetPredNum(BB) BB->GetUserListSize()

///@brief 实现vector元素的pop
template <typename T> void vec_pop(std::vector<T> &vec, int &index) {
  assert(index < vec.size() && "index can not bigger than size");
  vec[index] = vec[vec.size() - 1];
  vec.pop_back();
  index--;
}
///@brief 实现vec没有重复元素
template <typename T> void PushVecSingleVal(std::vector<T> &vec, T v) {
  auto iter = std::find(vec.begin(), vec.end(), v);
  if (iter != vec.end())
    return;
  vec.push_back(v);
}

template <typename T> T PopBack(std::vector<T> &vec) {
  T tmp = vec.back();
  vec.pop_back();
  return tmp;
}

#define PassChangedBegin(curfunc)                                              \
  for (auto &func : module->GetFuncTion()) {                                   \
    curfunc = func.get();                                                      \
    curfunc->bb_num = 0;                                                       \
    curfunc->GetBasicBlock().clear();                                          \
    for (auto bb : *curfunc) {                                                 \
      bb->num = curfunc->bb_num++;                                             \
      curfunc->GetBasicBlock().push_back(bb);                                  \
    }                                                                          \
  }

#define FunctionChange(curfunc)                                                \
  curfunc->bb_num = 0;                                                         \
  curfunc->GetBasicBlock().clear();                                            \
  for (auto bb : *curfunc) {                                                   \
    bb->num = curfunc->bb_num++;                                               \
    curfunc->GetBasicBlock().push_back(bb);                                    \
  }

#define RunLevelPass(PassName, curfunc, modified)                              \
  for (int i = 0; i < module->GetFuncTion().size(); i++) {                     \
    curfunc = module->GetFuncTion()[i].get();                                  \
    if(curfunc->tag == Function::Tag::BuildIn)                                 \
      continue;                                                                \
    modified |= RunImpl<PassName>(curfunc, AM);                                \
  }

#define RunEntryFunc(PassName, modified)                                       \
  modified |= RunImpl<PassName>(module->GetMainFunction(), AM);

#define ContinueRunPassOnTest(PassName, curfunc)                               \
  bool modified = true;                                                        \
  while (modified) {                                                           \
    modified = false;                                                          \
    modified = RunImpl<PassName>(curfunc, AM);                                 \
  }
