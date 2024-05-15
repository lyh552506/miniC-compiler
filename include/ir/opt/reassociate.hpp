#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include <vector>
class Reassociate : public PassManagerBase {
public:
  Reassociate(Function *func, dominance *dom) : m_func(func), m_dom(dom) {}
  void RunOnFunction();
  void PrintPass() {}

private:
  void BuildRankMap();
  void PostOrderCFG(BasicBlock *root);
  void OptimizeInst(Value *I);
  int GetRank(Value *val);
  bool IsBinaryFloatType(BinaryInst *I);
  void LinearizeExp(BinaryInst *I, std::vector<std::pair<Value *, int>> &Leaf);
  Value* ReassciateExp(BinaryInst *I);
  //判断是否是可交换的
  bool IsCommutative(BinaryInst::Operation opcode);
  bool IsOperandAssociate(Value *op, BinaryInst::Operation opcode);
  void FormalBinaryInst(User *I);
  bool ShouldIgnoreConst(BinaryInst::Operation Op,ConstantData* constdata);
  std::map<Value *, int>
      ValueRank; // RankMap, arguement's rank is 3,const rank is 0
  std::vector<BasicBlock *> RPO;
  std::vector<User *> RedoInst;
  Function *m_func;
  dominance *m_dom;
};