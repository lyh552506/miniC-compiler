#include "../../include/ir/opt/GepCombine.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../include/ir/opt/ConstantFold.hpp"
#include "../../include/ir/opt/InstructionSimplify.hpp"
#include <deque>
#include <algorithm>

bool GepCombine::Run()
{
    DomTree = AM.get<dominance>(func);
    AM.get<SideEffect>(&Singleton<Module>());
    bool modified = false;
    std::deque<HandleNode *> WorkList;
    WorkList.push_back(new HandleNode(DomTree, &(DomTree->GetNode(0)), DomTree->GetNode(0).idom_child.begin(),
                                      DomTree->GetNode(0).idom_child.end(), std::unordered_map<Value*, std::unordered_set<gepinfo*>>(), std::unordered_set<binaryinfo*>()));
    while (!WorkList.empty())
    {
        GepCombine::HandleNode *cur = WorkList.back();
        if (!cur->isProcessed())
        {
            modified |= ProcessNode(cur);
            cur->Process();
        }
        else if (cur->Child() != cur->EndIter())
        {
            auto node = cur->NextChild();
            WorkList.push_back(new HandleNode(DomTree, &(DomTree->GetNode(*node)),
                                              DomTree->GetNode(*node).idom_child.begin(),
                                              DomTree->GetNode(*node).idom_child.end(), cur->GetGeps(), cur->GetBinarys()));
        }
        else
        {
            delete cur;
            WorkList.pop_back();
        }
    }
    return modified;
}

bool GepCombine::ProcessNode(HandleNode *node)
{
    bool modified = false;
    BasicBlock *block = node->GetBlock();
    _DEBUG(std::cerr << "Processing Node: " << block->GetName() << std::endl;)
    
    for(User* inst : *block)
    {
        if(auto binary  = dynamic_cast<BinaryInst*>(inst))
        {

        }

        if(auto gep = dynamic_cast<GetElementPtrInst*>(inst))
        {
            if(auto val = SimplifyGepInst(gep))
            {
                gep->RAUW(val);
                modified |= true;
                continue;
            }
            bool Changed = false;
            Value* Base = gep->Getuselist()[0]->usee;
            
        }
    }
}

Value* GepCombine::SimplifyGepInst(GetElementPtrInst* inst)
{
    Value* Base = inst->Getuselist()[0]->usee;
    
    // In this case, there is only < gep base > -> base
    if(inst->Getuselist().size() == 1)
        return Base;
    
    if(dynamic_cast<UndefValue*>(Base))
        return UndefValue::get(inst->GetType());
    
    if(inst->Getuselist().size() == 2)
    {
        Value * Op1 = inst->Getuselist()[1]->usee;
        if(auto val = dynamic_cast<ConstantData*>(Op1))
        {
            if(val->isConstZero())
                return Base;
        }
        // Now there is the case of < gep base, offset >
        {
            if(auto tp = dynamic_cast<HasSubType*>(Base->GetType()))
            {
                if(tp->get_size() == 0)
                    return Base;
            }
            
            if(auto binary = dynamic_cast<BinaryInst*>(Op1))
            {
                if(binary->getopration() == BinaryInst::Operation::Op_Sub)
                {
                    if(binary->Getuselist()[1]->usee == Base)
                    {
                        inst->RSUW(inst->Getuselist()[0].get(), binary->Getuselist()[0]->usee);
                        inst->RSUW(inst->Getuselist()[1].get(), ConstIRInt::GetNewConstant(0));
                        return inst;
                    }
                }
            }
        }
    }

    // Now handle the case of < gep base, 0, 0, 0  ... >
    auto all_offset_zero = [&inst]()
    {
        return std::all_of(inst->Getuselist().begin() + 1, inst->Getuselist().end(), [](User::UsePtr &use)
        {
            if(auto val = dynamic_cast<ConstantData*>(use->usee))
            {
                return val->isConstZero();
            }
            return false;
        });
    };
    // if(all_offset_zero())
        // return Base;
    return nullptr;
}