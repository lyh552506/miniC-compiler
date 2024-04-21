#include "CFG.hpp"

class Global2Local : public Variable
{
    Module& module;
public:
    Global2Local(Module& m, std::string name) : Variable(name), module(m) {}
    void Run();
    private:
    
};
