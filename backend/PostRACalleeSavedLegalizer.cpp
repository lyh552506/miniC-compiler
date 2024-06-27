#include "PostRACalleeSavedLegalizer.hpp"
#include "RISCVTrival.hpp"

bool PostRACalleeSavedLegalizer::run(RISCVFunction* func){
    uint64_t grp=func->GetUsedPhyRegMask();
    PhyRegMask::visit(grp,[&grp](uint64_t item){
        if(!PhyRegMask::isCalleeSaved(item))grp&=~item;
    });
    auto entry=func->GetEntry();
    auto exit_bb=func->GetExit();
    auto frame=func->GetFrame();
    PhyRegMask::visit(grp,[entry,exit_bb,&frame](uint64_t item){
        auto phyreg=PhyRegMask::GetPhyReg(item);
        auto frameobj=frame.CreateFrameObject(RISCVFrameObject::Usage::callee_saved,8);
        auto sw=RISCVTrival::SaveToStackObject(phyreg,frameobj);
        entry->push_front(sw);
        auto reload=RISCVTrival::LoadFromStackObject(phyreg,frameobj);
        // insert before ret
        exit_bb->push_back(reload);
    });
}