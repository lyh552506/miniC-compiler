#include "Inline.hpp"
#include "CFG.hpp"

std::unique_ptr<InlineHeuristic> InlineHeuristic::get(Module &m) {
  auto heuristic = std::make_unique<InlineHeuristicManager>();
  heuristic->push_back(std::make_unique<NoRecursive>(m));
  ///!!! size_limit must be placed at the very end !!!
  heuristic->push_back(std::make_unique<SizeLimit>());
  return heuristic;
}

InlineHeuristicManager::InlineHeuristicManager() {}

bool InlineHeuristicManager::CanBeInlined(CallInst *call) {
  for (auto &heuristic : *this)
    if (!heuristic->CanBeInlined(call))
      return false;
  return true;
}

SizeLimit::SizeLimit() {}

bool SizeLimit::CanBeInlined(CallInst *call) {
  static size_t cost = 0;
  auto master = call->GetParent()->GetParent();
  auto inline_func = call->GetOperand(0)->as<Function>();
  assert(master != nullptr && inline_func != nullptr);
  auto &[master_code_size, master_frame_size] = master->GetInlineInfo();
  auto &[inline_code_size, inline_frame_size] = inline_func->GetInlineInfo();
  if (inline_frame_size + master_frame_size > maxframesize)
    return false;
  if (inline_code_size + cost > maxsize)
    return false;
  cost += inline_code_size;
  master_code_size += inline_code_size;
  master_frame_size += inline_frame_size;
  return true;
}

NoRecursive::NoRecursive(Module &_m) : m(_m) {
  // struct Node{
  //     std::unordered_set<int> sons;
  //     int dfn=0;
  //     int low=0;
  //     int belongSCC=-1;
  //     bool ins=false;
  //     int size=0;
  // };
  // int top=0;
  // int dfn=0;
  // std::vector<int> sta(m.GetFuncTion().size());
  // auto graph=std::vector<Node>(m.GetFuncTion().size());
  // std::unordered_map<Function*,int> function2index;
  // auto add_edge=[&](int from,int to){
  //     graph[from].sons.insert(to);
  // };
  // const auto dfs = [&](auto&& self, int poi) -> void {
  //     graph[poi].dfn=graph[poi].low=++dfn;
  //     graph[poi].ins=true;
  //     sta[top++]=poi;
  //     for(auto des:graph[poi].sons){
  //         if(!graph[des].dfn){
  //             self(self,des);
  //             graph[poi].low=std::min(graph[poi].low,graph[des].low);
  //         }else if(graph[des].ins)
  //             graph[poi].low=std::min(graph[poi].low,graph[des].dfn);
  //     }
  //     if(graph[poi].dfn==graph[poi].low){
  //         int tmp;
  //         do{
  //             tmp=sta[--top];
  //             graph[tmp].ins=false;
  //             graph[tmp].belongSCC=poi;
  //             graph[poi].size++;
  //         }while(tmp!=poi);
  //     }
  // };

  // int num=0;
  // for(auto& func:m.GetFuncTion())
  //     function2index[func.get()]=num++;

  // int entry_index=-1;
  // for(auto& func:m.GetFuncTion()){
  //     if(func->GetName()=="main")
  //         entry_index=function2index[func.get()];
  //     auto& calllists=func->GetUserlist();
  //     for(auto callinst:calllists){
  //         auto call=callinst->GetUser()->as<CallInst>();
  //         assert(call!=nullptr);
  //         auto master=call->GetParent()->GetParent();
  //         if(master==func.get()){
  //             recursive.insert(func.get());
  //             continue;
  //         }
  //         add_edge(function2index[master],function2index[func.get()]);
  //     }
  // }
  // assert(entry_index!=-1);
  // dfs(dfs,entry_index);

  // 遍历function的顺序好像很有意思
  // 因为没有函数声明 所以我们访问(inline)的顺序就是拓扑序
  // 毕竟能inline(去掉递归)一定inline到这个函数后边才定义的函数
  // auto &&functions=m.GetFuncTion();
  // for(auto it=functions.begin();it!=functions.end();){
  //     auto func=it->get();
  //     auto&& index=function2index[func];
  //     if(graph[graph[index].belongSCC].size>1)
  //         recursive.insert(func);
  //     if(graph[index].belongSCC==-1)//can'be referred to, delete
  //         it=functions.erase(it);
  //     else
  //         it++;
  // }
}

bool NoRecursive::CanBeInlined(CallInst *call) {
  auto &&slave = call->GetOperand(0)->as<Function>();
  auto &&master = call->GetParent()->GetParent();
  if (master != slave)
    return true;
  return false;
}

bool Inliner::RunOnModule(Module& mod, _AnalysisManager &AM) {
  init(mod);
  Inline(mod);
  return false;
}

void Inliner::init(Module& m) {
  for (auto it = m.GetFuncTion().begin(); it != m.GetFuncTion().end();) {
    if (it->get()->GetUserListSize() == 0 && it->get()->GetName() != "main")
      it = m.GetFuncTion().erase(it);
    else
      it++;
  }

  auto judge = InlineHeuristic::get(m);

  // in this way we only iterate over this non buildin functions
  for (auto &funcptr : m.GetFuncTion()) {
    Function *func = funcptr.get();
    auto &calllists = func->GetUserlist();
    for (auto callinst : calllists) {
      auto call = callinst->GetUser()->as<CallInst>();
      assert(call != nullptr);
      if (judge->CanBeInlined(call))
        NeedInlineCall.push_back(call);
    }
  }
}

void Inliner::Inline(Module& m) {
  while (!NeedInlineCall.empty()) {
    User *inst = NeedInlineCall.front();
    // std::cout<<";";
    // inst->print();
    NeedInlineCall.erase(NeedInlineCall.begin());
    BasicBlock *block = inst->GetParent();
    Function *func = block->GetParent();

    BasicBlock *SplitBlock = block->SplitAt(inst);
    BasicBlock::mylist<Function, BasicBlock>::iterator Block_Pos(block);
    Block_Pos.insert_after(SplitBlock);
    ++Block_Pos;

    std::vector<BasicBlock *> blocks = CopyBlocks(inst);
    UnCondInst *Br = new UnCondInst(blocks[0]);
    block->push_back(Br);
    for (auto it = blocks[0]->begin(); it != blocks[0]->end();) {
      auto shouldmvinst = dynamic_cast<AllocaInst *>(*it);
      ++it;
      if (shouldmvinst) {
        BasicBlock *front_block = func->front();
        shouldmvinst->EraseFromParent();
        front_block->push_front(shouldmvinst);
      }
    }
    for (BasicBlock *block_ : blocks)
      Block_Pos.insert_before(block_);
    if (inst->GetTypeEnum() != InnerDataType::IR_Value_VOID) {
      // if(SSALevel)
      // {
      PhiInst *Phi =
          PhiInst::NewPhiNode(SplitBlock->front(), SplitBlock, inst->GetType());
      HandleRetPhi(SplitBlock, Phi, blocks);
      if (Phi->Getuselist().size() == 1) {
        Value *val = Phi->Getuselist()[0]->usee;
        inst->RAUW(val);
      } else
        inst->RAUW(Phi);
      // }
      // else
      // {
      // AllocaInst* Alloca = new AllocaInst(" ",inst->GetType());
      // entry->InsertAlloca(Alloca);
      // LoadInst* load = new LoadInst(Alloca);
      // for(Use* user_ : inst->GetUserlist())
      // {
      //     User* user = user_->GetUser();
      //     auto Inst_Pos = std::find(inst->GetParent()->begin(),
      //     inst->GetParent()->end(), user); Inst_Pos.insert_before(load);
      // }
      // inst->RAUW(load);
      // // NewBlock->push_front(load);
      // }
    } else
      HandleVoidRet(SplitBlock, blocks);
    auto &&inlined_func = inst->GetOperand(0)->as<Function>();
    if (inlined_func->GetUserListSize() == 0)
      m.EraseFunction(inlined_func);
    delete inst;
  }
}

std::vector<BasicBlock *> Inliner::CopyBlocks(User *inst) {
  Function *Func = dynamic_cast<Function *>(inst->Getuselist()[0]->usee);
  std::unordered_map<Operand, Operand> OperandMapping;

  std::vector<BasicBlock *> copied_bbs;
  for (BasicBlock *block : *Func)
    copied_bbs.push_back(block->clone(OperandMapping));
  int num = 1;
  for (auto &param : Func->GetParams()) {
    Value *Param = param.get();
    if (OperandMapping[Param])
      OperandMapping[Param]->RAUW(inst->Getuselist()[num]->usee);
    num++;
  }
  return copied_bbs;
}

// void Inliner::InlineRecursive(Function* entry)
// {
//          TODO
// }

void Inliner::HandleVoidRet(BasicBlock *spiltBlock,
                            std::vector<BasicBlock *> &blocks) {
  for (BasicBlock *block : blocks) {
    User *inst = block->back();
    if (dynamic_cast<RetInst *>(inst)) {
      UnCondInst *Br = new UnCondInst(spiltBlock);
      inst->ClearRelation();
      inst->EraseFromParent();
      block->push_back(Br);
    }
  }
}

void Inliner::HandleRetPhi(BasicBlock *RetBlock, PhiInst *Phi,
                           std::vector<BasicBlock *> &blocks) {
  for (BasicBlock *block : blocks) {
    User *inst = block->back();
    if (dynamic_cast<RetInst *>(inst)) {
      Phi->updateIncoming(inst->Getuselist()[0]->usee, block);
      UnCondInst *Br = new UnCondInst(RetBlock);
      inst->ClearRelation();
      inst->EraseFromParent();
      block->push_back(Br);
    }
  }
}