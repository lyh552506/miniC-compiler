#include "../include/backend/RISCVLowering.hpp"
#include "../include/backend/BuildInFunctionTransform.hpp"
#include "../include/backend/PhiElimination.hpp"
#include "../include/backend/PostRACalleeSavedLegalizer.hpp"
#include "../include/backend/Scheduler.hpp"
#include "../include/backend/CodeLayout.hpp"
#include "../include/backend/DeleteDeadBlock.hpp"
#include "../include/backend/Scheduler.hpp"
extern std::string asmoutput_path;
RISCVAsmPrinter *asmprinter = nullptr;
void RISCVModuleLowering::LowerGlobalArgument(Module *m)
{
    // need file name
    asmprinter = new RISCVAsmPrinter(asmoutput_path, m, ctx);
}

bool RISCVModuleLowering::run(Module *m)
{
    LowerGlobalArgument(m);
    RISCVFunctionLowering funclower(ctx, asmprinter);
    auto &funcS = m->GetFuncTion();
    for (auto &func : funcS)
    {
        if (funclower.run(func.get()))
        {
            func->print();
            std::cerr << "FUNC Lowering failed\n";
        }
    }

    asmprinter->printAsm();
    return false;
}

bool RISCVFunctionLowering::run(Function *m)
{
    if(m->get_tag() == Function::BuildIn) {
        return false;
    }
    /// @note this function is used to lower buildin function to the correct form
    /// @note and in order to solving user function which have the same name as buildin function
    BuildInFunctionTransform buildin;
    buildin.run(m);
    /// @note after isel, all insts will be User with an opcode. Only call, ret is not dealt with after this
    /// @todo deal with alloca and imm
    /// @todo a scheduler can be added here, before or when emitting code to 3-address code
    /// @note This is destory SSA form to 3-address code with mixture of phy and vir regs
    auto mfunc = ctx.mapping(m)->as<RISCVFunction>();
    ctx(mfunc);

    RISCVISel isel(ctx, asmprinter);
    isel.run(m);

    PhiElimination phi(ctx);
    phi.run(m);

    asmprinter->SetTextSegment(new textSegment(ctx));
    asmprinter->GetData()->GenerateTempvarList(ctx);
    // // asmprinter->GetData()->LegalizeGloablVar(ctx);

    // Backend DCE before RA
    bool modified = true;
    while (modified)
    {
        modified = false;
        BackendDCE dcebefore(mfunc, ctx);
        modified |= dcebefore.RunImpl();
    }

    // Pre_RA_Scheduler pre_scheduler;
    // pre_scheduler.ScheduleOnFunction(ctx);

    // Register Allocation
    RegAllocImpl regalloc(mfunc, ctx);
    regalloc.RunGCpass();
    std::cout << std::flush;
    for (auto block : *(ctx.GetCurFunction()))
    {
        for (auto it = block->begin(); it != block->end();)
        {
            auto inst = *it;
            ++it;
            if (inst->GetOpcode() == RISCVMIR::RISCVISA::MarkDead)
                delete inst;
        }
    }
    modified = true;
    // Backend DCE after RA
    while (modified)
    {
        modified = false;
        BackendDCE dceafter(ctx.GetCurFunction(), ctx);
        modified |= dceafter.RunImpl();
    }
    
    // Pre_RA_Scheduler pre_scheduler;
    // pre_sclheduer.ScheduleOnFunction(ctx);
    
    // Post_RA_Scheduler post_scheduler;
    // post_scheduler.ScheduleOnFunction(ctx);

    // Generate Frame of current Function
    // And generate the head and tail of frame here
    PostRACalleeSavedLegalizer callee_saved_legalizer;
    callee_saved_legalizer.run(ctx.GetCurFunction());

    auto& frame = ctx.GetCurFunction()->GetFrame();
    frame->GenerateFrame();
    frame->GenerateFrameHead();
    frame->GenerateFrameTail();

    // legal.run_afterRA();
    Legalize legal(ctx);
    legal.run();

    auto dbd=DeleteDeadBlock();
    dbd.run(ctx.GetCurFunction());

    auto layout=CodeLayout();
    layout.run(mfunc);

    return false;
}
