#include "passManager.hpp"
#include "../../yacc/parser.hpp"
//#include "DCE.hpp"

void PassManager::Init_Pass() {
  for (int i = 0; i < Singleton<Module>().GetFuncTion().size(); i++) {
    auto f = Singleton<Module>().GetFuncTion()[i].get();
    FList.push_back(f);
    auto &Li = Singleton<Module>().GetFuncTion()[i]->GetBasicBlock();
    for (auto bb = f->begin(); bb != f->end(); ++bb)
      f->push_bb(*bb);
    for (int i = 0; i < Li.size(); ++i)
      Li[i]->num = i;
    if (InitpassRecorder[0]) {
      std::unique_ptr<dominance> dom(new dominance(f, Li.size()));
      //有了mem2reg才有后续的优化
      if (InitpassRecorder[1])
        PRE(dom.get(), f);
      }
      if(InitpassRecorder[2])
        ConstantProp(f).Pass();
      if(InitpassRecorder[5])
      {
        std::unique_ptr<LivenessAnalysis> liveness(new LivenessAnalysis);
        liveness.get()->pass(f);
      }
  }
  if(InitpassRecorder[3])
  {
    DeadCodeEliminate(FList, Singleton<Module>()).Pass();
    Singleton<Module>().Test();
  }
    
  // Singleton<Module>().Test();
  if(InitpassRecorder[4])
  {
    ADCE(FList).Pass();
  }
}

void PassManager::IncludePass(int pass) { InitpassRecorder[pass] = 1; }

