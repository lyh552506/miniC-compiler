#include "../../include/ir/opt/IndVarExtr.hpp"

bool IndVarExtr::Run()
{
    bool run = true;
    bool modified = false;
    while(run)
    {
        run = false;
        PassChangedBegin(curfunc);
        DomTree = AM.get<dominance>(func);
        loopAnlasis = AM.get<LoopAnalysis>(func, DomTree, std::ref(DeleteLoop));
        Loops = loopAnlasis->GetLoops();
        for (auto loop : Loops)
        {
            auto pair = Judge(loop);
            if (!pair.first)
                continue;
            HandleLoop(loop, pair);
            modified = true;
            run = true;
            break;
        }
    }
    return modified;
}

std::pair<User *, BasicBlock *> IndVarExtr::Judge(LoopInfo *loop)
{
    if (!loopAnlasis->GetPreHeader(loop))
        return std::pair{nullptr, nullptr};
    if (!loop->GetSubLoop().empty())
        return std::pair{nullptr, nullptr};
    if (loopAnlasis->GetLatch(loop) != loop->GetHeader())
        return std::pair{nullptr, nullptr};
    if (loopAnlasis->GetExit(loop).size() != 1)
        return std::pair{nullptr, nullptr};
    if (loop->GetLoopBody().size() != 1)
        return std::pair{nullptr, nullptr};
    BasicBlock *block = loop->GetLoopBody().front();
    auto iter = block->begin();
    LoopSimplify::CaculateLoopInfo(loop, loopAnlasis);
    if(!loop->trait.boundary)
        return std::pair{nullptr, nullptr};
    int phicount = 0;
    PhiInst *indvar = nullptr;
    while (auto phi = dynamic_cast<PhiInst *>(*iter))
    {
        indvar = phi;
        phicount++;
        ++iter;
    }
    if (!indvar)
        return std::pair{nullptr, nullptr};
    if (loop->trait.indvar && indvar != loop->trait.indvar)
        return std::pair{nullptr, nullptr};
    if (phicount > 1)
        return std::pair{nullptr, nullptr};
    int count = 0;
    BasicBlock *out_side = nullptr;
    User *outinst = nullptr;
    for (User *inst : *block)
    {
        for (auto user : inst->GetUserlist())
        {
            if (count > 1)
                return std::pair{nullptr, nullptr};
            if (user->GetUser() && user->GetUser()->GetParent() == block)
                continue;
            else
            {
                count++;
                out_side = user->GetUser()->GetParent();
                outinst = inst;
            }
        }
    }
    if(out_side == nullptr || outinst == nullptr)
        return std::pair{nullptr, nullptr};
    if(out_side && out_side->GetUserlist().GetSize() > 1)
        return std::pair{nullptr, nullptr};
    return std::pair{outinst, out_side};
}

void IndVarExtr::HandleLoop(LoopInfo *loop, std::pair<User *, BasicBlock *> pair)
{
    std::vector<User *> wait_move;
    User *inst = pair.first;
    BasicBlock *block = loop->GetLoopBody().front();
    for(auto br_ : block->GetUserlist())
    {
        User* br = br_->GetUser();
        if(dynamic_cast<UnCondInst*>(br))
        {
            br->RSUW(0, pair.second);
            break;
        }
    }

    for (auto iter = BasicBlock::mylist<BasicBlock, User>::iterator(inst); iter != block->rend();)
    {
        User *handle = *iter;
        if (handle == inst)
        {
            wait_move.push_back(handle);
            --iter;
            continue;
        }
        auto can_insert = [&](User *inst) {
            for (auto user : inst->GetUserlist())
            {
                User *user_user = user->GetUser();
                if (user_user && std::find(wait_move.begin(), wait_move.end(), user_user) != wait_move.end())
                    return true;
            }
            return false;
        };
        if (can_insert(handle))
            wait_move.push_back(handle);
        --iter;
    }
    BasicBlock *move_to = pair.second;
    User *User_pos = nullptr;
    for (auto user : inst->GetUserlist())
    {
        User *userinst = user->GetUser();
        if (userinst && userinst->GetParent() == move_to)
            User_pos = userinst;
    }
    BasicBlock::mylist<BasicBlock, User>::iterator Pos(User_pos);
    Value* bound = loop->trait.boundary;
    while (!wait_move.empty())
    {
        User *move = wait_move.back();
        wait_move.pop_back();
        if(auto phi = dynamic_cast<PhiInst*>(move))
        {
            phi->RAUW(bound);
            delete phi;
            continue;
        }
        move->EraseFromParent();
        Pos.insert_before(move);
    }
    delete block;
}
