#include "CFG.hpp"
#include <unordered_set>
class DeadCodeEliminate{
public:
  DeadCodeEliminate() = default;
  void Pass();

private:
  bool isSideEffect(User* inst);
  bool isSideEffectAndCall(User* inst);
  bool isLocalStore(StoreInst* store);
  bool isDeadInstruction(User* inst);
  bool isEqualStoreLoadPtr(StoreInst* store, LoadInst* load);
  bool isStrictEqualStoreLoadPtr(StoreInst* store, LoadInst* load);
  bool isEqualStorePtr(StoreInst* store_a, StoreInst* store_b);


  void deleteDeadFunc(Module *m);
  void deleteDeadInst(BasicBlock* block, User* inst);
  void deleteDeadStore(BasicBlock* block, User* inst);
  void deleteDeadRet(BasicBlock*, User* inst);


private:
  int inst_counter = 0;
  int store_counter = 0;
  int func_counter = 0;

  std::unordered_set<Function *> notSideEffectFunc;
};
