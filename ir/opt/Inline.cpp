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

void CallGraphNode::AddCallFunc()
{
    
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
