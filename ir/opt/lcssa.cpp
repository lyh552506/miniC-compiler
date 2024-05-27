#include "lcssa.hpp"
#include "my_stl.hpp"
#include <iostream>

void LcSSA::RunOnFunction() {
  for (auto l = loops->begin(); l != loops->end(); l++) {
    _DEBUG(std::cerr << "Start To Formal Loop: " << (*l)->GetHeader()->GetName()
                     << std::endl;)
    FormalLcSSA(*l);
  }
}

void LcSSA::FormalLcSSA(LoopInfo *l) {
    
}
