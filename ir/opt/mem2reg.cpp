#include "PromoteMemtoRegister.hpp"
#include "dominant.hpp"

/// @note 支配树的根节点通过entryblock返回
// mem2reg的开始函数
bool promoteMemoryToRegister(Function &func, dominance &dom) {
  std::vector<AllocaInst *> Allocas;
  auto BB = func.GetBasicBlock(); // BB是一个std::vector<BasicBlockPtr>
  while (true) {
    Allocas.clear();

    for (auto &it : BB) {
      List<User> &insts = it->GetInsts(); //获取到当前的block中的insts序列
      for (auto &Instruct : insts) {
        User *user = Instruct.get();
        if (auto allocaInst =
                dynamic_cast<AllocaInst *>(user)) //确保是alloc指令
          if (IsAllocaPromotable(allocaInst))
            Allocas.push_back(allocaInst);
      }
    }

    if(Allocas.empty())//当前没有可以promote的alloca指令
      break;
    
    RunPromoteMem2Reg(dom,Allocas);


  }
}

/// @brief 一个wrapper，在这里创建对象 
void RunPromoteMem2Reg(dominance &dom,std::vector<AllocaInst *> Allocas){
    PromoteMem2Reg(dom,Allocas).run();
}


