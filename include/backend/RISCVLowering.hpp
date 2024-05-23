#pragma once
#include "BackendPass.hpp"
#include "RISCVContext.hpp"
#include "RISCVISel.hpp"
#include "RISCVAsmPrinter.hpp"
#include "RISCVISel.hpp"
#include "RISCVRegister.hpp"
#include "RegAlloc.hpp"
#include "BaseCFG.hpp"
#include "PhiElimination.hpp"
#include "LegalizePass.hpp"
class RISCVModuleLowering:BackEndPass<Module>{
    // bool LoweringGlobalValue(Module*);
    RISCVLoweringContext ctx;
    void LowerGlobalArgument(Module*); 
    public:
    bool run(Module*);
};

class RISCVFunctionLowering:BackEndPass<Function>{
    RISCVLoweringContext& ctx;
    public:
    bool run(Function*);
    RISCVFunctionLowering(RISCVLoweringContext& ctx):ctx(ctx){};

};
