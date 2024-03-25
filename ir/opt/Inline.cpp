#include "Inline.hpp"

CallGraphNode* CallGraphNode::operator[](unsigned i) const
{   
    assert(i < CalledFunctions.size() && "Invalid index");
    return CalledFunctions[i].second; 
}

void CallGraphNode::removeAllCalledFunctions()
{
    while(!CalledFunctions.empty())
    {
        // TODO 计数器
        CalledFunctions.pop_back();
    }
}

void CallGraphNode::MoveCallFuncFrom(CallGraphNode *Node)
{
    assert(CalledFunctions.empty() && "Cannot Move");
    std::swap(CalledFunctions, Node->CalledFunctions);
}

void CallGraphNode::AddCallFunc(CallInst* inst)
{
    CalledFunctions.emplace_back( \
        std::make_pair(inst, CallGraphNode \
        (dynamic_cast<Function*>(inst->Getuselist()[0]->usee))));
}

void CallGraphNode::DelCallEdge(iterator iter)
{

}

CallGraphNode* CallGraph::operator[](Function* func)
{
    const_iterator iter = FunctionMap.find(func);
    assert(iter != FunctionMap.end() && "Function not in CallGraph!");
    return iter->second.get();
}

Function* CallGraph::EraseFromModule(CallGraphNode* node)
{
    assert(node->is_empty() && "Cannot erase function from module!");
    Function* F = node->getFunc();
    FunctionMap.erase(F);
    M.EraseFunction(F);
    return F;
}

void CallGraphSCC::ReplaceNode(CallGraphNode* Old, CallGraphNode* New)
{
    assert(Old != New && "Should not replace node with self!");
    for(unsigned i = 0 ; ; ++i)
    {
        assert(i != Nodes.size() && "Node not in SCC!");
        if(Nodes[i] != Old)
            continue;
        Nodes[i] = New;
        break;
    }
    //todo update
}

void Inline::PrintPass()
{
    std::cout << "--------Inline--------" << std::endl;
    Singleton<Module>().Test();
}

void Inline::RunOnFunction()
{

}
/*
CallInst use: vector{Func, arges} for(int i = 1 ; i < vector.size() ; i++)
*/
