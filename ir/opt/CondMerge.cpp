#include "../../include/ir/opt/CondMerge.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/lib/Singleton.hpp"

bool CondMerge::Run()
{
    /*
    Test for And Or
    Value *op1 = ConstIRBoolean::GetNewConstant(true);
    Value *op2 = ConstIRBoolean::GetNewConstant(false);
    auto binary = new BinaryInst(op1, BinaryInst::Op_And, op2);
    BasicBlock* block = func->front();
    block->push_front(binary);
    */
    dom = AM.get<dominance>(func);
    bool modified = false;
    bool changed = true;
    func->init_visited_block();
    OrderBlock(func->front());
    std::reverse(DFSOrder.begin(), DFSOrder.end());
    while (changed)
    {
        changed = false;
        changed |= AdjustCondition();
        modified |= changed;
    }
    while (!wait_del.empty())
    {
        BasicBlock *block = *wait_del.begin();
        wait_del.erase(block);
        delete block;
    }
    return modified;
}

void CondMerge::OrderBlock(BasicBlock *block)
{
    if (block->visited)
        return;
    block->visited = true;
    for (int dest : dom->GetNode(block->num).des)
        OrderBlock(dom->GetNode(dest).thisBlock);
    DFSOrder.push_back(block);
}

bool CondMerge::AdjustCondition()
{
    bool modified = false;

    for (BasicBlock *block : DFSOrder)
    {
        if (wait_del.count(block))
            continue;
        User *br = block->back();
        if (br && dynamic_cast<CondInst *>(br))
        {
            BasicBlock *succ_and = br->Getuselist()[1]->usee->as<BasicBlock>();
            BasicBlock *succ_or = br->Getuselist()[2]->usee->as<BasicBlock>();
            if (Handle_And(block, succ_and, wait_del))
                modified = true;
            else if (Handle_Or(block, succ_or, wait_del))
                modified = true;
        }
    }
    return modified;
}

bool CondMerge::Handle_Or(BasicBlock *cur, BasicBlock *succ, std::unordered_set<BasicBlock *> &wait_del)
{
    if (cur == succ)
        return false;
    bool modified = false;
    if (succ->GetUserlist().GetSize() > 1)
        return false;
    assert((cur->back()->Getuselist()[1]->usee == succ) ||
           (cur->back()->Getuselist()[2]->usee == succ) && "Error: Neither of the succ is succ_in.");
    auto Cur_Cond = dynamic_cast<CondInst *>(cur->back());
    auto Succ_Cond = dynamic_cast<CondInst *>(succ->back());
    if (Succ_Cond && Succ_Cond->Getuselist()[2]->usee == succ)
        return false;
    if (Cur_Cond && Succ_Cond)
    {
        Value *cond1 = Cur_Cond->Getuselist()[0]->usee;
        Value *cond2 = Succ_Cond->Getuselist()[0]->usee;
        if (Cur_Cond->Getuselist()[1]->usee == Succ_Cond->Getuselist()[1]->usee &&
            !Match_Lib_Phi(cur, succ, static_cast<BasicBlock *>(Cur_Cond->Getuselist()[1]->usee)) &&
            !DetectCall(cond2, succ, 0) && !RetPhi(static_cast<BasicBlock *>(Cur_Cond->Getuselist()[1]->usee)))
        {
            _DEBUG(std::cerr << "Handling Or(||) case" << std::endl;)
            Cur_Cond->RSUW(Cur_Cond->Getuselist()[2].get(), Succ_Cond->Getuselist()[2]->usee);
            BasicBlock *PhiBlock1 = Succ_Cond->Getuselist()[1]->usee->as<BasicBlock>();
            BasicBlock *PhiBlock2 = Succ_Cond->Getuselist()[2]->usee->as<BasicBlock>();
            Succ_Cond->ClearRelation();
            Succ_Cond->EraseFromParent();
            BasicBlock::mylist<BasicBlock, User>::iterator Cur_iter(Cur_Cond);
            for (auto it = succ->begin(); it != succ->end();)
            {
                (*it)->EraseFromParent();
                if (auto phi = dynamic_cast<PhiInst *>(*it))
                {
                    phi->EraseRecordByBlock(cur);
                    cur->push_front(phi);
                }
                else
                    Cur_iter.insert_before(*it);
                it = succ->begin();
            }
            auto binary_or = new BinaryInst(cond1, BinaryInst::Op_Or, cond2);
            Cur_iter.insert_before(binary_or);
            Cur_Cond->RSUW(Cur_Cond->Getuselist()[0].get(), binary_or);
            auto phi_iter = PhiBlock1->begin();
            while (auto phi = dynamic_cast<PhiInst *>(*phi_iter))
            {
                phi->ModifyBlock_CheckSame(succ, cur);
                ++phi_iter;
            }
            phi_iter = PhiBlock2->begin();
            while (auto phi = dynamic_cast<PhiInst *>(*phi_iter))
            {
                phi->ModifyBlock_CheckSame(succ, cur);
                ++phi_iter;
            }
            wait_del.insert(succ);
            succ->RAUW(cur);
            modified = true;
        }
    }
    return modified;
}

bool CondMerge::Handle_And(BasicBlock *cur, BasicBlock *succ, std::unordered_set<BasicBlock *> &wait_del)
{
    if (cur == succ)
        return false;
    if (succ->GetUserlist().GetSize() > 1)
        return false;
    bool modified = false;
    assert((cur->back()->Getuselist()[1]->usee == succ) ||
           (cur->back()->Getuselist()[2]->usee == succ) && "Error: Neither of the succ is succ_in.");
    auto Cur_Cond = dynamic_cast<CondInst *>(cur->back());
    auto Succ_Cond = dynamic_cast<CondInst *>(succ->back());
    if (Succ_Cond && Succ_Cond->Getuselist()[1]->usee == succ)
        return false;
    if (Cur_Cond && Succ_Cond)
    {
        Value *cond1 = Cur_Cond->Getuselist()[0]->usee;
        Value *cond2 = Succ_Cond->Getuselist()[0]->usee;
        if (Cur_Cond->Getuselist()[2]->usee == Succ_Cond->Getuselist()[2]->usee &&
            !Match_Lib_Phi(cur, succ, static_cast<BasicBlock *>(Cur_Cond->Getuselist()[2]->usee)) &&
            !DetectCall(cond2, succ, 0))
        {
            _DEBUG(std::cerr << "Handling And(&&) case" << std::endl;)
            BasicBlock *PhiBlock = Succ_Cond->Getuselist()[2]->usee->as<BasicBlock>();
            Cur_Cond->RSUW(Cur_Cond->Getuselist()[1].get(), Succ_Cond->Getuselist()[1]->usee);
            Succ_Cond->ClearRelation();
            Succ_Cond->EraseFromParent();
            BasicBlock *PhiBlock1 = Succ_Cond->Getuselist()[1]->usee->as<BasicBlock>();
            BasicBlock *PhiBlock2 = Succ_Cond->Getuselist()[2]->usee->as<BasicBlock>();
            BasicBlock::mylist<BasicBlock, User>::iterator Cur_iter(Cur_Cond);
            for (auto it = succ->begin(); it != succ->end();)
            {
                (*it)->EraseFromParent();
                if (auto phi = dynamic_cast<PhiInst *>(*it))
                {
                    phi->EraseRecordByBlock(cur);
                    cur->push_front(phi);
                }
                else
                    Cur_iter.insert_before(*it);
                it = succ->begin();
            }
            auto binary_and = new BinaryInst(cond1, BinaryInst::Op_And, cond2);
            Cur_iter.insert_before(binary_and);
            Cur_Cond->RSUW(Cur_Cond->Getuselist()[0].get(), binary_and);
            auto phi_iter = PhiBlock1->begin();
            while (auto phi = dynamic_cast<PhiInst *>(*phi_iter))
            {
                phi->ModifyBlock_CheckSame(succ, cur);
                ++phi_iter;
            }
            phi_iter = PhiBlock2->begin();
            while (auto phi = dynamic_cast<PhiInst *>(*phi_iter))
            {
                phi->ModifyBlock_CheckSame(succ, cur);
                ++phi_iter;
            }
            wait_del.insert(succ);
            succ->RAUW(cur);
            modified = true;
        }
    }
    return modified;
}

bool CondMerge::DetectCall(Value *val, BasicBlock *block, int depth)
{
    if (!dynamic_cast<User *>(val))
        return false;
    auto user = dynamic_cast<User *>(val);
    if (depth > 16)
        return false;
    if (user->GetParent() != block)
        return false;
    if (dynamic_cast<CallInst *>(val))
        return true;
    for (int i = 0; i < user->Getuselist().size(); i++)
    {
        if (DetectCall(user->GetOperand(i), block, depth + 1))
            return true;
    }
    return false;
}

bool CondMerge::RetPhi(BasicBlock *block)
{
    for (auto it = block->begin(); it != block->end(); ++it)
    {
        if (auto phi = dynamic_cast<PhiInst *>(*it))
        {
            for (auto user : phi->GetUserlist())
            {
                if (dynamic_cast<RetInst *>(user->GetUser()))
                    return true;
            }
        }
        else
            break;
    }
    return false;
}

bool CondMerge::Match_Lib_Phi(BasicBlock *curr, BasicBlock *succ, BasicBlock *exit)
{
    for (User *inst : *succ)
    {
        if (dynamic_cast<CallInst *>(inst))
        {
            std::string name = dynamic_cast<CallInst *>(inst)->GetOperand(0)->GetName();
            if (name == "putch" || name == "putint" || name == "putfloat" || name == "putarray" ||
                name == "putfarray" || name == "putf" || name == "getint" || name == "getch" || name == "getfloat" ||
                name == "getfarray" | name == "getarray" || name == "_sysy_starttime" || name == "_sysy_stoptime" ||
                name == "llvm.memcpy.p0.p0.i32")
                return true;
        }
    }
    for (User *inst : *exit)
    {
        if (auto phi = dynamic_cast<PhiInst *>(inst))
        {
            Value *from_cur = nullptr;
            Value *from_succ = nullptr;
            for (auto &[key, val] : phi->PhiRecord)
            {
                if (val.second == curr)
                {
                    from_cur = val.first;
                    if (from_succ)
                        break;
                }
                if (val.second == succ)
                {
                    from_succ = val.first;
                    if (from_cur)
                        break;
                }
            }
            if (from_cur && from_succ)
            {
                if(from_cur == from_succ)
                    return true;
                if (DetectUserPos(from_cur, succ, from_succ))
                    return true;
            }
        }
    }
    return false;
}

bool CondMerge::DetectUserPos(Value *user, BasicBlock *blockpos, Value *val)
{
    for (auto user : user->GetUserlist())
    {
        if (user->GetUser() == val)
            return true;
        else if (user->GetUser()->GetParent() == blockpos)
        {
            if (DetectUserPos(user->GetUser(), blockpos, val))
                return true;
        }
    }
    return false;
}