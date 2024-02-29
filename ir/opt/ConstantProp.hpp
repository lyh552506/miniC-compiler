#include "ConstantFold.hpp"

class ConstantProp
{
    // 沿dominant tree 从 entry 开始按BFS顺序遍历BasicBlock
    void bfsTraversal(Function* func, dominance& dom);

    bool isConstantAssignment(User* inst); //如果是常量赋值或者常量计算的结果

    bool isBranchAndConstPredicate(User* inst); //如果是常量值的分支条件
    void changeCondBranchToAbsBranchAndMark(User* inst); //替换为强制跳转，并标记另一个分支不可达
    bool isPhi(User* inst){return dynamic_cast<PhiInst*>(inst);};
    bool isOneBlockUnreachable(User* inst); //有一个基本块不可达
    bool IsSameValPre(User* inst); //两个基本块的值相同
    void propPhiToRef(User* inst); //将可达块的值传播到对该指令的引用
    void RunOnFunc(Function* func);
    void RunOnBlock(BasicBlock* block);

    void propConstToRef(User* inst); //用常量值替换该变量的所有引用

private:
    bool changed = false;

public:
    void Pass(Function* func, dominance* dom);
};
