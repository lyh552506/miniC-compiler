#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include <algorithm>

class cfgSimplify : public PassManagerBase {
 public:
  cfgSimplify(Function* func) : m_func(func) {}
  void RunOnFunction();
  void PrintPass();
 private:
  void simplify_Block();
  void DealBrInst();
  Function* m_func;
  dominance* m_dom;
};