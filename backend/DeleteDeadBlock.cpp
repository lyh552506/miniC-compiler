#include "../include/backend/DeleteDeadBlock.hpp"
bool DeleteDeadBlock::run(RISCVFunction *func){
    std::unordered_map<RISCVBasicBlock*,RISCVBasicBlock*> alias;
    std::function<RISCVBasicBlock*(RISCVBasicBlock*)> findfa=[&](RISCVBasicBlock* bb){
        if(alias.find(bb)==alias.end())return bb;
        return alias[bb]=findfa(alias[bb]);
    };
    
    for(auto bb:*func){
        if(bb->Size()==1){
            auto minst=bb->back();
            if(minst->GetOpcode()==RISCVMIR::_j){
                auto target=minst->GetOperand(0)->as<RISCVBasicBlock>();
                assert(target!=nullptr);
                auto fv=findfa(target);
                if(fv!=bb)alias[bb]=fv;
            }
        }
    }
    for(auto bb:*func){
        if(findfa(bb)!=bb)continue;
        for(auto inst:*bb){
            for(auto i=0,limi=inst->GetOperandSize();i<limi;i++){
                auto op=inst->GetOperand(i)->as<RISCVBasicBlock>();
                if(op!=nullptr){
                    auto fv=findfa(op);
                    if(fv!=op)inst->SetOperand(i,fv);
                }
            }
        }
    }

    for(auto it=func->begin();it!=func->end();){
        auto bb=*it;++it;
        if(findfa(bb)!=bb)delete bb;
    }

    return false;
}