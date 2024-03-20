#pragma once
#include "dominant.hpp"
#include "passManagerBase.hpp"

class LoopInfo {
public:
  LoopInfo() = default;
  LoopInfo(BasicBlock* _Header):Header(_Header){}
  void setHeader(BasicBlock *bb) { Header = bb; }
  void setTail(BasicBlock *bb) { Tail = bb; }
  void setParent(LoopInfo *loop) { Parent = loop; }
  BasicBlock *GetHeader() { return Header; }
  BasicBlock *GetTail() { return Tail; }
  LoopInfo *GetParent() { return Parent; }
  
private:
  BasicBlock *Header;
  BasicBlock *Tail;
  LoopInfo *Parent;
  std::vector<BasicBlock *> ContainBlocks;
  std::vector<BasicBlock *> ContainSubLoops;
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
  //LoopInfo* 
  void FindLoopHeader();
  void FindLoopTail();
  // only for test
  void PrintPass(){};
  void RunOnFunction() {
    m_func->init_visited_block();
    BasicBlock *entry = m_func->front();
    PostOrderDT(entry->num);
    Analysis();
    AlreadyGetInfo = true;
  }
  BasicBlock *GetCorrespondBlock(int i) { return (*bbs)[i]; }

private:
  Function *m_func;
  dominance *m_dom;
  std::vector<BasicBlock *> *bbs;      //提供num to bb map
  std::vector<std::vector<int>> *Dest; // CFG中的后继
  std::vector<BasicBlock *> PostOrder;
  std::vector<LoopInfo *> Loops;
  bool AlreadyGetInfo = false;
  int index = 0;
};
