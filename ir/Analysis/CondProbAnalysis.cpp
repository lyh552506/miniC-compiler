#include "../../include/ir/Analysis/CondProbAnalysis.hpp"
#include "BaseCFG.hpp"
#include "CFG.hpp"
#include "LoopInfo.hpp"
#include <cassert>
#include <optional>

void *ProbAnalysis::GetResult(Function *func) {
  for (auto loop : *m_loopAnaly) {
    LoopSimplify::CaculateLoopInfo(loop, m_loopAnaly);
    auto exiting = m_loopAnaly->GetExitingBlock(loop);
    for (auto ex : exiting) {
      auto cond = dynamic_cast<CondInst *>(ex->back());
      assert(cond && "exiting block must be condinst");
      auto block_in = dynamic_cast<BasicBlock *>(cond->GetOperand(1));
      auto block_out = dynamic_cast<BasicBlock *>(cond->GetOperand(2));
      if (!loop->Contain(block_in))
        std::swap(block_in, block_out);
      if (!loop->CantCalcTrait() &&
          !dynamic_cast<ConstIRInt *>(loop->trait.boundary)) {
        Prob.emplace_back(ex, block_in, possible);
      } else {
        auto constint = dynamic_cast<ConstIRInt *>(loop->trait.boundary);
        auto bound = constint->GetVal();
        if (bound > 100000)
          bound = 100000;
        auto p = 1 - (1.0 / bound);
        Prob.emplace_back(ex, block_in, p);
      }
    }
  }
  return this;
}