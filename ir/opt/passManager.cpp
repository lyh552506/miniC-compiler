#include "passManager.hpp"
#include "../../yacc/parser.hpp"

void PassManager::Init_Pass() {
  for (int i = 0; i < Singleton<Module>().GetFuncTion().size(); i++) {
    auto f = Singleton<Module>().GetFuncTion()[i].get();
    auto &Li = Singleton<Module>().GetFuncTion()[i]->GetBasicBlock();
    for (auto bb = f->begin(); bb != f->end(); ++bb)
      f->push_bb(*bb);
    for (int i = 0; i < Li.size(); ++i)
      Li[i]->num = i;
    if (InitpassRecorder[0]) {
      std::unique_ptr<dominance> dom(new dominance(f, Li.size()));
      //有了mem2reg才有后续的优化
      if (InitpassRecorder[1])
        PRE(dom.get(), f).init_pass();
      if(InitpassRecorder[2])
        ConstantProp(dom.get(), f).Pass();
    }
  }
  print_result();
}

void PassManager::IncludePass(int pass) { InitpassRecorder[pass] = 1; }

void PassManager::print_result() {
  if (InitpassRecorder[0]) {
    std::cout << "--------mem2reg--------" << std::endl;
    Singleton<Module>().Test();
  } 
  if(InitpassRecorder[1]){
    std::cout << "--------pre--------" << std::endl;
    Singleton<Module>().Test();
  } 
  if(InitpassRecorder[2]){
    std::cout << "--------constantprop--------" << std::endl;
    Singleton<Module>().Test();
  }
}