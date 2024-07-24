#include "../../include/ir/opt/CSE.hpp"
#include "../../include/ir/Analysis/SideEffect.hpp"
#include "../../include/ir/opt/ConstantFold.hpp"
#include "../../include/ir/opt/InstructionSimplify.hpp"
#include <deque>

void CSE::init()
{
    wait_del.clear();
    CurGeneration = 0;
}

bool CSE::Run()
{
    DomTree = AM.get<dominance>(func);
    AM.get<SideEffect>(&Singleton<Module>());
    bool modified = false;
    std::deque<CSENode *> WorkList;
    WorkList.push_back(new CSENode(DomTree, &(DomTree->GetNode(0)), DomTree->GetNode(0).idom_child.begin(),
                                   DomTree->GetNode(0).idom_child.end(), 0));
    while (!WorkList.empty())
    {
        CSE::CSENode *cur = WorkList.back();
        if (!cur->isProcessed())
        {
            modified |= ProcessNode(cur);
            cur->Process();
            cur->SetChildGeneration(CurGeneration);
        }
        else if (cur->Child() != cur->EndIter())
        {
            auto node = cur->NextChild();
            WorkList.push_back(new CSENode(DomTree, &(DomTree->GetNode(*node)),
                                           DomTree->GetNode(*node).idom_child.begin(),
                                           DomTree->GetNode(*node).idom_child.end(), cur->GetCurGeneration()));
        }
        else
        {
            delete cur;
            WorkList.pop_back();
        }
    }
    while (!wait_del.empty())
    {
        User *inst = wait_del.back();
        wait_del.pop_back();
        delete inst;
    }
    return modified;
}

bool CSE::ProcessNode(CSENode *node)
{
    bool modified = false;
    BasicBlock *block = node->GetBlock();
    _DEBUG(std::cerr << "Processing Node: " << block->GetName() << std::endl;)

    if (block->GetUserlist().GetSize() == 0)
        ++CurGeneration;
    else if (block->GetUserlist().GetSize() > 1)
        ++CurGeneration;
    else
    {
        User *BrInst = block->GetUserlist().Front()->GetUser();
        if (BrInst->GetInstId() == User::OpID::Cond)
        {
            auto cond = (BrInst->Getuselist()[1]->usee == block) ? ConstIRBoolean::GetNewConstant(true)
                                                                 : ConstIRBoolean::GetNewConstant(false);
            _DEBUG(std::cerr << "Can Handle BranchInst: " << inst->GetName() << "as Value:" << cond->GetName()
                             << std::endl;)
            node->SetValue(cond, BrInst);
        }
    }

    User *LastStore = nullptr;

    for (User *inst : *block)
    {
        if (auto binary = dynamic_cast<BinaryInst *>(inst))
        {
            if (Value *val = SimplifyBinOp(binary->getopration(), binary->GetOperand(0), binary->GetOperand(1)))
            {
                _DEBUG(std::cerr << "Can Handle BinaryInst: " << inst->GetName() << "as Value:" << val->GetName()
                                 << std::endl;)
                inst->RAUW(val);
                wait_del.push_back(inst);
                modified |= true;
                continue;
            }
            if (auto val = node->LookUp(inst))
            {
                _DEBUG(std::cerr << "Can Handle BinaryInst: " << inst->GetName() << "as Value:" << val->GetName()
                                 << std::endl;)
                inst->RAUW(val);
                wait_del.push_back(inst);
                modified |= true;
                continue;
            }
            node->SetValue(inst, inst);
            continue;
        }

        if (CanHandle(inst) && !dynamic_cast<CallInst *>(inst))
        {
            if (auto val = node->LookUp(inst))
            {
                _DEBUG(std::cerr << "Can Handle Inst: " << inst->GetName() << "as Value:" << val->GetName()
                                 << std::endl;)
                inst->RAUW(val);
                modified |= true;
                wait_del.push_back(inst);
                continue;
            }
            node->SetValue(inst, inst);
            continue;
        }

        if (dynamic_cast<LoadInst *>(inst))
        {
            if (auto load_val = node->LookUpLoad(inst->Getuselist()[0]->usee, CurGeneration))
            {
                _DEBUG(std::cerr << "Can Handle Load: " << inst->GetName() << "as Value:" << load_val->GetName()
                                 << std::endl;)
                inst->RAUW(load_val);
                wait_del.push_back(inst);
                modified |= true;
                LastStore = nullptr;
                continue;
            }
            node->SetLoadValue(inst->Getuselist()[0]->usee, inst, CurGeneration);
            _DEBUG(std::cerr << "Add Load Value for:" << inst->Getuselist()[0]->usee->GetName() << ", info for it: ("
                             << inst->GetName() << "," << CurGeneration << ")" << std::endl;)
            LastStore = nullptr;
            continue;
        }

        if (dynamic_cast<CallInst *>(inst) && CanHandle(inst))
        {
            if (auto val = node->LookUpCall(inst, CurGeneration))
            {
                _DEBUG(std::cerr << "Can Handle CallInst: " << inst->GetName() << "as Value:" << val->GetName()
                                 << std::endl;)
                wait_del.push_back(inst);
                modified |= true;
                continue;
            }
            node->SetCallValue(inst, inst, CurGeneration);
            LastStore = nullptr;
            continue;
        }
        else if(dynamic_cast<CallInst*>(inst) && inst->HasSideEffect())
        {
            CurGeneration++;
            continue;
        }
        // TODO:DSE
        
        if(dynamic_cast<StoreInst*>(inst))
        {
            ++CurGeneration;
            // if(LastStore)
            // {
            //     wait_del.push_back(LastStore);
            //     modified |= true;
            //     LastStore = nullptr;
            // }
            node->SetLoadValue(inst->GetOperand(1), inst->GetOperand(0), CurGeneration);
            // LastStore = inst;
        }
    }
    return modified;
}

bool CSE::CanHandle(User *inst)
{
    if (dynamic_cast<CallInst *>(inst))
    {
        if (inst->GetType()->GetTypeEnum() == InnerDataType::IR_Value_VOID)
            return false;
        if (inst->HasSideEffect())
            return false;
    }
    if (dynamic_cast<GetElementPtrInst *>(inst))
        return true;
    if (dynamic_cast<BinaryInst *>(inst))
        return true;
    return false;
}