#pragma once
#include "../../lib/CFG.hpp"

template <typename Pass, typename DerivedT> class _AnalysisManagerBase {
private:
  void InitPass(Pass pass);

public:
  _AnalysisManagerBase() = default;
  virtual const Pass *GetResult(DerivedT *func) const { return nullptr; }
  const Pass *derived_this() const { return static_cast<const Pass *>(this); }
};

template <typename Pass, typename Scope> class _PassManagerBase {
private:
  void InitPass(Pass pass);

public:
  virtual bool Run() = 0;
  _PassManagerBase() = default;
  const Pass *derived_this() const { return static_cast<const Pass *>(this); }
};

