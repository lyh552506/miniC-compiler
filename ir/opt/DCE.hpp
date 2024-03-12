#include "CFG.hpp"
#include <unordered_set>
class DeadCodeEliminate{
public:
  DeadCodeEliminate(Module& module, Function* func) : m(module), _func(func) {}
  void Pass();

private:
  Function* _func;
  Module& m;
  bool isInstructionTriviallyDead(User *inst);
  bool isSideEffect(User* inst);
  bool isLocalStore(StoreInst* store);
  bool isDeadInstruction(User* inst);
  bool isEqualStoreLoadPtr(StoreInst* store, LoadInst* load);
  bool isStrictEqualStoreLoadPtr(StoreInst* store, LoadInst* load);
  bool isEqualStorePtr(StoreInst* store_a, StoreInst* store_b);

  void markUse(User* inst, std::unordered_set<User*>& worklist);
  void detectNotSideEffectFunc(Function* func);
  void deleteDeadFunc(Function* func);
  void deleteDeadInst(Function* func);
  void deleteDeadStore(Function* func);
  void deleteDeadRet(Function* func);
  bool FunchasSideEffect(Function* func);
private:
  int inst_counter = 0;
  int store_counter = 0;
  int func_counter = 0;

  std::unordered_set<Function *> notSideEffectFunc;
};
