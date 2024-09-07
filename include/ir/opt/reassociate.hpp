#pragma once
#include "../../../include/ir/Analysis/dominant.hpp"
#include "../../../include/ir/opt/New_passManager.hpp"
#include "../../../include/ir/opt/PassManagerBase.hpp"
#include "../../../include/lib/BaseCFG.hpp"
#include "../../../include/lib/CFG.hpp"
#include <vector>
class _AnalysisManager;
class Reassociate : public _PassManagerBase<Reassociate, Function> {
public:
  Reassociate(Function *func, _AnalysisManager &_AM) : m_func(func), AM(_AM) {}
  bool Run();
  void PrintPass() {}

private:
  void BuildRankMap();
  void PostOrderCFG(BasicBlock *root, dominance *m_dom);
  bool OptimizeInst(Value *I);
  int GetRank(Value *val);
  bool IsBinaryFloatType(BinaryInst *I);
  void LinearizeExp(BinaryInst *I, std::vector<std::pair<Value *, int>> &Leaf);
  bool ReassciateExp(BinaryInst *I);
  //判断是否是可交换的
  bool IsCommutative(BinaryInst::Operation opcode);
  bool IsOperandAssociate(Value *op, BinaryInst::Operation opcode);
  void FormalBinaryInst(User *I);
  bool ReWriteExp(BinaryInst *exp,
                  std::vector<std::pair<Value *, int>> &LinerizedOp);
  bool ShouldIgnoreConst(BinaryInst::Operation Op, ConstantData *constdata);
  //判断常数和对应的opcode是否是可吸收的，即判断是否是x*0这一类
  bool AbsorbConst(BinaryInst::Operation Op, ConstantData *constdata);
  bool KillDeadInst(User *I, int i);
  bool KillDeadInst(User *I, std::vector<User *> &kill);
  bool KillDeadInstTrival(User *I, std::vector<User *> &kill);
  void RecursionSplitOp(Value *I, std::vector<Value *> &ops);
  Value *CreatAddExp(User *Inst, std::vector<Value *> &AddOperands);
  Value *RemoveOp(Value *I);
  Value *OptExp(BinaryInst *exp,
                std::vector<std::pair<Value *, int>> &LinerizedOp);
  Value *OptAdd(BinaryInst *AddInst,
                std::vector<std::pair<Value *, int>> &LinerizedOp);
  Value *OptMul(BinaryInst *MulInst,
                std::vector<std::pair<Value *, int>> &LinerizedOp);
  std::map<Value *, int>
      ValueRank; // RankMap, arguement's rank is 3,const rank is 0
  std::vector<BasicBlock *> RPO;
  std::vector<User *> RedoInst;
  Function *m_func;
  _AnalysisManager &AM;
};