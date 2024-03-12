#include "DeadCodeEliminate.hpp"

void DeadCodeEliminate::Pass(Module* module)
{
  for (auto &_func : module->GetFuncTion())
  {
    Function* func = _func.get();
    if (func->is_declaration())
      continue;
    for (auto &block : func->get_basic_blocks())
    {
      for (auto &inst : block->get_instructions())
      {
        if (isDeadInstruction(inst))
        {
          deleteDeadInst(block, inst);
        }
      }
    }
  }
  deleteDeadFunc(module);
}
// #include "DeadCodeEliminate.hpp"

// void DeadCodeEliminate::Pass(Module* module)
// {
//     deleteDeadFunc(module);
//     detectNotSideEffectFunc(module);
//     for(auto &_func : module->GetFuncTion()) 
//     {
//         Function* func = _func.get();
//         if(func != module->getMainFunc())
//             deleteDeadRet(func);   
//     }
//     for(auto &_func : module->GetFuncTion()) 
//     {
//         Function* func = _func.get();
//         deleteDeadInst(func);
//         deleteDeadStore(func);
//         deleteDeadInst(func);
//     }
// }
// // void DeadCodeEliminate::deleteDeadFunc(Module *m) {
// //   func_counter = 0;
// //   auto &funcs = m->getFunctions();
// //   for (auto iter = funcs.begin(); iter != funcs.end();) {
// //     auto func = *iter;
// //     if (func->getBasicBlocks().empty()) {
// //       ++iter;
// //       continue;
// //     }
// //     if (func->getUseList().empty() && func != m_->getMainFunction()) {
// //       func_counter++;
// //       iter = funcs.erase(iter);
// //     } else
// //       ++iter;
// //   }
// // }
// void DeadCodeEliminate::deleteDeadFunc(Module* module)
// {
//     func_counter = 0;
//     for(auto &_func : module->GetFuncTion()) 
//     {
//         Function* func = _func.get();
//         if(func->GetBasicBlock().empty())
//             continue;
//         if((func->GetUserlist())->is_empty() && func != module->getMainFunc())
//     }
// }


// void DeadCodeEliminate::detectNotSideEffectFunc(Module* module)
// {
//     for(auto &_func : module->GetFuncTion()) 
//     {
//         Function* func = _func.get();
//         if(func->GetBasicBlock().empty() || func == module->getMainFunc())
//             continue;
//         bool sideEffect = false;
//         for(BasicBlock* block : func->GetBasicBlock())
//         {
//             for(User* inst : *block)
//             {
//                 // if(auto Call = dynamic_cast<CallInst*>(inst))
//                 // {
//                 //     if(Call->hasSideEffect())
//                 //     {
//                 //     sideEffect = true;
//                 //     break;
//                 //     }
//                 // }

//                 // if(auto Store = dynamic_cast<StoreInst*>(inst))
//                 // {
//                 //     if(Store->hasSideEffect())
//                 //     {
//                 //         sideEffect = true;
//                 //         break;
//                 //     }
//                 // }
//             }
//         }
//         if(sideEffect == false)
//             notSideEffectFunc.insert(func);
//     }
// }

// void DeadCodeEliminate::deleteDeadInst(Function* func)
// {

// }

// void DeadCodeEliminate::deleteDeadStore(Function* func)
// {

// }

// void DeadCodeEliminate::deleteDeadRet(Function* func)
// {

// }

// bool DeadCodeEliminate::isSideEffectAndCall(User* inst)
// {

// }

// bool DeadCodeEliminate::isLocalStore(StoreInst* inst)
// {

// }

// bool DeadCodeEliminate::isDeadInstruction(User* inst)
// {

// }

// bool DeadCodeEliminate::isEqualStoreLoadPtr(StoreInst* store, LoadInst* load)
// {

// }

// bool DeadCodeEliminate::isEqualStorePtr(StoreInst* store_a, StoreInst* store_b)
// {

// }