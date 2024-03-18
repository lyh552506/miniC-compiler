#include "CFG.hpp"
#include <unordered_set>
class DeadCodeEliminate{
public:
  DeadCodeEliminate(std::vector<Function*> FList, Module& module) : Flist(FList), m(module) {}
  void Pass();

private:
  Module& m;
  std::vector<Function*> Flist;
  bool isInstructionTriviallyDead(User *inst);
  bool isSideEffect(User* inst);
  bool isLocalStore(StoreInst* store);
  bool isDeadInstruction(User* inst);
  bool isEqualStoreLoadPtr(StoreInst* store, LoadInst* load);
  bool isStrictEqualStoreLoadPtr(StoreInst* store, LoadInst* load);
  bool isEqualStorePtr(StoreInst* store_a, StoreInst* store_b);
  Value* GetAddress(Value* val);

  void markUse(User* inst, std::unordered_set<User*>& worklist);
  void detectNotSideEffectFunc(Function* func);
  void deleteDeadFunc(Function* func);
  void deleteDeadInst(Function* func);
  void deleteDeadStore(Function* func);
  void deleteDeadRet(Function* func);
  bool FunchasSideEffect(Function* func);
  std::string CalPtrIndex(GetElementPtrInst* inst);
private:
  int inst_counter = 0;
  int store_counter = 0;
  int func_counter = 0;

//   std::unordered_set<Function *> notSideEffectFunc;
// };
