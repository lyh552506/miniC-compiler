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
