#include "RISCVLowering.hpp"
#include "PhiElimination.hpp"
#include "BuildInFunctionTransform.hpp"
#include "PostRACalleeSavedLegalizer.hpp"

RISCVAsmPrinter* asmprinter=nullptr;
void RISCVModuleLowering::LowerGlobalArgument(Module* m){
    // need file name
    asmprinter = new RISCVAsmPrinter("file", m, ctx);
}

bool RISCVModuleLowering::run(Module* m){
    LowerGlobalArgument(m);
    RISCVFunctionLowering funclower(ctx);
    auto& funcS=m->GetFuncTion();
    for(auto &func:funcS){
        if(funclower.run(func.get())){
            func->print();
            std::cerr<<"FUNC Lowering failed\n";
        }
    }

    asmprinter->printAsm();
    // ctx.print();
    return false;
}

bool RISCVFunctionLowering::run(Function* m){
    /// @note this function is used to lower buildin function to the correct form
    /// @note and in order to solving user function which have the same name as buildin function
    BuildInFunctionTransform buildin;
    buildin.run(m);
    /// @note after isel, all insts will be User with an opcode. Only call, ret is not dealt with after this 
    /// @todo deal with alloca and imm
    /// @todo a scheduler can be added here, before or when emitting code to 3-address code
    /// @note This is destory SSA form to 3-address code with mixture of phy and vir regs
    auto mfunc=ctx.mapping(m)->as<RISCVFunction>();
    ctx(mfunc);

    RISCVISel isel(ctx);
    isel.run(m);

    PhiElimination phi(ctx);
    phi.run(m);

    asmprinter->SetTextSegment(new textSegment(ctx));
    asmprinter->GetData()->GenerateTempvarList(ctx);
    asmprinter->GetData()->LegalizeGloablVar(ctx);

    // Legalize legalize(ctx);
    // legalize;
    
    // Register Allocation
    RegAllocImpl regalloc(mfunc, ctx);
    regalloc.RunGCpass();

    // Generate Frame of current Function
    // And generate the head and tail of frame here
    PostRACalleeSavedLegalizer callee_saved_legalizer;
    callee_saved_legalizer.run(mfunc);
    
    auto& frame = mfunc->GetFrame();
    frame->GenerateFrame();
    frame->GenerateFrameHead();
    frame->GenerateFrameTail();

    Legalize legal(ctx);
    legal.run();

    return false;
}

