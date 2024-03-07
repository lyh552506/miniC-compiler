#include "CFG.hpp"
#include "my_stl.hpp"
#include "parser.hpp"

class ElimitCriticalEdge {
public:
  void DealCriticalEdges();
  void AddNullBlock(User *inst, int succ);
  ElimitCriticalEdge(Function &func) : m_func(func) {}

private:
  Function &m_func;
};

void ElimitCriticalEdge::DealCriticalEdges() {
  for (auto it = m_func.begin(); it != m_func.end(); ++it) {
    BasicBlock *bb = *it;
    //获取到后继节点个数
    int SuccessorNum = GetSuccNum(bb);
    if (SuccessorNum > 1)
      for (int i = 0; i < SuccessorNum; i++)
        AddNullBlock(bb->back(), i);
  }
}

void ElimitCriticalEdge::AddNullBlock(User *inst, int succ) {
  auto CI = dynamic_cast<CondInst *>(inst);
  assert(CI && "inst transferred in must be a CondInst");

  //获取到前驱结点个数
  BasicBlock *DstBB =
      dynamic_cast<BasicBlock *>(CI->Getuselist()[succ + 1]->GetValue());
  assert(DstBB);
  int PredNum = GetPredNum(DstBB);
  if (PredNum < 2) //不是关键边
    return;

  BasicBlock *CurrBB = inst->GetParent();
  BasicBlock *criticalbb = new BasicBlock(m_func);
  //在关键边中插入block
  m_func.InsertBlock(CurrBB, DstBB, criticalbb);

  //还需要修改phi函数的incoming
  for (auto iter = DstBB->begin();
       iter != DstBB->end() && dynamic_cast<PhiInst *>(*iter) != nullptr;
       ++iter) {
    auto phi = dynamic_cast<PhiInst *>(*iter);
    auto it1 = std::find_if(
        phi->PhiRecord.begin(), phi->PhiRecord.end(),
        [CurrBB](std::pair<int, std::pair<Value *, BasicBlock *>> &ele) {
          return ele.second.second == CurrBB;
        });
    if (it1 == phi->PhiRecord.end())
      continue;
    //将value对应的块信息更改
    it1->second.second = criticalbb;
    phi->Blocks[it1->first]=criticalbb;
  }
}