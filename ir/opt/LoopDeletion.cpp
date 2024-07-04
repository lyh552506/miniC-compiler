#include "LoopDeletion.hpp"
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "ConstantFold.hpp"
#include "LoopInfo.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include <algorithm>
#include <cassert>
#include <optional>
#include <set>
#include <unordered_map>

void LoopDeletion::RunOnFunction() {
    bool changed = false;
    loop = new LoopAnalysis(func, dom);
    loop->RunOnFunction();
    for (auto loop : *loop)
        changed |= DeleteLoop(loop);
}

bool LoopDeletion::DetectDeadLoop(LoopInfo* loopInfo, dominance* dom)
{
    bool modified = false;
    BasicBlock* preheader = loop->GetPreHeader(loopInfo);
    if(!preheader)
        return false;
    
    bool flag = false;
    std::vector<BasicBlock*> exitblocks = loop->GetExit(loopInfo);
    for(BasicBlock* block : exitblocks)
    {
        for(Use* User_ : block->GetUserlist())
        {
            if(dynamic_cast<CondInst*>(User_->GetUser()) || dynamic_cast<UnCondInst*>(User_->GetUser()))
            {
                BasicBlock* pred = User_->GetUser()->GetParent();
                std::vector<BasicBlock*> LoopBody = loopInfo->GetLoopBody();
                if(std::find(LoopBody.begin(), LoopBody.end(), pred) == LoopBody.end())
                {
                    flag = true;
                    break;
                }
            }
        }
        if(flag)
            return false;
    }

    if(!loopInfo->GetSubLoop().empty())
        return false;
    
    if(exitblocks.size() != 1)
        return false;

    if(CanBeDelete(loopInfo))
        modified |= DeleteLoop(loopInfo);
}

bool LoopDeletion::CanBeDelete(LoopInfo* loopInfo)
{
    BasicBlock* ExitBlock = loop->GetExit(loopInfo)[0];

    Value * CommonValue;
    bool flag_common = true;
    auto inst = ExitBlock->begin();
    while(auto Phi = dynamic_cast<PhiInst*>(*inst))
    {
        for(BasicBlock* block : loop->GetExitingBlock(loopInfo))
        {
            auto val = Phi->GetVal(block->num);
            if(CommonValue && val != CommonValue)
            {
                flag_common = false;
                break;
            }
            CommonValue = val;
        }
        if(!flag_common)
            break;
        
        if(auto Inst_Com = dynamic_cast<User*>(CommonValue))
        {
            break;
        }
    }
}

