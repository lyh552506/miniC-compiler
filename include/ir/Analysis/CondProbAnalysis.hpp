#pragma once
#include "../../include/ir/opt/New_passManager.hpp"
#include "../../include/ir/opt/PassManagerBase.hpp"
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include <vector>

struct ProbEdge {
  BasicBlock *Out;
  BasicBlock *In;
  double Prob;
};

class ProbAnalysis : public _AnalysisManagerBase<ProbAnalysis, Function> {
public:
  ProbAnalysis(LoopAnalysis *loopAnaly) : m_loopAnaly(loopAnaly) {}
  void *GetResult(Function *func);
  std::vector<ProbEdge> &GetProb() { return Prob; }

private:
  LoopAnalysis *m_loopAnaly;
  std::vector<ProbEdge> Prob;
  double possible = 0.995;
};