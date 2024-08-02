#include "../../include/ir/opt/LoopDeletion.hpp"
#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../include/ir/Analysis/dominant.hpp"
#include "../../include/ir/opt/ConstantFold.hpp"
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include <algorithm>
#include <cassert>
#include <optional>
#include <set>
#include <unordered_map>
bool LoopDeletion::Run()
{
    bool changed = false;
    dom = AM.get<dominance>(func);
    loop = AM.get<LoopAnalysis>(func, dom);
    AM.get<SideEffect>(&Singleton<Module>());
    for (auto loop_ : *loop)
        changed |= DetectDeadLoop(loop_);
    return changed;
}

bool LoopDeletion::DetectDeadLoop(LoopInfo *loopInfo)
{
    bool modified = false;
    BasicBlock *preheader = loop->GetPreHeader(loopInfo);
    if (!preheader)
        return false;

    std::vector<BasicBlock *> exitblocks = loop->GetExit(loopInfo);

    if (!loopInfo->GetSubLoop().empty())
        return false;

    if (exitblocks.size() != 1)
        return false;

    if (CanBeDelete(loopInfo))
        modified |= TryDeleteLoop(loopInfo);
    return modified;
}

bool LoopDeletion::CanBeDelete(LoopInfo *loopInfo)
{
    BasicBlock *ExitBlock = loop->GetExit(loopInfo)[0];

    Value *CommonValue;
    bool flag_common = true;
    bool flag_invariant = true;
    auto inst = ExitBlock->begin();
    while (auto Phi = dynamic_cast<PhiInst *>(*inst))
    {
        std::vector<BasicBlock *> exitingBlocks = loop->GetExitingBlock(loopInfo);
        Value *firstval = Phi->ReturnValIn(exitingBlocks[0]);

        flag_common = std::all_of(exitingBlocks.begin(), exitingBlocks.end(),
                                  [Phi, firstval](BasicBlock *block) { return Phi->ReturnValIn(block) == firstval; });

        if (!flag_common)
            break;

        if (auto Inst_Com = dynamic_cast<User *>(firstval))
        {
            if (!makeLoopInvariant(Inst_Com, loopInfo, loop->GetPreHeader(loopInfo)->back()))
            {
                flag_invariant = false;
                break;
            }
        }
        ++inst;
    }

    if (!flag_common || !flag_invariant)
        return false;

    for (User *inst : *loopInfo->GetHeader())
    {
        if (inst->HasSideEffect())
            return false;
    }

    for (BasicBlock *block : loopInfo->GetLoopBody())
    {
        for (User *inst : *block)
        {
            if (inst->HasSideEffect())
                return false;
        }
    }

    for (BasicBlock *block : loop->GetExitingBlock(loopInfo))
    {
        for (User *inst : *block)
        {
            if (inst->HasSideEffect())
                return false;
        }
    }

    for (User *inst : *loop->GetExit(loopInfo)[0])
    {
        if (inst->HasSideEffect())
            return false;
    }

    return true;
}

bool LoopDeletion::makeLoopInvariant(User *inst, LoopInfo *loopinfo, User *Termination)
{
    const std::set<BasicBlock *> contain{loopinfo->GetLoopBody().begin(), loopinfo->GetLoopBody().end()};
    bool flag = false;
    if (LoopAnalysis::IsLoopInvariant(contain, inst, loopinfo))
        flag = true;
    if (!IsSafeToMove(inst))
        flag = false;
    if (!flag)
        return false;
    if (!Termination)
    {
        BasicBlock *preheader = loop->GetPreHeader(loopinfo);
        if (!preheader)
            return false;
        Termination = preheader->back();
    }
    for (auto &use : inst->Getuselist())
    {
        if (!makeLoopInvariant_val(use->usee, loopinfo, Termination))
            return false;
    }
    {
        BasicBlock *block = Termination->GetParent();
        auto iter = block->begin();
        while (*iter != Termination)
            ++iter;
        // inst->ClearRelation();
        inst->EraseFromParent();
        iter.insert_before(inst);
    }

    return true;
}

bool LoopDeletion::makeLoopInvariant_val(Value *val, LoopInfo *loopinfo, User *Termination)
{
    if (auto inst = dynamic_cast<User *>(val))
        return makeLoopInvariant(inst, loopinfo, Termination);
    return true;
}

bool LoopDeletion::TryDeleteLoop(LoopInfo *loopInfo)
{
    _DEBUG(std::cerr << "Try to delete loop:" << loopInfo->GetHeader()->GetName() << "in func:" << func->GetName()
                     << "\n";)
    BasicBlock *Header = loopInfo->GetHeader();
    BasicBlock *Pre_Header = loop->GetPreHeader(loopInfo);
    BasicBlock *exitblock = loop->GetExit(loopInfo)[0];
    std::vector<BasicBlock *> exiting_blocks = loop->GetExitingBlock(loopInfo);
    User *Pre_Header_Exit = Pre_Header->back();
    for (auto &use : Pre_Header_Exit->Getuselist())
    {
        auto exit = dynamic_cast<BasicBlock *>(use->usee);
        if (exit && exit == Header)
        {
            Pre_Header_Exit->RSUW(use.get(), exitblock);
        }
    }

    // handle exit phi
    auto exit_iter = exitblock->begin();
    while (auto phi = dynamic_cast<PhiInst *>(*exit_iter))
    {
        phi->ModifyBlock(exiting_blocks[0], Pre_Header);
        for (int i = 1; i < exiting_blocks.size(); i++)
        {
            phi->EraseRecordByBlock(exiting_blocks[i]);
        }
    }

    Function *func_ = Pre_Header->GetParent();
    for (BasicBlock *block : loopInfo->GetLoopBody())
    {
        func_->GetBasicBlock().erase(std::remove(func_->GetBasicBlock().begin(), func_->GetBasicBlock().end(), block),
                                     func_->GetBasicBlock().end());
        // for(auto inst = block->rbegin(); inst != block->rend(); ++inst)
        // {

        //     (*inst)->ClearRelation();
        //     (*inst)->EraseFromParent();
        //     delete *inst;
        // }
        delete block;
    }
    loop->DeleteLoop(loopInfo);
    _DEBUG(std::cerr << "Has Changed In Function:" << func->GetName() << "\n";)
    return true;
}

bool LoopDeletion::IsSafeToMove(User *inst)
{
    auto instid = inst->GetInstId();
    if (instid == User::OpID::Phi)
        return false;
    if (instid == User::OpID::Div)
    {
        if (auto CONST = dynamic_cast<ConstantData *>(inst->GetOperand(1)))
        {
            if (CONST->getNullValue(CONST->GetType()))
                return false;
        }
    }
    if (instid == User::OpID::Mod)
    {
        if (auto CONST = dynamic_cast<ConstantData *>(inst->GetOperand(1)))
        {
            if (CONST->getNullValue(CONST->GetType()))
                return false;
            if (auto INT = dynamic_cast<ConstIRInt *>(CONST))
            {
                if (INT->GetVal() == -1)
                    return false;
            }
        }
    }
    if (instid == User::OpID::Load)
        return false;

    if (instid == User::OpID::Call)
    {
        if (inst->HasSideEffect())
            return false;
    }

    if (instid == User::OpID::Alloca || instid == User::OpID::Phi || instid == User::OpID::Store ||
        instid == User::OpID::Ret || instid == User::OpID::UnCond || instid == User::OpID::Cond)
        return false;
    return true;
}