#include "../../include/ir/opt/BranchRotate.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../include/lib/Singleton.hpp"

bool BranchRotate::Run()
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
    func->init_visited_block();
    OrderBlock(func->front());
    std::reverse(DFSOrder.begin(), DFSOrder.end());
    // modified |= NormalizingCmp();
    // modified |= CombineCmp();
    modified |= AdjustCondition();
    return modified;
}

bool BranchRotate::NormalizingCmp()
{
    bool modified = false;
    for (BasicBlock *block : DFSOrder)
    {
        User *inst = block->back();
        if (dynamic_cast<CondInst *>(inst))
        {
            auto cmp = dynamic_cast<BinaryInst *>(inst->Getuselist()[0]->usee);
            if (cmp && cmp->IsCmpInst())
            {

                BasicBlock::mylist<BasicBlock, User>::iterator it(inst);
                BasicBlock::mylist<BasicBlock, User>::iterator it1(cmp);
                if (++it1 != it)
                {
                    std::unordered_map<Operand, Operand> Mapping;
                    Mapping[cmp->GetOperand(0)] = cmp->GetOperand(0);
                    Mapping[cmp->GetOperand(1)] = cmp->GetOperand(1);
                    auto new_cmp = cmp->clone(Mapping);
                    it.insert_before(new_cmp);
                    inst->RSUW(inst->Getuselist()[0].get(), new_cmp);
                    cmp->ClearRelation();
                    cmp->EraseFromParent();
                    modified |= true;
                    continue;
                }
            }
        }
    }
    return modified;
}

void BranchRotate::OrderBlock(BasicBlock *block)
{
    if (block->visited)
        return;
    block->visited = true;
    for (int dest : dom->GetNode(block->num).des)
        OrderBlock(dom->GetNode(dest).thisBlock);
    DFSOrder.push_back(block);
}

bool BranchRotate::CombineCmp()
{
    bool modified = false;
    for (BasicBlock *block : DFSOrder)
    {
        auto &cmps = CmpMap[block];
        if (auto parent = dom->GetNode(dom->GetNode(block->num).idom).thisBlock)
            cmps = CmpMap[parent];

        for (auto iter = block->rbegin(); iter != block->rend(); --iter)
        {
            auto cmp = dynamic_cast<BinaryInst *>(*iter);
            if (!cmp)
                continue;
            if (!cmp->IsCmpInst())
                continue;
            bool Should_del = false;
            size_t hash = std::hash<User::OpID>{}(cmp->GetInstId()) ^ std::hash<Operand>{}(cmp->GetOperand(0)) ^
                          std::hash<Operand>{}(cmp->GetOperand(1));
            auto &IncomeCmps = cmps[hash];
            for (BinaryInst *Income : IncomeCmps)
            {
                BinaryInst::Operation Income_op = Income->getopration();
                BinaryInst::Operation Cur_Op = cmp->getopration();
                auto match_Op = [&](int i, int j) {
                    return cmp->GetOperand(0) == Income->GetOperand(i) && cmp->GetOperand(1) == Income->GetOperand(j);
                };

                if ((Income_op == Cur_Op && match_Op(0, 1)) ||
                    (Income->GetReversedOperation(Income_op) == Cur_Op && match_Op(1, 0)))
                {
                    cmp->RAUW(Income);
                    Should_del = true;
                    break;
                }
                if ((Income->GetInvertedOperation(Income_op) == Cur_Op && match_Op(0, 1)) ||
                    (Income->GetReversedOperation(Income->GetInvertedOperation(Income_op)) == Cur_Op && match_Op(1, 0)))
                {
                    BasicBlock::mylist<BasicBlock, User>::iterator it(cmp);
                    auto xor_ = new BinaryInst(Income, BinaryInst::Op_Xor, ConstIRBoolean::GetNewConstant(true));
                    it.insert_before(xor_);
                    cmp->RAUW(xor_);
                    Should_del = true;
                    break;
                }
            }
            if (!Should_del)
                IncomeCmps.push_back(cmp);
            else
            {
                cmp->ClearRelation();
                cmp->EraseFromParent();
                modified |= true;
            }
        }
    }
    return modified;
}

bool BranchRotate::AdjustCondition()
{
    bool modified = false;
    std::unordered_set<BasicBlock *> wait_del;
    for (BasicBlock *block : DFSOrder)
    {
        if (wait_del.count(block))
            continue;
        User *br = block->back();
        if (dynamic_cast<CondInst *>(br))
        {
            if (Handle_And(block, br->Getuselist()[1]->usee->as<BasicBlock>(), wait_del))
                modified = true;
            else if (Handle_Or(block, br->Getuselist()[2]->usee->as<BasicBlock>(), wait_del))
                modified = true;
        }
    }
    while (!wait_del.empty())
    {
        BasicBlock *block = *wait_del.begin();
        wait_del.erase(block);
        delete block;
    }
    return modified;
}

bool BranchRotate::Handle_Or(BasicBlock *cur, BasicBlock *succ, std::unordered_set<BasicBlock *> &wait_del)
{
    bool modified = false;
    assert((cur->back()->Getuselist()[1]->usee == succ) ||
           (cur->back()->Getuselist()[2]->usee == succ) && "Error: Neither of the succ is succ_in.");
    auto Cur_Cond = dynamic_cast<CondInst *>(cur->back());
    auto Succ_Cond = dynamic_cast<CondInst *>(succ->back());
    if (Cur_Cond && Succ_Cond)
    {
        Value *cond1 = Cur_Cond->Getuselist()[0]->usee;
        Value *cond2 = Succ_Cond->Getuselist()[0]->usee;
        if (Cur_Cond->Getuselist()[1]->usee == Succ_Cond->Getuselist()[1]->usee && !DetectCall(cond2, succ))
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

bool BranchRotate::Handle_And(BasicBlock *cur, BasicBlock *succ, std::unordered_set<BasicBlock *> &wait_del)
{
    bool modified = false;
    assert((cur->back()->Getuselist()[1]->usee == succ) ||
           (cur->back()->Getuselist()[2]->usee == succ) && "Error: Neither of the succ is succ_in.");
    auto Cur_Cond = dynamic_cast<CondInst *>(cur->back());
    auto Succ_Cond = dynamic_cast<CondInst *>(succ->back());
    if (Cur_Cond && Succ_Cond)
    {
        Value *cond1 = Cur_Cond->Getuselist()[0]->usee;
        Value *cond2 = Succ_Cond->Getuselist()[0]->usee;
        if (Cur_Cond->Getuselist()[2]->usee == Succ_Cond->Getuselist()[2]->usee && !DetectCall(cond2, succ))
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

bool BranchRotate::DetectCall(Value *val, BasicBlock *block)
{
    if (!dynamic_cast<User *>(val))
        return false;
    auto user = dynamic_cast<User *>(val);
    if (user->GetParent() != block)
        return false;
    if (dynamic_cast<CallInst *>(val))
        return true;
    for (int i = 0; i < user->Getuselist().size(); i++)
    {
        if (DetectCall(user->GetOperand(i), block))
            return true;
    }
    return false;
}