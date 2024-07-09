#pragma once
enum PassName {
  mem2reg,
  pre,
  constprop,
  dce,
  adce,
  loops,
  help,
  simplifycfg,
  ece,
  Inline,
  global2local,
  sccp,
  reassociate,
  cse,
  lcssa,
  licm,
  looprotate,
  loopdeletion
};
class PassManagerBase{
public:
    PassManagerBase()=default;
    virtual void RunOnFunction()=0;
    virtual void InitPass(){};
    virtual void PrintPass()=0;
};