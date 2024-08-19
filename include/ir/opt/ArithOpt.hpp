#pragma once
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "CFG.hpp"

class ArithOpt : public _PassManagerBase<ArithOpt, Function> {
  bool Run();
};