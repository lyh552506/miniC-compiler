#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include <algorithm>

class cfgSimplify : public PassManagerBase {
 public:
  cfgSimplify(Function* func,dominance* dom) : m_func(func),m_dom(dom) {}
  void RunOnFunction();
  void PrintPass();
 private:
  void simplify_Block();
  void DealBrInst();
  void DelSamePhis();
  void DelUndefBlock();
  Function* m_func;
  dominance* m_dom;
};