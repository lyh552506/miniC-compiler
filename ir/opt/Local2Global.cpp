#include "../../include/ir/opt/Global2Local.hpp"
#include "../../util/my_stl.hpp"
bool Local2Global::Run()
{
    CreateHoist();
    RunPass();
    return false;
}

void Local2Global::CreateHoist()
{
    for (auto &func_ptr : module->GetFuncTion())
    {
        for (BasicBlock *block : *func_ptr)
        {
            for (User *inst : *block)
            {
                if (inst->GetInstId() == User::OpID::Alloca)
                {
                    size_t size = 0;
                    Type *BaseType = inst->GetType();
                    if (auto SubTp = dynamic_cast<HasSubType *>(BaseType))
                        size = SubTp->GetSubType()->get_size();
                    else
                        size = BaseType->get_size();
                    if (size > MinSize)
                        Wait_Hoist.push_back(inst);
                }
            }
        }
    }
}

void Local2Global::RunPass()
{
    while (!Wait_Hoist.empty())
    {
        Value *alloca = Wait_Hoist.back();
        _DEBUG(std::cerr << "Global Value:" << alloca->GetName() << std::endl;)
        Wait_Hoist.pop_back();
        auto global = new Variable(Variable::GlobalVariable, dynamic_cast<HasSubType *>(alloca->GetType())->GetSubType(), alloca->GetName());
        alloca->RAUW(global);
        delete alloca;
    }
}