#pragma once
#include "../../include/backend/RISCVContext.hpp"
#include "../../include/backend/RISCVMIR.hpp"
#include "../../include/backend/RISCVMOperand.hpp"
#include "../../include/backend/RISCVRegister.hpp"
#include "../../include/backend/RISCVType.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../util/my_stl.hpp"
#include "../../include/backend/Liveness.hpp"
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
      : m_func(func), ctx(_ctx) {
    m_func = ctx.GetCurFunction();
  }
  void RunGCpass();

protected:
  std::vector<PhyRegister *> float_available;
  std::vector<PhyRegister *> int_available;
  RISCVFunction *m_func;
  GraphColor *gc;
  int availble;
};
using MOperand = Register *;
class GraphColor : public LiveInterval {
public:
  RISCVLoweringContext &ctx;
  RISCVFunction *m_func;
  using Interval = LiveInterval::RegLiveInterval;
  using IntervalLength = unsigned int;
  GraphColor(RISCVFunction *func, RISCVLoweringContext &_ctx)
      : LiveInterval(func), ctx(_ctx), m_func(func) {}
  void RunOnFunc();

private:
  /// @brief 初始化各个工作表
  void MakeWorklist();
  // 返回vector为0则不是move相关
  std::unordered_set<RISCVMIR *> MoveRelated(MOperand v);
  void CalcmoveList(RISCVBasicBlock *block);
  void CalcIG(RISCVMIR *inst);
  void New_CalcIG(MOperand u, MOperand v);
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
  void CaculateSpillLiveness();
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
  std::vector<MOperand> SpillStack;
  // 保证Interval vector的顺序
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
  // 源操作数和目标操作数冲突的传送指令集合
  std::unordered_set<RISCVMIR *> constrainedMoves;
  // 已经合并的传送指令集合
  std::vector<RISCVMIR *> coalescedMoves;
  // 不再考虑合并的传送指令集合
  std::unordered_set<RISCVMIR *> frozenMoves;
  // 已成功着色的结点集合
  std::unordered_set<MOperand> coloredNode;
  // 从图中删除的临时变量的栈
  std::vector<MOperand> selectstack;
  // 查询每个传送指令属于哪一个集合
  std::unordered_map<RISCVMIR *, MoveState> belongs;
  // 还未做好准备的传送指令集合
  std::unordered_set<RISCVMIR *> activeMoves;
  // 合并后的别名管理
  std::unordered_map<MOperand, MOperand> alias;
  std::unordered_map<PhyRegister *, RISCVType> RegType;
  // 记录已经重写的spill node
  //  std::unordered_map<VirRegister *, RISCVMIR *> AlreadySpill;
  std::vector<RISCVBasicBlock *> topu;
  std::set<RISCVBasicBlock *> assist;
  std::unordered_map<MOperand, int> SpillToken;
  float LoopWeight = 1;
  float livenessWeight = 2.5;
  float DegreeWeight = 3;
  float SpillWeight = 5;
};