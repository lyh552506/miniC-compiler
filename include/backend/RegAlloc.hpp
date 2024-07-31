#pragma once
#include "../../include/backend/RISCVContext.hpp"
#include "../../include/backend/RISCVMIR.hpp"
#include "../../include/backend/RISCVMOperand.hpp"
#include "../../include/backend/RISCVRegister.hpp"
#include "../../include/backend/RISCVType.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../util/my_stl.hpp"
#include "BaseCFG.hpp"
#include <algorithm>
#include <cmath>
#include <list>
#include <map>
#include <queue>
#include <set>
#include <stack>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

class GraphColor;
class RegAllocImpl {
  RISCVLoweringContext &ctx;

public:
  RegAllocImpl(RISCVFunction *func, RISCVLoweringContext &_ctx)
      : m_func(func), ctx(_ctx) {}
  void RunGCpass();
  struct RegLiveInterval {
    int start;
    int end;
    bool operator<(const RegLiveInterval &other) const {
      return start < other.start;
    }
  };

protected:
  std::vector<PhyRegister *> float_available;
  std::vector<PhyRegister *> int_available;
  RISCVFunction *m_func;
  GraphColor *gc;
  int availble;
};
using MOperand = Register *;
class BlockLiveInfo {
private:
  void GetBlockLivein(RISCVBasicBlock *block);
  void GetBlockLiveout(RISCVBasicBlock *block);
  RISCVFunction *m_func;

public:
  void CalCulateSucc(RISCVBasicBlock *block);
  std::unordered_map<RISCVBasicBlock *, std::list<RISCVBasicBlock *>>
      SuccBlocks;
  std::unordered_map<RISCVBasicBlock *, std::unordered_set<MOperand>>
      BlockLivein;
  std::unordered_map<RISCVBasicBlock *, std::unordered_set<MOperand>>
      BlockLiveout;
  std::unordered_map<RISCVMIR *, std::unordered_set<MOperand>> InstLive;
  // 机器寄存器的集合，每个寄存器都预先指派了一种颜色
  std::unordered_set<MOperand> Precolored; // reg
                                           //算法最后为每一个operand选择的颜色
  std::unordered_map<MOperand, PhyRegister *> color;
  // 从一个结点到与该节点相关的传送指令表的映射
  std::unordered_map<MOperand, std::unordered_set<RISCVMIR *>>
      moveList; // reg2mov
                // interference graph
  std::unordered_map<MOperand, std::unordered_set<MOperand>> TmpIG;
  std::unordered_map<MOperand, std::vector<MOperand>>
      IG; // reg2reg IG[op]
          // 有可能合并的传送指令
  std::vector<RISCVMIR *> worklistMoves;
  // 图中冲突边(u,v)的集合。如果 (u,v)\in adjset, 那 (v,u) \in adjset
  std::unordered_map<MOperand, std::unordered_set<MOperand>> adjSet;
  // 临时寄存器集合，其中的元素既没有预着色，也没有被处理
  std::unordered_set<MOperand> initial;
  std::unordered_map<MOperand, std::unordered_set<MOperand>> AdjList;
  std::unordered_map<MOperand, int> Degree;
  RegisterList &reglist;
  void RunOnFunction();
  void PrintPass();
  void PrintEdge();
  void Build();
  void AddEdge(Register *u, Register *v);
  bool count(MOperand Op, RISCVMIR *inst) { return InstLive[inst].count(Op); }
  bool Count(Register *op);
  BlockLiveInfo(RISCVFunction *f)
      : m_func(f), BlockLivein{}, BlockLiveout{}, InstLive{},
        reglist(RegisterList::GetPhyRegList()) {}
};
class LiveInterval : public BlockLiveInfo {
  using Interval = RegAllocImpl::RegLiveInterval;
  RISCVFunction *func;

public:
  std::unordered_map<RISCVMIR *, int> instNum;
  std::unordered_map<RISCVBasicBlock *, BlockLiveInfo *> BlockInfo;
  std::map<RISCVBasicBlock *,
           std::unordered_map<MOperand, std::vector<Interval>>>
      RegLiveness;

private:
  void init();
  void computeLiveIntervals();

  bool verify(std::unordered_map<MOperand, std::vector<Interval>> Liveinterval);

public:
  LiveInterval(RISCVFunction *f) : func(f), BlockLiveInfo(f) {}
  std::unordered_map<MOperand, std::vector<Interval>> &
  GetRegLiveInterval(RISCVBasicBlock *block) {
    return RegLiveness[block];
  }
  void RunOnFunc_();
  void PrintAnalysis();
};
class GraphColor : public LiveInterval {
public:
  RISCVLoweringContext &ctx;
  RISCVFunction *m_func;
  using Interval = RegAllocImpl::RegLiveInterval;
  using IntervalLength = unsigned int;
  GraphColor(RISCVFunction *func, RISCVLoweringContext &_ctx)
      : LiveInterval(func), ctx(_ctx), m_func(func) {}
  void RunOnFunc();

private:
  /// @brief 初始化各个工作表
  void MakeWorklist();
  //返回vector为0则不是move相关
  std::unordered_set<RISCVMIR *> MoveRelated(MOperand v);
  void CalcmoveList(RISCVBasicBlock *block);
  void CalcIG(RISCVMIR *inst);
  void CalInstLive(RISCVBasicBlock *block);
  void CaculateLiveness();
  void CaculateLiveInterval(RISCVBasicBlock *mbb);
  void simplify();
  void coalesce();
  void freeze();
  void spill();
  void AssignColors();
  void SpillNodeInMir();
  void RewriteProgram();
  void CaculateTopu(RISCVBasicBlock *mbb);
  void DecrementDegree(MOperand target);
  MOperand HeuristicFreeze();
  MOperand HeuristicSpill();
  PhyRegister *SelectPhyReg(MOperand vreg, RISCVType ty,
                            std::unordered_set<MOperand> &assist);
  bool GeorgeCheck(MOperand dst, MOperand src, RISCVType ty);
  bool BriggsCheck(MOperand dst, MOperand src, RISCVType ty);
  void AddWorkList(MOperand v);
  void combine(MOperand rd, MOperand rs);
  MOperand GetAlias(MOperand v);
  void FreezeMoves(MOperand freeze);
  void SetRegState(PhyRegister *reg, RISCVType ty);
  int GetRegNums(MOperand v);
  int GetRegNums(RISCVType ty);
  void GC_init();
  void LiveInfoInit();
  std::set<MOperand> Adjacent(MOperand);
  RISCVMIR *CreateSpillMir(RISCVMOperand *spill,
                           std::unordered_set<VirRegister *> &temps);
  RISCVMIR *CreateLoadMir(RISCVMOperand *load,
                          std::unordered_set<VirRegister *> &temps);
  void Print();
  //保证Interval vector的顺序
  std::unordered_map<MOperand, IntervalLength> ValsInterval;
  enum MoveState { coalesced, constrained, frozen, worklist, active };
  // 低度数的传送有关节点表
  std::unordered_set<MOperand> freezeWorkList;
  // 低度数的传送无关节点表
  std::vector<MOperand> simplifyWorkList;
  // 高度数的节点表
  std::unordered_set<MOperand> spillWorkList;
  // 本轮中要溢出的节点集合
  std::unordered_set<MOperand> spilledNodes;
  // 已合并的寄存器集合，当合并u<--v，将v加入到这个集合中，u则被放回到某个工作表中(或反之)
  std::unordered_set<MOperand> coalescedNodes;
  //源操作数和目标操作数冲突的传送指令集合
  std::unordered_set<RISCVMIR *> constrainedMoves;
  //已经合并的传送指令集合
  std::vector<RISCVMIR *> coalescedMoves;
  //不再考虑合并的传送指令集合
  std::unordered_set<RISCVMIR *> frozenMoves;
  //已成功着色的结点集合
  std::unordered_set<MOperand> coloredNode;
  // 从图中删除的临时变量的栈
  std::vector<MOperand> selectstack;
  //查询每个传送指令属于哪一个集合
  std::unordered_map<RISCVMIR *, MoveState> belongs;
  // 还未做好准备的传送指令集合
  std::unordered_set<RISCVMIR *> activeMoves;
  //合并后的别名管理
  std::unordered_map<MOperand, MOperand> alias;
  std::unordered_map<PhyRegister *, RISCVType> RegType;
  //记录已经重写的spill node
  std::unordered_map<VirRegister *, RISCVMIR *> AlreadySpill;
  std::vector<RISCVBasicBlock *> topu;
  std::set<RISCVBasicBlock *> assist;
  float LoopWeight = 1;
  float livenessWeight = 2;
  float DegreeWeight = 1;
};