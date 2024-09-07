#pragma once
#include <algorithm>
#include <cassert>
#include <set>
#include <vector>

#include "dominant.hpp"
#include "../opt/PassManagerBase.hpp"
#include "../../lib/CFG.hpp"
#include "../../../util/my_stl.hpp"

struct LoopTrait {
  BasicBlock *head = nullptr;
  Value *boundary = nullptr;
  Value *initial = nullptr;
  int step = 0;
  PhiInst *indvar = nullptr; // eg: i++
  User *change = nullptr;
  PhiInst *res = nullptr;
  CallInst *call = nullptr; // result
  BinaryInst *cmp = nullptr;
  bool CmpEqual = false;
  void Init() {
    head = nullptr;
    boundary = nullptr;
    initial = nullptr;
    step = 0;
    indvar = nullptr; // eg: i++
    change = nullptr;
    res = nullptr;
    call = nullptr; // result
    CmpEqual = false;
  }
};

class LoopInfo {
public:
  friend class LoopAnalysis;
  using iterator = std::vector<LoopInfo *>::const_iterator;
  using reverse_iterator = std::vector<LoopInfo *>::const_reverse_iterator;
  LoopInfo() = default;
  LoopInfo(BasicBlock *_Header) : Header(_Header) {
    ContainBlocks.push_back(_Header);
  }
  void setHeader(BasicBlock *bb) { Header = bb; }
  void setParent(LoopInfo *loop) { Parent = loop; }
  void setSubLoop(LoopInfo *sub) { SubLoops.push_back(sub); }
  void setPreHeader(BasicBlock *bb) { Pre_Header = bb; }
  void setLatch(BasicBlock *bb) {
    Latch = bb;
    InsertLoopBody(bb);
  }
  bool CantCalcTrait() {
    return (!trait.boundary) || (!trait.initial) || (!trait.indvar) ||
           (!trait.change);
  }
  void DeleteBlock(BasicBlock *bb) {
    auto iter = std::find(ContainBlocks.begin(), ContainBlocks.end(), bb);
    assert(iter != ContainBlocks.end());
    ContainBlocks.erase(iter);
  }
  BasicBlock *GetHeader() { return Header; }
  LoopInfo *GetParent() { return Parent; }
  int GetLoopDepth() { return LoopDepth; }
  int LoopBodyNum() { return ContainBlocks.size(); }
  void InsertLoopBody(BasicBlock *bb) { PushVecSingleVal(ContainBlocks, bb); }
  std::vector<BasicBlock *> &GetLoopBody() { return ContainBlocks; }
  std::vector<LoopInfo *> &GetSubLoop() { return SubLoops; }
  void AddLoopDepth(int depth) { LoopDepth += depth; }
  bool IsVisited() { return visited; }
  void setVisited(bool v) { visited = v; }
  bool Contain(BasicBlock *bb);
  bool Contain(LoopInfo *loop);
  iterator begin() { return SubLoops.begin(); }
  iterator end() { return SubLoops.end(); }
  reverse_iterator rbegin() { return SubLoops.rbegin(); }
  reverse_iterator rend() { return SubLoops.rend(); }
  void clear() {
    Latch = nullptr;
    Pre_Header = nullptr;
    Existing_Block = nullptr;
    LoopDepth = 0;
  }
  int RotateTimes = 0;
  LoopTrait trait;

private:
  BasicBlock *Header = nullptr;
  LoopInfo *Parent = nullptr; // subloop --> loop
  /*will be used in LoopSimplify Pass*/
  BasicBlock *Latch = nullptr;
  BasicBlock *Pre_Header = nullptr;
  BasicBlock *Existing_Block = nullptr;
  std::vector<BasicBlock *> ContainBlocks;
  std::vector<LoopInfo *> SubLoops;
  int LoopDepth = 0;    //嵌套深度
  bool visited = false; //辅助
};

class LoopAnalysis : public _AnalysisManagerBase<LoopAnalysis, Function> {
public:
  enum Flag {
    Strict,
    Loose,
  };
  using iterator = std::vector<LoopInfo *>::const_iterator;
  using reverse_iterator = std::vector<LoopInfo *>::const_reverse_iterator;
  LoopAnalysis(Function *func, dominance *dom,
               std::vector<LoopInfo *> &DeleteLoop)
      : m_func(func), m_dom(dom), _DeleteLoop(DeleteLoop) {
    setBBs();
    setDest();
  }
  void Analysis();
  bool IsLoopIncludeBB(LoopInfo *loop, int index);
  bool IsLoopIncludeBB(LoopInfo *loop, BasicBlock *bb);
  bool IsLoopExiting(LoopInfo *loop, BasicBlock *bb);
  BasicBlock *GetLatch(LoopInfo *loop);
  BasicBlock *GetPreHeader(LoopInfo *loopinfo, Flag f = Strict);
  std::vector<BasicBlock *> GetExitingBlock(LoopInfo *loopinfo);
  std::vector<BasicBlock *> GetExit(LoopInfo *loopinfo);
  void setBBs() { bbs = &(m_func->GetBasicBlock()); }
  void setDest() { Dest = &(m_dom->GetDest()); }
  void PostOrderDT(int entry);
  LoopInfo *LookUp(BasicBlock *bb);
  void setLoop(BasicBlock *bb, LoopInfo *loop);
  BasicBlock *FindLoopHeader(BasicBlock *bb);
  void CalculateLoopDepth(LoopInfo *loop, int depth);
  void LoopAnaly();
  void CloneToBB();
  void ExpandSubLoops();
  void DeleteLoop(LoopInfo *loop);
  void DeleteBlock(BasicBlock *bb);
  void ReplBlock(BasicBlock *Old, BasicBlock *New);
  std::vector<LoopInfo *> GetLoops() { return LoopRecord; }
  bool CanBeOpt() { return LoopRecord.size() != 0; }
  static bool IsLoopInvariant(const std::set<BasicBlock *> &contain, User *I,
                              LoopInfo *curloop);
  // only for test
  void PrintPass();
  void *GetResult(Function *func) {
    m_func->init_visited_block();
    BasicBlock *entry = m_func->front();
    PostOrderDT(entry->num);
    Analysis();
    ExpandSubLoops();
    LoopAnaly();
    CloneToBB();
    std::sort(LoopRecord.begin(), LoopRecord.end(),
              [](const auto &a1, const auto &a2) {
                return a1->LoopDepth > a2->LoopDepth;
              });
    AlreadyGetInfo = true;
    return this;
  }
  BasicBlock *GetCorrespondBlock(int i) { return (*bbs)[i]; }
  iterator begin() { return LoopRecord.begin(); }
  iterator end() { return LoopRecord.end(); }
  reverse_iterator rbegin() { return LoopRecord.rbegin(); }
  reverse_iterator rend() { return LoopRecord.rend(); }

  ~LoopAnalysis() = default;
  std::vector<LoopInfo *> &_DeleteLoop;

private:
  Function *m_func;
  dominance *m_dom;
  std::vector<BasicBlock *> *bbs;      //提供num to bb map
  std::vector<std::vector<int>> *Dest; // CFG中的后继
  std::vector<BasicBlock *> PostOrder;
  std::vector<LoopInfo *> LoopRecord; //保证了嵌套层数越高，越靠前
  std::map<BasicBlock *, LoopInfo *> Loops;
  bool AlreadyGetInfo = false;
  int index = 0;
};
