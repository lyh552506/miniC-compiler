#include "../../include/ir/opt/ArithOpt.hpp"
#include "CFG.hpp"

bool ArithOpt::Run() {
  BasicBlock *EntryBB = m_func->front();
  m_func->init_visited_block();
  auto m_dom = AM.get<dominance>(m_func);
  PostOrderCFG(EntryBB, m_dom);
  std::reverse(RPO.begin(), RPO.end());
}

void ArithOpt::PostOrderCFG(BasicBlock *root, dominance *m_dom) {
  if (root->visited)
    return;
  root->visited = true;
  for (int tmp : m_dom->GetNode(root->num).des) {
    PostOrderCFG(m_dom->GetNode(tmp).thisBlock, m_dom);
  }
  RPO.push_back(root);
}

bool ArithOpt::ReduceDiv() {
  for (auto bb : RPO)
    for (auto inst : *bb) {
      auto div = dynamic_cast<BinaryInst *>(inst);
      if (!div)
        continue;
      
    }
}