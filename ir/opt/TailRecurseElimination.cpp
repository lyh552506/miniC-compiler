#include "../../include/ir/opt/TailRecurseElimination.hpp"

std::vector<std::pair<CallInst*,RetInst*>> TailRecurseEliminator::CanTailRecurseTransform(Function* func){
    std::vector<std::pair<CallInst*,RetInst*>> worklist;
    
    auto usrlist=func->GetUserlist();
    for(auto usr:usrlist){
        auto call=usr->GetUser()->as<CallInst>();
        assert(call!=nullptr);
        if(call->GetParent()->GetParent()==func){
            auto ret=call->nextListNode()->as<RetInst>();
            // 只有存在有效返回值，且返回值不是call的时候，才不删除
            if(ret!=nullptr){
                if(
                    ret->GetUserListSize()==0 //函数返回void，就算 call 有返回值 caller saved 无所谓
                ||  ret->GetOperand(0)->isUndefVal() //同上
                ||  ret->GetOperand(0)==call //返回call
                ){
                    worklist.push_back(std::make_pair(call,ret));
                }
            }
        }
    }
    
    return worklist;
}

std::pair<BasicBlock*,BasicBlock*> TailRecurseEliminator::SeparateAllocaIntoEntryBlock(){
    auto entry=func->front();
    User* comma=nullptr;
    for(auto inst:*entry){
        if(inst->as<AllocaInst>()!=nullptr){
            comma=inst;
        }
        else break;
    }
    if(comma==nullptr){
        //说明没有alloca
        auto newblock=new BasicBlock();
        newblock->push_back(new UnCondInst(entry));
        func->push_front(newblock);
        return std::make_pair(newblock,entry);
    }
    comma=comma->nextListNode();
    assert(comma!=nullptr);
    auto dst=entry->SplitAt(comma);
    entry->push_back(new UnCondInst(dst));
    auto func_it=mylist<Function,BasicBlock>::iterator(entry);
    func_it.insert_after(dst);
    return std::make_pair(entry,dst);
}

bool TailRecurseEliminator::Run(){
    auto worklist=CanTailRecurseTransform(func);
    if(worklist.empty())
        return false;
    
    auto [entry,jump_dst]=SeparateAllocaIntoEntryBlock();

    auto& params=func->GetParams();
    std::vector<PhiInst*> phis;
    for(auto& param:params){
        auto newphi=new PhiInst(param->GetType());
        param->RAUW(newphi);
        newphi->updateIncoming(param.get(),entry);
        phis.push_back(newphi);
    }

    for(auto [call,ret]:worklist){
        auto src=call->GetParent();
        auto size=call->Getuselist().size()-1;
        assert(size==phis.size()&&"frontend guarrenteed, couldn't be");
        for(auto i=0;i<size;i++){
            // the first is function itself, causion that
            phis[i]->updateIncoming(call->GetOperand(i+1),src);
        }

        auto newuncond=new UnCondInst(jump_dst);
        ret->FullReplace(newuncond);
        // can't change the order for call *might* be used by return
        delete ret;
        delete call;
    }

    for(auto phi:phis)
    {
        phi->FormatPhi();
        jump_dst->push_front(phi);
    }
    
    func->isRecursive(false);

    return true;
}