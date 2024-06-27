#include "CSE.hpp"
#include "HashScope.hpp"
#include "DCE.hpp"
#include "ConstantFold.hpp"

void CSE::Init()
{
    CurrGens = 0;
    AEB_Binary.clear();
    AEB.clear();
    AEB_Const_RHS.clear();
    AEB_Const_LHS.clear();
    Loads.clear();
    Geps.clear();
    HashMap.clear();
    Change_Load_Funcs.clear();
}

bool CSE::RunOnFunc()
{
    bool modified = false;
    // 这里采用deque而非vector的原因是在元素个数较多的时候deque的效率更高
    std::deque<dominance::Node*> WorkList;
    // std::vector<dominance::Node*> DFS = DomTree->node;
    std::queue<dominance::Node*> DFS = DomTree->DFS_Dom();
    // 将DFS中元素压入WorkList中
    while(!DFS.empty())
    {
        WorkList.push_back(DFS.front());
        DFS.pop();
    }
    // WorkList.push_back(DFS.front());
    // for (auto it = DFS.begin() + 1; it != DFS.end(); ++it)
    //     WorkList.push_back(*it);
    while(!WorkList.empty())
    {
        dominance::Node* CurrNode = WorkList.front();
        if(!Processed.count(CurrNode))
        {
            modified |= RunOnNode(CurrNode);
            Processed.insert(CurrNode);
            WorkList.pop_front();
        }
    }
    return modified;
}

bool CSE::RunOnNode(dominance::Node* node)
{
    bool modified = false;
    BasicBlock* CurrentBlock = node->thisBlock;
    for(User* inst : *CurrentBlock)
    {
        // Binary
        if(dynamic_cast<BinaryInst*>(inst))
        {
            Value* LHS = inst->GetOperand(0);
            Value* RHS = inst->GetOperand(0);

            ConstantData* ConstLHS = dynamic_cast<ConstantData*>(LHS);
            ConstantData* ConstRHS = dynamic_cast<ConstantData*>(RHS);
            if(LHS)
            {
                if(AEB_Const_LHS.find(std::make_tuple(ConstLHS, RHS, inst->GetInstId())) != AEB_Const_LHS.end())
                {
                    std::pair<size_t, Value*>& iter = AEB_Const_LHS[std::make_tuple(ConstLHS, RHS, inst->GetInstId())];
                    inst->RAUW(iter.second);
                    wait_del.push_back(inst);
                    modified = true;
                }
                else
                {
                    AEB_Const_LHS[std::make_tuple(ConstLHS, RHS, inst->GetInstId())] = std::make_pair(CurrGens, inst);
                }
            }
            else if(RHS)
            {
                if(AEB_Const_RHS.find(std::make_tuple(LHS, ConstRHS, inst->GetInstId())) != AEB_Const_RHS.end())
                {
                    std::pair<size_t, Value*>& iter = AEB_Const_RHS[std::make_tuple(LHS, ConstRHS, inst->GetInstId())];
                    inst->RAUW(iter.second);
                    wait_del.push_back(inst);
                    modified = true;
                }
                else
                {
                    AEB_Const_RHS[std::make_tuple(LHS, ConstRHS, inst->GetInstId())] = std::make_pair(CurrGens, inst);
                }
            }
            else
            {
                if(AEB_Binary.find(std::make_tuple(LHS, RHS, inst->GetInstId())) != AEB_Binary.end())
                {
                    std::pair<size_t, Value*>& iter = AEB_Binary[std::make_tuple(LHS, RHS, inst->GetInstId())];
                    inst->RAUW(iter.second);
                    wait_del.push_back(inst);
                    modified = true;
                }
                else
                {
                    AEB_Binary[std::make_tuple(LHS, RHS, inst->GetInstId())] = std::make_pair(CurrGens, inst);
                }
            }
        }

        // Gep
        if(dynamic_cast<GetElementPtrInst*>(inst))
        {
            Value* Base = inst->GetOperand(0);
            size_t Offset = HashTool::InstHash{}(inst);
            if(Geps.find(std::make_tuple(Base, Offset, inst->GetInstId())) != Geps.end())
            {
                Value* val = Geps[std::make_tuple(Base, Offset, inst->GetInstId())];
                if(User* gep = dynamic_cast<User*>(val))
                {
                    if(DomTree->dominates(gep->GetParent(), CurrentBlock))
                    {
                        inst->RAUW(Geps[std::make_tuple(Base, Offset, inst->GetInstId())]);
                        wait_del.push_back(inst);
                        modified = true;
                    }
                }
            }
            else
            {
                Geps[std::make_tuple(Base, Offset, inst->GetInstId())] = inst;
            }
        }
        // TODO: There is a situation that whether SideEffectCall is before \
                 the load which has changed the value of the loaded val

        // 考虑一个处理方法？ 沿着 DFS 顺序下降的时候碰到一个 CallInst 时候，选择考虑
        // Load
        if(dynamic_cast<LoadInst*>(inst))
        {
            Value* Val = inst->GetOperand(0);
            if(Loads.find(std::make_pair(Val, inst->GetInstId())) != Loads.end())
            {
                Value* val = Loads[std::make_pair(Val, inst->GetInstId())];
                if(User* load = dynamic_cast<User*>(val))
                {
                    // if(DomTree->dominates(load->GetParent(), CurrentBlock) && 之前的Change_Load_Func \
                    没有包含这个Load (Val.ChangedFuncs.find()))
                    // Function* change_func = Find_Change(Val);
                    // if(DomTree->dominates(load->GetParent(), CurrentBlock))
                    // {
                    //     if(!change_func)
                    //     {
                    //         inst->RAUW(Loads[std::make_pair(Val, inst->GetInstId())]);
                    //         wait_del.push_back(inst);
                    //         modified = true;
                    //     }
                    //     else
                    //     {
                    //         Change_Load_Funcs.erase(change_func);
                    //         Loads[std::make_pair(Val, inst->GetInstId())] = inst;
                    //     }
                    // }
                    if(DomTree->dominates(load->GetParent(), CurrentBlock))
                    {
                        inst->RAUW(Loads[std::make_pair(Val, inst->GetInstId())]);
                        wait_del.push_back(inst);
                        modified = true;
                    }
                }
            }
            else
            {
                Loads[std::make_pair(Val, inst->GetInstId())] = inst;
            }
        }

        // Store
        if(dynamic_cast<StoreInst*>(inst))
        {
            Value* src = inst->GetOperand(0);
            Value* dst = inst->GetOperand(1);

            for(auto& iter : Loads)
            {
                if(iter.first.first == dst)
                {
                    // Loads[std::make_pair(dst, User::OpID::Load)] = src;
                    Loads.erase(std::make_pair(dst, User::OpID::Load));
                }
            }
        }

        // Call
        if(CallInst* Call = dynamic_cast<CallInst*>(inst))
            if(Call->HasSideEffect())
                if(Function* func = dynamic_cast<Function*>(Call->Getuselist()[0]->usee))
                    Change_Load_Funcs.insert(func);
        ++CurrGens;
    }
    while(!wait_del.empty())
    {
        User* inst = wait_del.back();
        wait_del.pop_back();
        delete inst;
        ++DelNum;
    }
    return modified;
}

Function* CSE::Find_Change(Value* val)
{
    for(Function* item : Change_Load_Funcs)
    {
        if(val->Change_Funcs.find(item) != val->Change_Funcs.end())
            return item;
    }
    return nullptr;
}