#include "../../include/ir/opt/IndVarSimplify.hpp"
#include "../../include/ir/Analysis/LoopInfo.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../include/ir/Analysis/dominant.hpp"
#include "../../include/ir/opt/ConstantFold.hpp"
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/lib/Singleton.hpp"
#include "my_stl.hpp"
#include <cassert>
#include <cmath>
#include <cstdlib>
#include <iterator>
#include <unordered_set>
#include <vector>

// namespace MatchTool
// {
//     struct Match
//     {
//         // 0 : no phi  1 : LHS phi  2 : RHS phi
//         std::pair<User::OpID, int> operator()(Value& val1, Value& val2, User* inst)
//         {
//             if(dynamic_cast<BinaryInst*>(inst))
//             {
//                 val1 = *inst->GetOperand(0);
//                 val2 = *inst->GetOperand(1);
//                 User::OpID id = inst->GetInstId();
//                 if(dynamic_cast<PhiInst*>(&val1))
//                     return {id, 1};
//                 else if(dynamic_cast<PhiInst*>(&val2))
//                     return {id, 2};
//                 else if(dynamic_cast<PhiInst*>(&val1) && dynamic_cast<PhiInst*>(&val2))
//                     return {id, 3};
//                 else
//                     return {id, 0};
//             }
//         }
//     };
// }

void IndVarSimplify::init()
{
    DomTree = AM.get<dominance>(func);
    Loop = AM.get<LoopAnalysis>(func, DomTree, std::ref(DeleteLoop));
    AM.get<SideEffect>(&Singleton<Module>());
    Loops = Loop->GetLoops();
}

// bool IndVarSimplify::Run()
// {
//     bool modified = false;
//     for (auto loop : Loops)
//         modified |= RunOnLoop(loop);
//     return modified;
// }

// bool IndVarSimplify::RunOnLoop(LoopInfo *loop)
// {
//     LoopSimplify::CaculateLoopInfo(loop, Loop);
//     if (loop->CantCalcTrait())
//         return false;
//     auto Exits = Loop->GetExit(loop);
//     if (Exits.size() != 1)
//         return false;
//     Value* IndVar = loop->trait.indvar;
//     if(!IndVar)
//         return false;
    
//     BasicBlock* header = loop->GetHeader();



//     // Value *Times = CaculateTimes(loop);
//     // if (!Times)
//     //     return false;

//     bool modified = false;
//     // std::vector<BasicBlock *> Bodys = loop->GetLoopBody();
//     // std::set<PhiInst *> Phis{};

//     // for (BasicBlock *block : Bodys)
//     // {
//     //     auto iter = block->begin();
//     //     while (auto phi = dynamic_cast<PhiInst *>(*iter))
//     //     {
//     //         if (phi->Getuselist().size() < 3)
//     //             Phis.insert(phi);
//     //         ++iter;
//     //     }
//     // }
//     // Phis.erase(loop->trait.indvar);

//     // for (auto phi : Phis)
//     //     modified |= HandlePhi(phi, loop, Times);

//     return modified;
// }


// bool IndVarSimplify::HandlePhi(PhiInst *inst, LoopInfo *loop, Value *Times)
// {
//     BasicBlock* ExitBlock = Loop->GetExit(loop).front();
//     BasicBlock* Preheader = Loop->GetPreHeader(loop);
//     Value* IndVar = nullptr;
//     Value* IncomeValue = nullptr;    
//     bool Flag = false;
//     for (auto &[key, val] : inst->PhiRecord)
//     {
//         if (val.second == Preheader)
//         {
//             Flag = true;
//             IncomeValue = val.first;
//         }
//         else
//             IndVar = val.first;
//     }
//     if(!Flag)
//         return false;
//     auto iter = ExitBlock->begin();
//     PhiInst* Exit_Phi = nullptr;
//     Value* IndVar_base = nullptr;
//     Value* IndVar_op = nullptr;
//     for(auto user : IndVar->GetUserlist())
//     {
//         User* user_inst = user->GetUser();
//         if(user_inst->GetParent() == ExitBlock && dynamic_cast<PhiInst*>(user_inst))
//         {
//             Exit_Phi = dynamic_cast<PhiInst*>(user_inst);
//         }
//         else if(user_inst == inst)
//             continue;
//         else
//         {
//             auto Result = MatchTool::Match{}(*IndVar_base, *IndVar_op, user_inst);
//             if(Result.second == 0)
//             {

//             }
//             else if(Result.second == 1)
//             {
                
//             }
//             else if(Result.second == 2)
//             {

//             }
//             else if(Result.second == 3)
//             {

//             }
//         }
//     }

    
//     BasicBlock* new_block = new BasicBlock;

// }

bool IndVarSimplify::Run()
{
    bool modified = false;
    for (LoopInfo *loop : Loops)
        modified |= RunOnLoop(loop);
}

bool IndVarSimplify::RunOnLoop(LoopInfo *loop)
{
    if (loop->GetHeader() != Loop->GetLatch(loop))
        return false;
    if (Loop->GetExit(loop).size() != 1)
        return false;
    if (loop->GetHeader()->GetUserlist().GetSize() != 2)
        return false;
    LoopSimplify::CaculateLoopInfo(loop, Loop);
    if (loop->CantCalcTrait())
        return false;
    BasicBlock *header = loop->GetHeader();
    BasicBlock *Preheader = Loop->GetPreHeader(loop);
    for (User *inst : *header)
    {
        if (auto phi_ = dynamic_cast<PhiInst *>(inst))
        {
            Value *Begin = phi_->ReturnValIn(Preheader);
            Value *Add_RHS;
            Value *Rem_RHS;
            User *Rem = nullptr;
            User *Add = nullptr;
            bool flag = false;
            for (auto user : inst->GetUserlist())
            {
                User *User_Add = user->GetUser();
                if (User_Add->GetInstId() == User::OpID::Add)
                {
                    Value *LHS = User_Add->GetOperand(0);
                    Value *RHS = User_Add->GetOperand(1);
                    LHS == inst ? Add_RHS = RHS : Add_RHS = LHS;
                    Add = User_Add;
                    for (auto user_user : User_Add->GetUserlist())
                    {
                        User *User_Rem = user_user->GetUser();
                        if (User_Rem->GetInstId() == User::OpID::Mod)
                        {
                            Value *LHS_Rem_ = User_Rem->GetOperand(0);
                            Value *RHS_Rem_ = User_Rem->GetOperand(1);
                            LHS_Rem_ == User_Add ? Rem_RHS = RHS_Rem_ : Rem_RHS = LHS_Rem_;
                            Rem = User_Rem;
                        }
                        for (auto user_user_user : User_Rem->GetUserlist())
                        {
                            if (user_user_user->GetUser() == inst)
                                flag = true;
                        }
                    }
                }
                else
                    continue;
            }
            if (!flag || !Rem || !Add)
                continue;
            Value *times = CaculateTimes(loop);
            if(!times)
                return false;
            BasicBlock *ExitBlock = Loop->GetExit(loop).front();
            if (auto binary = dynamic_cast<BinaryInst *>(times))
            {
                for (auto user : Rem->GetUserlist())
                {
                    if (auto phi = dynamic_cast<PhiInst *>(user->GetUser()))
                    {
                        if (phi->GetParent() == ExitBlock && phi->Getuselist().size() == 1)
                        {
                            auto iter = ExitBlock->begin();
                            while (dynamic_cast<PhiInst *>(*iter))
                                ++iter;
                            iter.insert_before(binary);
                            BinaryInst *New_add = new BinaryInst(binary, BinaryInst::Op_Mul, Add_RHS);
                            iter.insert_before(New_add);
                            BinaryInst *New_Sub = new BinaryInst(New_add, BinaryInst::Op_Sub, Begin);
                            iter.insert_before(New_Sub);
                            BinaryInst *New_Rem = new BinaryInst(New_Sub, BinaryInst::Op_Mod, Rem_RHS);
                            iter.insert_before(New_Rem);
                            phi->RAUW(New_Rem);
                            delete phi;
                            return true;
                        }
                    }
                }
            }
            else
            {
                for (auto user : Rem->GetUserlist())
                {
                    if (auto phi = dynamic_cast<PhiInst *>(user->GetUser()))
                    {
                        if (phi->GetParent() == ExitBlock && phi->Getuselist().size() == 1)
                        {
                            auto iter = ExitBlock->begin();
                            while (dynamic_cast<PhiInst *>(*iter))
                                ++iter;
                            SextInst* new_sext = new SextInst(times);
                            iter.insert_before(new_sext);
                            BinaryInst *New_add = new BinaryInst(new_sext, BinaryInst::Op_Mul, Add_RHS);
                            iter.insert_before(New_add);
                            BinaryInst *New_Sub = new BinaryInst(New_add, BinaryInst::Op_Sub, Begin);
                            iter.insert_before(New_Sub);
                            BinaryInst *New_Rem = new BinaryInst(New_Sub, BinaryInst::Op_Mod, Rem_RHS);
                            iter.insert_before(New_Rem);
                            TruncInst* new_trunc = new TruncInst(New_Rem);
                            iter.insert_before(new_trunc);
                            phi->RAUW(new_trunc);
                            delete phi;
                            delete phi_;
                            return true;
                        }
                    }
                }
            }
        }
    }
}

Value *IndVarSimplify::CaculateTimes(LoopInfo *loop)
{
    Value *iteration = nullptr;
    if (dynamic_cast<ConstIRInt *>(loop->trait.initial) && dynamic_cast<ConstIRInt *>(loop->trait.boundary) &&
        dynamic_cast<BinaryInst *>(loop->trait.change))
    {
        int times = 0;
        int initial = dynamic_cast<ConstIRInt *>(loop->trait.initial)->GetVal();
        int bound = dynamic_cast<ConstIRInt *>(loop->trait.boundary)->GetVal();
        BinaryInst *binary = dynamic_cast<BinaryInst *>(loop->trait.change);
        BinaryInst::Operation Op = binary->getopration();
        int step = loop->trait.step;
        {
            switch (Op)
            {
            case BinaryInst::Op_Add:
                times = (bound - initial + step + (step > 0 ? -1 : 1)) / step;
                break;
            case BinaryInst::Op_Sub:
                times = (initial - bound + step + (step > 0 ? -1 : 1)) / step;
                break;
            case BinaryInst::Op_Mul:
                times = std::log(bound / initial) / std::log(step);
                break;
            case BinaryInst::Op_Div:
                times = std::log(initial / bound) / std::log(step);
                break;
            }
        }
        if (times)
            return ConstIRInt::GetNewConstant(times);
    }
    else if (dynamic_cast<ConstIRFloat *>(loop->trait.initial) && dynamic_cast<ConstIRFloat *>(loop->trait.boundary) &&
             dynamic_cast<BinaryInst *>(loop->trait.change))
    {
        float times = 0;
        float initial = dynamic_cast<ConstIRFloat *>(loop->trait.initial)->GetVal();
        float bound = dynamic_cast<ConstIRFloat *>(loop->trait.boundary)->GetVal();
        BinaryInst *binary = dynamic_cast<BinaryInst *>(loop->trait.change);
        BinaryInst::Operation Op = binary->getopration();
        int step = loop->trait.step;
        {
            switch (Op)
            {
            case BinaryInst::Op_Add:
                times = (bound - initial + step + (step > 0 ? -1 : 1)) / step;
                break;
            case BinaryInst::Op_Sub:
                times = (initial - bound + step + (step > 0 ? -1 : 1)) / step;
                break;
            case BinaryInst::Op_Mul:
                times = std::log(bound / initial) / std::log(step);
                break;
            case BinaryInst::Op_Div:
                times = std::log(initial / bound) / std::log(step);
                break;
            }
        }
        if (times)
            return ConstIRFloat::GetNewConstant(times);
    }
    else if (dynamic_cast<BinaryInst *>(loop->trait.change))
    {
        Value *bound = loop->trait.boundary;
        Value *initial = loop->trait.initial;
        int step = loop->trait.step;
        BinaryInst *change = dynamic_cast<BinaryInst *>(loop->trait.change);
        BinaryInst::Operation Op = change->getopration();
        if (dynamic_cast<BinaryInst *>(bound) && dynamic_cast<BinaryInst *>(initial))
        {
            BinaryInst *bound_binary = dynamic_cast<BinaryInst *>(bound);
            BinaryInst *initial_binary = dynamic_cast<BinaryInst *>(initial);
            BinaryInst *Times = nullptr;
            if (bound_binary->getopration() == BinaryInst::Op_Add &&
                initial_binary->getopration() == BinaryInst::Op_Add)
            {
                auto const1 = dynamic_cast<ConstantData *>(bound_binary->GetOperand(0));
                auto const2 = dynamic_cast<ConstantData *>(bound_binary->GetOperand(1));
                auto const3 = dynamic_cast<ConstantData *>(initial_binary->GetOperand(0));
                auto const4 = dynamic_cast<ConstantData *>(initial_binary->GetOperand(1));
                if (const1)
                {
                    if (const3 && const1 == const3)
                    {
                        if (Op == BinaryInst::Op_Add)
                            Times = new BinaryInst(bound_binary->GetOperand(1), BinaryInst::Op_Sub,
                                                   initial_binary->GetOperand(1));
                        else if (Op == BinaryInst::Op_Sub)
                            Times = new BinaryInst(initial_binary->GetOperand(1), BinaryInst::Op_Add,
                                                   bound_binary->GetOperand(1));
                    }
                    else if (const4 && const1 == const4)
                    {
                        if (Op == BinaryInst::Op_Add)
                            Times = new BinaryInst(bound_binary->GetOperand(1), BinaryInst::Op_Sub,
                                                   initial_binary->GetOperand(1));
                        else if (Op == BinaryInst::Op_Sub)
                            Times = new BinaryInst(initial_binary->GetOperand(0), BinaryInst::Op_Add,
                                                   bound_binary->GetOperand(0));
                    }
                }
                else if (const2)
                {
                    if (const3 && const2 == const3)
                    {
                        if (Op == BinaryInst::Op_Add)
                            Times = new BinaryInst(bound_binary->GetOperand(0), BinaryInst::Op_Sub,
                                                   initial_binary->GetOperand(0));
                        else if (Op == BinaryInst::Op_Sub)
                            Times = new BinaryInst(initial_binary->GetOperand(1), BinaryInst::Op_Add,
                                                   bound_binary->GetOperand(1));
                    }
                    else if (const4 && const2 == const4)
                    {
                        if (Op == BinaryInst::Op_Add)
                            Times = new BinaryInst(bound_binary->GetOperand(0), BinaryInst::Op_Sub,
                                                   initial_binary->GetOperand(0));
                        else if (Op == BinaryInst::Op_Sub)
                            Times = new BinaryInst(initial_binary->GetOperand(0), BinaryInst::Op_Add,
                                                   bound_binary->GetOperand(0));
                    }
                }
            }
            if (Times)
                return Times;
        }
        else if (dynamic_cast<ConstantData *>(initial))
        {
            if (auto INT = dynamic_cast<ConstIRInt *>(initial))
            {
                if (INT->GetVal() == 0)
                {
                    switch (Op)
                    {
                    case BinaryInst::Op_Add:
                    case BinaryInst::Op_Sub:
                        if (step == 1)
                            return bound;
                        else
                        {
                            if (bound->GetType()->GetTypeEnum() == InnerDataType::IR_Value_INT)
                                return new BinaryInst(bound, BinaryInst::Op_Div, ConstIRInt::GetNewConstant(step));
                            else
                                return new BinaryInst(bound, BinaryInst::Op_Div, ConstIRFloat::GetNewConstant(step));
                        }
                    }
                }
                return bound;
            }
            else if (auto FLOAT = dynamic_cast<ConstIRFloat *>(initial))
            {
                if (FLOAT->GetVal() == 0.0)
                {
                    switch (Op)
                    {
                    case BinaryInst::Op_Add:
                    case BinaryInst::Op_Sub:
                        if (step == 1)
                            return bound;
                        else
                        {
                            if (bound->GetType()->GetTypeEnum() == InnerDataType::IR_Value_INT)
                                return new BinaryInst(bound, BinaryInst::Op_Div, ConstIRInt::GetNewConstant(step));
                            else
                                return new BinaryInst(bound, BinaryInst::Op_Div, ConstIRFloat::GetNewConstant(step));
                        }
                    }
                }
            }
        }
    }
    return nullptr;
}