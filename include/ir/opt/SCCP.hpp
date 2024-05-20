#include "CFG.hpp"
#include "dominant.hpp"
#include "ConstantFold.hpp"


/*
    关键结构：半格（ Lattice )
       T      (OverDefined , 重复定值)
    /  |  \
  c1  c2  c3 (Constant | ForcedConstant)
    \  |  /
       ⊥    (Unknown , 未被定值)
*/
class Lattice
{
    enum ValueStatus
    {
        Unknown,
        Constant,
        ForcedConstant,
        OverDefined
    };
    std::pair<Value*, ValueStatus> Val;
    ValueStatus GetValueStatus() const { return Val.second; }
public:
    Lattice() : Val(nullptr, Unknown) {}
    
    bool isUnknown() const { return GetValueStatus() == Unknown; }
    bool isConstant() const
    {
        return GetValueStatus() == Constant ||
        GetValueStatus() == ForcedConstant; 
    }
    bool isOverDefined() const { return GetValueStatus() == OverDefined; }
    
    Value* GetVal() const { return Val.first; }

    // MarkOverDefined - Return true if this is a change in status;
    bool MarkOverDefined();

    // MarkConstant - Return true if this is a change in status;
    bool MarkConstant(ConstantData* val);

    ConstantData* GetConstData() const;

    void MarkForcedConstant(ConstantData* val);
};

class SCCP
{
public:
    bool RunOnFunction(Function* func);
    SCCP() = default;
protected:
    std::set<BasicBlock*> ExecutableBlocks; // 可以执行的Block
    std::map<Value*, Lattice> ValueStatusMap; // Value -> Lattice

    // GlobalTrack - 如果我们要跟踪全局变量内容的任何值, \
    我们会保留一个从常量访问器到全局元素的映射，再到当前已知值的映射。\
    如果值变为OverDefined, 就会从该映射中删除其条目。
    std::map<Variable*, Lattice> GlobalTrack;

    // RetValTrack - 如果我们要跟踪一个函数的参数输入和返回值输出，\
    那么这个映射表中就会有一个条目，说明函数的已知返回值是多少。
    std::map<Function*, Lattice> RetValTrack;

    // MultipleRetValsTrack - 与 RetValTrack 相同，\
    但用于返回多个值的函数。
    std::map<std::pair<Function*, int>, Lattice> MultipleRetValsTrack;

    // IncomeArgsTrack - 如果我们要跟踪一个函数的参数输入，\
    我们对其参数做出乐观假设，并试图将其证明为常数。 
    std::set<Function*> IncomeArgsTrack;

    // ValueWorkList - 变量WorkList
    // BlockWorkList - 基本块WorkList
    // OverDefinedWorkList - OverDefined WorkList \
    因为 OverDefined 是 Lattice 上的最低状态, \
    尽可能快地移动到 OverDefined 能让 SCCP 更快地收敛。

    std::vector<Value*> ValueWorkList;
    std::vector<BasicBlock*> BlockWorkList;
    std::vector<Value*> OverDefinedWorkList;

    // KnownFeasibleEdges - 已知可行边该集合中的 \
    元素是已经重新触发 Phi 节点的边。
    typedef std::pair<BasicBlock*, BasicBlock*> Edge;
    std::set<Edge> KnownFeasibleEdges;

private:
    bool SolveUndefs(Function* func);
    bool ReSolvedUndef(User* inst);
    // Solve - 求解常量和可执行块
    void Solve();
    bool isExcutableBlock(BasicBlock* block){ return ExecutableBlocks.count(block); }

    bool TryReplace(Value* val);

    void Visit(User* inst);
    // MarkBlockExecutable - 将基本块标记为可执行
    bool MarkBlockExecutable(BasicBlock* block);

    // TrackGlobal - 跟踪加载和存储到指定的全局变量.
    void TrackGlobal(Variable* val);

    Lattice GetLattice(Value* val) const;

    // MarkConstant / MarkForcedConstant - 将一个值标记为 Constant / ForcedConstant。\
    如果该值还不是常量, 则将其添加到ValueWorkList中, 以便稍后更新指令 的 user。
    void MarkConstant(Lattice& L, Value* val, ConstantData* C);
    void MarkForcedConstant(Value* val, ConstantData* C);
    
    // MarkOverDefined - 将一个值标记为 OverDefined。如果该值不是 OverDefined, \
    则将其添加到OverDefinedWorkLIst中, 以便稍后更新该指令的 User。
    void MarkOverDefined(Lattice& L, Value* val);

    // MergeInValue - 将一个值合并到另一个值中。\
    L    Merged   Result \
    T      []      X     \
    []     ⊥       X     \
    []     T        T     \
    ⊥     const   const   \
  const1  const2 overdefined
    void MergeInValue(Lattice& L, Value* val, Lattice Merged);

    Lattice& GetValueStatus(Value* val);

    void MarkEdgeExcutable(BasicBlock* Src, BasicBlock* Dst);

    bool isEdgeExcutable(BasicBlock* Src, BasicBlock* Dst);
    void GetExcutableSuccs(CondInst* inst, std::vector<bool>& Succs);
    void GetExcutableSuccs(UnCondInst* inst, std::vector<bool>& Succs);


private:
    void VisitPhiInst(PhiInst* inst);
    //Terminators
    void VisitCondInst(CondInst* inst);
    void VisitUnCondInst(UnCondInst* inst);
    void VisitReturnInst(RetInst* inst);

    void VisitBinaryOperator(BinaryInst* inst);
    void VisitCmpInst(BinaryInst* inst);

    // Instructions that cannot be folded away.
    void VisitStoreInst(StoreInst* inst);
    void VisitLoadInst(LoadInst* inst);
    void VisitGetElementPtrInst(GetElementPtrInst* inst);
    void VisitCallInst(CallInst* inst);
    void VisitAllocaInst(AllocaInst* inst) { MarkOverDefined(GetValueStatus(inst), inst); }
};