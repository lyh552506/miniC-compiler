#include "RISCVLowering.hpp"
#include "PhiElimination.hpp"

RISCVAsmPrinter* asmprinter=nullptr;
void RISCVModuleLowering::LowerGlobalArgument(Module* m){
    // need file name
    asmprinter = new RISCVAsmPrinter("file", m, ctx);
    // asmprinter->printAsmGlobal();
    // assert(0&&"Handled later");
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
    // LegalizeConstInt lcint(ctx);
    // lcint.run();

    asmprinter->printAsm();
    // ctx.print();
    return false;
}

bool RISCVFunctionLowering::run(Function* m){
    /// @note after isel, all insts will be User with an opcode. Only call, ret is not dealt with after this 
    /// @todo deal with alloca and imm
    /// @todo a scheduler can be added here, before or when emitting code to 3-address code
    /// @note This is destory SSA form to 3-address code with mixture of phy and vir regs
    ctx(ctx.mapping(m)->as<RISCVFunction>());

    RISCVISel isel(ctx);
    isel.run(m);

    PhiElimination phi(ctx);
    phi.run(m);

    asmprinter->SetTextSegment(new textSegment(ctx));
    asmprinter->GetData()->GenerateTempvarList(ctx);

    LegalizeConstInt lcint(ctx);
    lcint.run();

    // Register Allocation
    RegAllocImpl regalloc(ctx.mapping(m)->as<RISCVFunction>(), ctx);
    regalloc.RunGCpass();

    // RISCVFrame& frame = *(ctx.GetCurFunction())->GetFrame();
    // frame.GenerateFrame();
    // frame.GenerateFrameHead();
    // frame.GenerateFrameTail();
    
    return false;
}

