#pragma once
#include"CFG.hpp"
// enum PassName {
//   mem2reg,
//   pre,
//   constprop,
//   dce,
//   adce,
//   loops,
//   help,
//   simplifycfg,
//   ece,
//   Inline,
//   global2local,
//   sccp,
//   reassociate,
//   cse,
//   lcssa,
//   licm,
//   looprotate
// };

template <typename Pass,typename DerivedT> class _AnalysisManagerBase {
private:
  void InitPass(Pass pass);

public:
  _AnalysisManagerBase()=default;
  virtual const Pass *GetResult(DerivedT *func) const{}
  const DerivedT *derived_this() const {
    return static_cast<const DerivedT *>(this);
  }
  // const Pass *get(DerivedT Base){
  //    return static_cast<Pass *>(GetResult(Base));
  // }

  template <typename... Args> void AddAnalysis(Args &&...args);
};



class PassManagerBase{
public:
    PassManagerBase()=default;
    virtual void RunOnFunction()=0;
    virtual void InitPass(){};
    virtual void PrintPass()=0;
};