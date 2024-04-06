// #include "CFG.hpp"
// #include "PassManagerBase.hpp"
// #include "dominant.hpp"
// #include <algorithm>
// #include <vector>

// class cfgSimplify : public PassManagerBase {
//  public:
//   cfgSimplify(Function* func,dominance* dom) : m_func(func),m_dom(dom) {}
//   void RunOnFunction();
//   void PrintPass();
//  private:
//   void simplify_Block();
//   void DealBrInst();
//   void DelSamePhis();
//   void DelUndefBlock();
//   //对于每个block，检查是否只有一个前驱并且前驱只有自己一个后继
//   void mergeSpecialBlock();
//   Function* m_func;
//   dominance* m_dom;
//   std::map<BasicBlock*,std::vector<PhiInst*>> BlockToPhis;
// };