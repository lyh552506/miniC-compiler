#include "LoopInfo.hpp"

void LoopInfo::Find_SSC(int u) {
  dfs[u] = low[u] = index++;
  bbs[u]->visited = true;
  st.push(u);
  in_stack[u] = 1;
  for (auto to : Dest[u]) {
    if (bbs[to]->visited == false) {
      Find_SSC(to);
      low[u] = std::min(low[u], low[to]);
    } else if (in_stack[to] == 1)
      low[u] = std::min(low[u], low[to]);
  }
  // find a scc
  if (dfs[u] == low[u]) {
    std::vector<int> scc;
    while (!st.empty() && st.top() != u) {
      scc.push_back(st.top());
      in_stack[st.top()] = 0;
      st.pop();
    }
    if (!st.empty()) {
      scc.push_back(st.top());
      in_stack[st.top()] = 0;
      st.pop();
    }
    FindLoopHeader(std::move(scc));
  }
}

void LoopInfo::FindLoopHeader(std::vector<int> &&scc) {
  int lca;
  if (scc.size() == 1) {
    BasicBlock *cur = bbs[scc[0]];
    auto iter = std::find(Dest[scc[0]].begin(), Dest[scc[0]].end(), cur->num);
    if (iter == Dest[scc[0]].end())
      return;
    Loops.push_back(std::make_pair(cur->num, std::move(scc)));
    return;
  }
  // scc.size()>1
  lca = scc[0];
  BasicBlock *l = bbs[lca];
  for (int i = 1; i < scc.size(); i++) {
    if (m_dom->dominates(l, bbs[scc[i]]))
      continue;
    else {
      lca = scc[i];
      l = bbs[lca];
    }
  }
  Loops.push_back(std::make_pair(lca, std::move(scc)));
}

//打印格式：
// num of loops
// each loop nodes
void LoopInfo::PrintPass() {
  std::cout << "Num Of Loops:" << Loops.size() << "\n";
  for (int i = 0; i < Loops.size(); i++) {
    auto tmp = Loops[i];
    std::cout << "Loop Head:" << bbs[tmp.first]->GetName() << "\n";
    std::cout << "Loop Body:";
    for (auto x : tmp.second)
      if (x != tmp.first)
        std::cout << bbs[x]->GetName() << " ";
    std::cout << "\n\r";
  }
}