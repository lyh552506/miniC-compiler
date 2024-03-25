#pragma once
#include "dominant.hpp"
#include "PassManagerBase.hpp"

class LoopInfo {
public:
  LoopInfo() = default;
  LoopInfo(BasicBlock *_Header) : Header(_Header) {
    ContainBlocks.push_back(_Header);
  }
  void setHeader(BasicBlock *bb) { Header = bb; }
  void setParent(LoopInfo *loop) { Parent = loop; }
  void setSubLoop(LoopInfo *sub) { SubLoops.push_back(sub); }
  BasicBlock *GetHeader() { return Header; }
  LoopInfo *GetParent() { return Parent; }
  int GetLoopDepth(){return LoopDepth;}
  int LoopBodyNum() { return ContainBlocks.size(); }
  void InsertLoopBody(BasicBlock *bb) { ContainBlocks.push_back(bb); }
  const std::vector<BasicBlock *> &GetLoopBody() { return ContainBlocks; }
  const std::vector<LoopInfo *> &GetSubLoop() { return SubLoops; }
  void AddLoopDepth(int depth) { LoopDepth += depth; }
  bool IsVisited(){return visited;}
  void setVisited(bool v){visited=v;}
private:
  BasicBlock *Header = nullptr;
  LoopInfo *Parent = nullptr; // subloop --> loop
  std::vector<BasicBlock *> ContainBlocks;
  std::vector<LoopInfo *> SubLoops;
  int LoopDepth = 0; //嵌套深度
  bool visited=false; //辅助
};

class LoopAnalysis : public PassManagerBase {
public:
  LoopAnalysis(Function *func, dominance *dom) : m_func(func), m_dom(dom) {
    setBBs();
    setDest();
  }
  void Analysis();
  void setBBs() { bbs = &(m_func->GetBasicBlock()); }
  void setDest() { Dest = &(m_dom->GetDest()); }
  void PostOrderDT(int entry);
  LoopInfo *LookUp(BasicBlock *bb);
  void setLoop(BasicBlock *bb, LoopInfo *loop);
  BasicBlock *FindLoopHeader(BasicBlock *bb);
  void CalculateLoopDepth(LoopInfo* loop,int depth);
  void LoopAnaly();
  // only for test
  void PrintPass();
  void RunOnFunction() {
    m_func->init_visited_block();
    BasicBlock *entry = m_func->front();
    PostOrderDT(entry->num);
    Analysis();
    LoopAnaly();
    AlreadyGetInfo = true;
  }
  BasicBlock *GetCorrespondBlock(int i) { return (*bbs)[i]; }
  ~LoopAnalysis(){
    for(auto i:LoopRecord)
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
