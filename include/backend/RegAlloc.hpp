#include <algorithm>
#include <list>
#include <map>
#include <stack>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include "CFG.hpp"
#include "MachineCode.hpp"
#include "Mcode.hpp"
#include "PassManagerBase.hpp"

class RegInfo {
  using Reg = unsigned int;//r0-
  Reg name;
};

class RegAlloc{
 public:
  RegAlloc(MachineFunction* func) : m_func(func) {}
 protected:
  std::vector<RegInfo> avail;
  MachineFunction* m_func;
  void run();
};