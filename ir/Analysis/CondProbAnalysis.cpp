#include "../../include/ir/Analysis/CondProbAnalysis.hpp"
#include "../../include/ir/opt/New_passManager.hpp"
#include <cassert>
#include <optional>

void *ProbAnalysis::GetResult(Function *func) {
  for (auto loop : *m_loopAnaly) {
    auto AM = Singleton<_AnalysisManager>();
    bool CantCalc = false;
    if (AM.FindAttr(loop->GetHeader(), Rotate))
      LoopSimplify::CaculateLoopInfo(loop, m_loopAnaly);
    else {
      CantCalc = true;
    }
    auto exiting = m_loopAnaly->GetExitingBlock(loop);
    auto header = loop->GetHeader();
    for (auto rev : m_dom->GetNode(header->num).rev) {
      auto preheader = m_dom->GetNode(rev).thisBlock;
      if (dynamic_cast<UnCondInst *>(preheader->back())) {
        m_Prob.emplace_back(preheader, header, possible);
      } else {
        //大概率不会跳入这
        auto cond = dynamic_cast<CondInst *>(preheader->back());
        auto lhs = dynamic_cast<BasicBlock *>(cond->GetOperand(1));
        auto rhs = dynamic_cast<BasicBlock *>(cond->GetOperand(2));
        if (m_loopAnaly->LookUp(lhs) && m_loopAnaly->LookUp(rhs)) {
          int lhs_contain = m_loopAnaly->LookUp(lhs)->GetLoopDepth() +
                            m_loopAnaly->LookUp(lhs)->GetSubLoop().size();
          int rhs_contain = m_loopAnaly->LookUp(rhs)->GetLoopDepth() +
                            m_loopAnaly->LookUp(rhs)->GetSubLoop().size();
          if (lhs_contain > rhs_contain)
            m_Prob.emplace_back(preheader, lhs, possible);
          else if (rhs_contain > lhs_contain)
            m_Prob.emplace_back(preheader, rhs, possible);
          else
            m_Prob.emplace_back(preheader, lhs, 0.5);
        } else if (m_loopAnaly->LookUp(lhs) && !m_loopAnaly->LookUp(rhs)) {
          m_Prob.emplace_back(preheader, lhs, possible);
        } else if (!m_loopAnaly->LookUp(lhs) && m_loopAnaly->LookUp(rhs)) {
          m_Prob.emplace_back(preheader, rhs, possible);
        }
      }
    }
    for (auto ex : exiting) {
      auto cond = dynamic_cast<CondInst *>(ex->back());
      assert(cond && "exiting block must be condinst");
      auto block_in = dynamic_cast<BasicBlock *>(cond->GetOperand(1));
      auto block_out = dynamic_cast<BasicBlock *>(cond->GetOperand(2));
      if (!loop->Contain(block_in))
        std::swap(block_in, block_out);
      if (CantCalc || !loop->CantCalcTrait() ||
          !dynamic_cast<ConstIRInt *>(loop->trait.boundary)) {
        m_Prob.emplace_back(ex, block_in, possible);
      } else {
        auto constint = dynamic_cast<ConstIRInt *>(loop->trait.boundary);
        auto bound = constint->GetVal();
        if (bound > 100000)
          bound = 100000;
        auto p = 1 - (1.0 / bound);
        m_Prob.emplace_back(ex, block_in, p);
      }
    }
  }
  return this;
}