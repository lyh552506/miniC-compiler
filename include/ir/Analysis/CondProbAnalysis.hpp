#pragma once
#include "../opt/New_passManager.hpp"
#include "../opt/PassManagerBase.hpp"
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
  ProbAnalysis(Function *func, LoopAnalysis *loopAnaly, dominance *dom)
      : m_loopAnaly(loopAnaly), m_dom(dom) {}
  void *GetResult(Function *func);
  std::vector<ProbEdge> GetProb() { return m_Prob; }

private:
  LoopAnalysis *m_loopAnaly;
  std::vector<ProbEdge> m_Prob;
  dominance *m_dom;
  double possible = 0.995;
};