#include "CFG.hpp"
#include "LoopInfo.hpp"
#include "dominant.hpp"
class Inline : public dominance
{
public:
    void RunOnFunction();
    void PrintPass();
    Inline(Function* f, int num) : func(f), dominance(f, num){}
private:
    int BlockNum;
    Function* func;
    void RemoveDeadFunction(Function* func);
    void inlineCalls(CallInst* call);
    bool shouldInline(CallInst* call);
    std::stack<CallInst*> callStack;
};


class CallGraph:public Module
{
public: 
    CallGraph()=default;
};

class CallGraphNode
{
    Function* F;
    /// @brief A pair of callinst and call graph node
    typedef std::pair<CallInst*, CallGraphNode*> CallRecord;
    
    /// @brief Record Vector to store CalledFunctions
    typedef std::vector<CallRecord> CalledFuncsVector;

        std::vector<CallRecord> CalledFunctions;
    public:
        CallGraphNode(Function* F) : F(F) {}

        typedef std::vector<CallRecord>::iterator iterator;
        
        Function* getFunc() const { return F; }

        iterator begin() { return CalledFunctions.begin(); }
        iterator end() { return CalledFunctions.end(); }
        std::reverse_iterator<iterator> rbegin() { return CalledFunctions.rbegin(); }
        std::reverse_iterator<iterator> rend() { return CalledFunctions.rend(); }

        bool is_empty() const { return CalledFunctions.empty(); }
        unsigned size() const { return (unsigned)CalledFunctions.size(); }

        CallGraphNode* operator[](unsigned i) const;

        void removeAllCalledFunctions();

        void MoveCallFuncFrom(CallGraphNode *Node);

        void AddCallFunc();
};