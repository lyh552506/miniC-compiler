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