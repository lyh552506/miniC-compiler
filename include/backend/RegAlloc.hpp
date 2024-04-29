// #pragma once
// #include <algorithm>
// #include <list>
// #include <map>
// #include <queue>
// #include<cmath>
// #include <stack>
// #include <string>
// #include <unordered_map>
// #include <unordered_set>
// #include <vector>
// #include"my_stl.hpp"
// #include "BaseCFG.hpp"
// #include "CFG.hpp"
// #include "MachineCode.hpp"
// #include "Mcode.hpp"

// class GraphColor;
// class RegInfo {
//  public:
//   enum REG {
//     r0,
//     r1,
//     r2,
//     r3,
//     r4,
//     r5,
//     r6,
//     r7,
//     r8,
//     r9,
//     r10,
//     r11,
//     r12,
//     r13,
//     r14,
//     r15,
//     r16,
//     r17,
//     r18,
//     r19,
//     r20,
//     r21,
//   };
//   REG name;
// };

// class RegAllocImpl {
//  public:
//   RegAllocImpl(MachineFunction* func) : m_func(func) {}
//   void RunGCpass();
//   struct RegLiveInterval {
//     int start;
//     int end;
//     bool operator<(const RegLiveInterval& other) const {
//       return start < other.start;
//     }
//   };
//  protected:
//   std::vector<RegInfo> avail;
//   MachineFunction* m_func;
//   GraphColor* gc;
//   int availble;
// };

// class GraphColor {
//  public:
//   friend class BlockLiveInfo;
//   using Interval = RegAllocImpl::RegLiveInterval;
//   using IntervalLength = unsigned int;
//   GraphColor(MachineFunction* func, int K) : m_func(func), colors(K) {
//     blockinfo = std::make_unique<BlockLiveInfo>(m_func);
//     liveinterval = std::make_unique<LiveInterval>(m_func);
//   }
//   void RunOnFunc();
//   class BlockLiveInfo {
//    private:
//     void GetBlockLivein(MachineBasicBlock* block);
//     void GetBlockLiveout(MachineBasicBlock* block);
//     void iterate(MachineFunction* func);
//     void RunOnFunc(MachineFunction* func);
//     std::map<MachineBasicBlock*, bool> UnChanged;
//     bool isChanged = false;
//     MachineFunction* F;

//    public:
//     std::map<MachineBasicBlock*, std::unordered_set<Value*>>
//         Uses;  // block uses
//     std::map<MachineBasicBlock*, std::unordered_set<Value*>>
//         Defs;  // block defs
//     std::map<MachineBasicBlock*, std::set<Value*>> BlockLivein;
//     std::map<MachineBasicBlock*, std::set<Value*>> BlockLiveout;
//     std::map<MachineInst*, std::set<Value*>> InstLive;
//     void RunOnFunction();
//     void PrintPass();
//     bool count(Operand Op, MachineInst* inst) {
//       return InstLive[inst].count(Op);
//     }
//     BlockLiveInfo(MachineFunction* f)
//         : F(f), BlockLivein{}, BlockLiveout{}, InstLive{} {}
//   };

//   class LiveInterval {
//     MachineFunction* func;

//    protected:
//     std::unordered_map<MachineInst*, int> instNum;
//     std::unordered_map<MachineBasicBlock*, BlockLiveInfo*> BlockInfo;
//     std::map<MachineBasicBlock*,
//              std::unordered_map<Operand, std::vector<Interval>>>
//         RegLiveness;

//    private:
//     void init();
//     void computeLiveIntervals();

//     bool verify(
//         std::unordered_map<Operand, std::vector<Interval>> Liveinterval);
//     std::unique_ptr<BlockLiveInfo> blockinfo;

//    public:
//     LiveInterval(MachineFunction* f) : func(f) {}
//     std::unordered_map<Operand, std::vector<Interval>> GetRegLiveInterval(
//         MachineBasicBlock* block) {
//       return RegLiveness[block];
//     }
//     void RunOnFunc();
//     void PrintAnalysis();
//   };

//  private:
//   MachineFunction* m_func;
//   std::unique_ptr<BlockLiveInfo> blockinfo;
//   std::unique_ptr<LiveInterval> liveinterval;
//   //记录available的寄存器
//   int colors;
//   /// @brief 初始化各个工作表
//   void MakeWorklist();
//   //返回vector为0则不是move相关
//   std::unordered_set<MachineInst*> MoveRelated(Operand v);
//   void CalcmoveList(MachineBasicBlock* block);
//   void CalcIG(MachineBasicBlock* block);
//   void CalInstLive(MachineBasicBlock* block);
//   void CaculateLiveness(MachineBasicBlock* mbb);
//   void simplify();
//   void coalesce();
//   void freeze();
//   void spill();
//   void AssignColors();
//   void RewriteProgram();
//   Operand HeuristicFreeze();
//   Operand HeuristicSpill();
//   bool GeorgeCheck(Operand dst, Operand src);
//   bool BriggsCheck(std::unordered_set<Operand> target);
//   void AddWorkList(Operand v);
//   void combine(Operand rd, Operand rs);
//   Operand GetAlias(Operand v);
//   void FreezeMoves(Operand freeze);
//   //保证Interval vector的顺序
//   std::unordered_map<Operand, IntervalLength> ValsInterval;
//   enum MoveState { coalesced, constrained, frozen, worklist, active };
//   // interference graph
//   std::unordered_map<Operand, std::vector<Operand>> IG;  // reg2reg IG[op]
//   // 低度数的传送有关节点表
//   std::unordered_set<Operand> freezeWorkList;
//   // 有可能合并的传送指令
//   std::vector<MachineInst*> worklistMoves;
//   // 低度数的传送无关节点表
//   std::vector<Operand> simplifyWorkList;
//   // 高度数的节点表
//   std::unordered_set<Operand> spillWorkList;
//   // 本轮中要溢出的节点集合
//   std::unordered_set<Operand> spilledNodes;
//   // 机器寄存器的集合，每个寄存器都预先指派了一种颜色
//   std::unordered_set<Operand> Precolored;  // reg
//   // 临时寄存器集合，其中的元素既没有预着色，也没有被处理
//   std::unordered_set<Operand> initial;
//   // 已合并的寄存器集合，当合并u<--v，将v加入到这个集合中，u则被放回到某个工作表中(或反之)
//   std::unordered_set<Operand> coalescedNodes;
//   //源操作数和目标操作数冲突的传送指令集合
//   std::unordered_set<MachineInst*> constrainedMoves;
//   //已经合并的传送指令集合
//   std::vector<MachineInst*> coalescedMoves;
//   //不再考虑合并的传送指令集合
//   std::unordered_set<MachineInst*> frozenMoves;
//   //已成功着色的结点集合
//   std::unordered_set<Operand> coloredNode;
//   // 从图中删除的临时变量的栈
//   std::vector<Operand> selectstack;
//   //查询每个传送指令属于哪一个集合
//   std::unordered_map<MachineInst*, MoveState> belongs;
//   // 从一个结点到与该节点相关的传送指令表的映射
//   std::unordered_map<Operand, std::unordered_set<MachineInst*>>
//       moveList;  // reg2mov
//   // 还未做好准备的传送指令集合
//   std::unordered_set<MachineInst*> activeMoves;
//   //合并后的别名管理
//   std::unordered_map<Operand, Operand> alias;
//   //算法最后为每一个operand选择的颜色
//   std::unordered_map<Operand, RegInfo> color;
//   int LoopWeight = 1;
//   int livenessWeight = 1;
//   int DegreeWeight = 1;
// };
