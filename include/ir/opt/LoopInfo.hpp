#pragma once
#include <vector>

#include "CFG.hpp"
#include "PassManagerBase.hpp"
#include "dominant.hpp"
#include "my_stl.hpp"

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
  BasicBlock *GetHeader() { return Header; }
  LoopInfo *GetParent() { return Parent; }
  int GetLoopDepth() { return LoopDepth; }
  int LoopBodyNum() { return ContainBlocks.size(); }
  void InsertLoopBody(BasicBlock *bb) { PushVecSingleVal(ContainBlocks, bb); }
  const std::vector<BasicBlock *> &GetLoopBody() { return ContainBlocks; }
  const std::vector<LoopInfo *> &GetSubLoop() { return SubLoops; }
  void AddLoopDepth(int depth) { LoopDepth += depth; }
  bool IsVisited() { return visited; }
  void setVisited(bool v) { visited = v; }
  bool Contain(BasicBlock* bb);
  bool Contain(LoopInfo* loop);
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

class LoopAnalysis : public PassManagerBase {
public:
  using iterator = std::vector<LoopInfo *>::const_iterator;
  using reverse_iterator = std::vector<LoopInfo *>::const_reverse_iterator;
  LoopAnalysis(Function *func, dominance *dom) : m_func(func), m_dom(dom) {
    setBBs();
    setDest();
  }
  void Analysis();
  bool IsLoopIncludeBB(LoopInfo *loop, int index);
  bool IsLoopIncludeBB(LoopInfo *loop, BasicBlock *bb);
  BasicBlock *GetLatch();
  BasicBlock *GetPreHeader(LoopInfo *loopinfo);
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
  // only for test
  void PrintPass();
  void RunOnFunction() {
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
    _DEBUG(PrintPass();)
  }
  BasicBlock *GetCorrespondBlock(int i) { return (*bbs)[i]; }
  iterator begin() { return LoopRecord.begin(); }
  iterator end() { return LoopRecord.end(); }
  reverse_iterator rbegin() { return LoopRecord.rbegin(); }
  reverse_iterator rend() { return LoopRecord.rend(); }
  ~LoopAnalysis() {
    for (auto i : LoopRecord)
      delete i;
  }

private:
  Function *m_func;
  dominance *m_dom;
  std::vector<BasicBlock *> *bbs;      //提供num to bb map
  std::vector<std::vector<int>> *Dest; // CFG中的后继
  std::vector<BasicBlock *> PostOrder;
  std::vector<LoopInfo *> LoopRecord;
  std::map<BasicBlock *, LoopInfo *> Loops;
  bool AlreadyGetInfo = false;
  int index = 0;
};
