#pragma once
#include "../../include/backend/BackendPass.hpp"
#include "../../include/backend/RISCVContext.hpp"
#include "../../include/backend/RISCVMIR.hpp"
#include "../../include/backend/RISCVMOperand.hpp"
#include "../../include/backend/RISCVRegister.hpp"
#include "../../include/backend/RISCVType.hpp"
#include "../../include/backend/RegAlloc.hpp"
#include "../../include/lib/BaseCFG.hpp"
#include "../../include/lib/CFG.hpp"
#include "../../util/my_stl.hpp"
class BlockLiveInfo;
using MOperand = Register *;
class BackendDCE : public Liveness, BackEndPass<RISCVFunction>
{
  private:
    RISCVLoweringContext &ctx;
    RISCVFunction *func;
    std::vector<RISCVMIR *> wait_del;
    bool CanHandle(RISCVMIR *inst);
    bool RunOnBlock(RISCVBasicBlock *block);
    bool TryDeleteInst(RISCVMIR *inst, std::unordered_set<MOperand> &live);
    void UpdateLive(RISCVMIR *inst, std::unordered_set<MOperand> &live);
    bool run(RISCVFunction *func);

  public:
    bool RunImpl();
    BackendDCE(RISCVFunction *func_, RISCVLoweringContext &_ctx) : Liveness(func_), ctx(_ctx), func(func_)
    {
      func=ctx.GetCurFunction();
    }
};