#pragma once
#include "../../include/ir/opt/New_passManager.hpp"
#include "../../include/ir/opt/PassManagerBase.hpp"
#include <vector>

struct ProbEdge {
  ProbEdge(BasicBlock *_Out, BasicBlock *_In, double prob)
      : Out(_Out), In(_In), Prob(prob) {}
  BasicBlock *Out;
  BasicBlock *In;
  double Prob;
};

class ProbAnalysis : public _AnalysisManagerBase<ProbAnalysis, Function> {
public:
  ProbAnalysis(Function* func,LoopAnalysis *loopAnaly) : m_loopAnaly(loopAnaly) {}
  void *GetResult(Function *func);
  std::vector<ProbEdge> GetProb() { return m_Prob; }

private:
  LoopAnalysis *m_loopAnaly;
  std::vector<ProbEdge> m_Prob;
  double possible = 0.995;
};