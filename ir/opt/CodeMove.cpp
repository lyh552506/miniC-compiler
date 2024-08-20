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
        std::vector<User *> HandleList;
        std::unordered_set<Value *> CountSet;
        for (User *inst : *block)
        {
            if (!CanHandle(inst, CountSet, block))
                continue;
                HandleList.push_back(inst);
                CountSet.insert(inst);
        }
        if(HandleList.empty())
            continue;
        std::vector<std::pair<User *, BasicBlock *>> MoveTo;
        std::unordered_map<User *, BasicBlock *> MoveMapping;
        for (User *inst : HandleList)
        {
            BasicBlock *MappingBB = func->front();
            auto Update = [&](BasicBlock *block) {
                if (block == MappingBB)
                    return;
                if (DomTree->dominates(MappingBB, block))
                    MappingBB = block;
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
                        if (MoveMapping.count(user))
                            Update(MoveMapping[user]);
                        else
                        {
                            flag = false;
                            break;
                        }
                    }
                    else if (auto parent = user->GetParent())
                        Update(parent);
                }
                else
                    flag = false;
            }
            if (!flag)
                continue;
            User *br = MappingBB->back();
            BasicBlock::mylist<BasicBlock, User>::iterator Pos(br);
            inst->EraseFromParent();
            Pos.insert_before(inst);
            MoveMapping.emplace(inst, MappingBB);
            modified = true;
        }
    }
    return modified;
}

bool CodeMove::CanHandle(User *inst, std::unordered_set<Value *> CountSet, BasicBlock *father)
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
    default: {
        for (auto &use : inst->Getuselist())
        {
            if (auto user = dynamic_cast<User *>(use->usee))
            {
                if (user->GetParent() == father)
                {
                    if (!CountSet.count(user))
                        return false;
                }
            }
        }
        return true;
    }
    }
}