#include <list>
#include <map>
#include <stack>
#include <string>
#include <unordered_set>
#include <vector>
#include<unordered_map>
#include<algorithm>
#include "MachineCode.hpp"
#include "PassManagerBase.hpp"
#include "CFG.hpp"

class RegAlloc:public PassManagerBase{
    public:
        RegAlloc(Function* func):m_func(func){}
        void Run();
        void PrintPass();
    private:
    Function* m_func;
};