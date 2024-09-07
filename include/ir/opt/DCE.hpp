#pragma once
#include "../../lib/CFG.hpp"
#include "New_passManager.hpp"
#include "PassManagerBase.hpp"

class _AnalysisManager;
class DCE : public _PassManagerBase<DCE, Function>
{
public:
    bool Run();
    DCE(Function* func_, _AnalysisManager &AM) : func(func_), AM(AM) { }
private:
    bool isDeadInst(User* inst);
    bool DelF = false;
    Function* func;
    bool DCEInst(User* inst, std::vector<User*> &Worklist);
    bool HandlePhi(PhiInst* phi);
    bool DeadPhiCycle(PhiInst* phi, std::set<PhiInst*>& PotentiallyDeadPhis);
    Value* RVACC(Function* func);
    _AnalysisManager& AM;
    bool PassChanged=false;
};