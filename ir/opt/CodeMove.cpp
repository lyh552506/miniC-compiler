#include "../../include/ir/opt/CodeMove.hpp"

void CodeMove::init()
{
    DomTree = AM.get<dominance>(func);
    AM.get<SideEffect>(&Singleton<Module>());
}

bool CodeMove::Run()
{
    return RunMotion();
}

bool CodeMove::RunMotion()
{
    bool modified = false;
    for (BasicBlock *block : *func)
    {
        if (block == func->front())
            continue;
        std::vector<User *> MoveOut;
        std::unordered_set<Value *> MoveOutSet;
        for (User *inst : *block)
        {
            if (!CanHandle(inst))
                continue;

            bool flag = true;
            for (auto &use : inst->Getuselist())
            {
                if (auto user = dynamic_cast<User *>(use->usee))
                {
                    if (user->GetParent() == block)
                    {
                        if (!MoveOutSet.count(user))
                        {
                            flag = false;
                            break;
                        }
                    }
                }
            }
            if (flag)
            {
                MoveOut.push_back(inst);
                MoveOutSet.insert(inst);
            }
        }
        std::vector<std::pair<User *, BasicBlock *>> MoveTo;
        std::unordered_map<User *, BasicBlock *> SetTarget;
        for (User *inst : MoveOut)
        {
            BasicBlock *TargetBlock = func->front();
            auto UpdateTargetBlock = [&](BasicBlock *block) {
                if (block == TargetBlock)
                    return;
                if (DomTree->dominates(TargetBlock, block))
                    TargetBlock = block;
                return;
            };
            bool flag = true;
            for (auto &use : inst->Getuselist())
            {
                Value *val = use->usee;
                if (auto user = dynamic_cast<User *>(val))
                {
                    if (user->GetParent() == block)
                    {
                        if (SetTarget.count(user))
                            UpdateTargetBlock(SetTarget[user]);
                        else
                        {
                            flag = false;
                            break;
                        }
                    }
                    else if (auto parent = user->GetParent())
                        UpdateTargetBlock(parent);
                }
                else
                    flag = false;
            }
            if (!flag)
                continue;
            User *br = TargetBlock->back();
            BasicBlock::mylist<BasicBlock, User>::iterator Pos(br);
            inst->EraseFromParent();
            Pos.insert_before(inst);
            SetTarget.emplace(inst, TargetBlock);
            modified = true;
        }
    }
    return modified;
}

bool CodeMove::CanHandle(User *inst)
{
    if (inst->HasSideEffect())
        return false;
    User::OpID id = inst->id;
    switch (id)
    {
    case User::OpID::Alloca:
    case User::OpID::Phi:
    case User::OpID::Load:
        return false;
    case User::OpID::Div:
    case User::OpID::Mod:
        return false;
        return false;
    case User::OpID::Gep: {
        if (inst->GetOperand(0)->isGlobal())
            return false;
    }
    default:
        return true;
    }
}