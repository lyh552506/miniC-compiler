

#include "CFG.hpp"
#include "New_passManager.hpp"
class DirtyWork : public _PassManagerBase<DirtyWork, Function> {
  bool Run();
};