#include "CFG.hpp"
#include <unordered_set>
class DeadCodeEliminate{
public:
  DeadCodeEliminate() = default;
  void Pass(Module *module);

private:
  bool isInstructionTriviallyDead(User *inst);
  bool isSideEffectAndCall(User* inst);
  bool isLocalStore(StoreInst* store);
  bool isDeadInstruction(User* inst);
  bool isEqualStoreLoadPtr(StoreInst* store, LoadInst* load);
  bool isStrictEqualStoreLoadPtr(StoreInst* store, LoadInst* load);
  bool isEqualStorePtr(StoreInst* store_a, StoreInst* store_b);

  void detectNotSideEffectFunc(Module *m);
  void deleteDeadFunc(Module *m);
  void deleteDeadInst(Function* func);
  void deleteDeadStore(Function* func);
  void deleteDeadRet(Function* func);


private:
  int inst_counter = 0;
  int store_counter = 0;
  int func_counter = 0;

  std::unordered_set<Function *> notSideEffectFunc;
};
