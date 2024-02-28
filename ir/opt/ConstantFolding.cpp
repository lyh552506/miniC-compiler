// #include "ConstantFold.hpp"
// #include <queue>
// ConstantData* ConstantFolding::ConstantFoldConstantExpression(ConstantExpr* _ConstantExpr){};
// ConstantData* ConstantFolding::ConstantFoldInstruction(User* inst, BasicBlock* block)
// {
//     // Handle PHI nodes quickly here...
//     if(auto _PhiNode = dynamic_cast<PhiInst*>(inst))
//     {
//         ConstantData *CommonValue = nullptr;
//         for(Value* income : _PhiNode->GetAllPhiVal())
//         {
//             if(auto _UndefValue = dynamic_cast<UndefValue*>(income))
//                 continue;
//             auto *_Constant = dynamic_cast<ConstantData*>(income);
//             if(!_Constant)
//                 return nullptr;
//             if(auto *NewConstant = dynamic_cast<ConstantExpr*>(_Constant))
//                 _Constant = ConstantFoldConstantExpression(NewConstant);
//             if(CommonValue && _Constant != CommonValue)
//                 return nullptr;
//             CommonValue = _Constant;
//         }
//         return CommonValue ? CommonValue : UndefValue::get(_PhiNode->GetType());
//     }
//     bool all_Constant = true;
//     for(auto &_Operand : inst->Getuselist())
//     {
//         auto __Operand = _Operand.get();
//         if(!dynamic_cast<ConstantData*>(__Operand->GetValue()))
//         {
//             all_Constant = false;
//             break;
//         }
//     }
//     if(all_Constant)
//     {
//         //ConstantFoldInstOperandsImpl;
//     }
//     return nullptr;
    
//     std::vector<ConstantData*> Operands;
//     for(auto &_Operand : inst->Getuselist())
//     {
//         auto *__Operand = dynamic_cast<ConstantData*>(_Operand->GetValue());
//         if(auto *NewConstantExpr = dynamic_cast<ConstantExpr*>(__Operand))
//             __Operand = ConstantFoldConstantExpression(NewConstantExpr);
//         Operands.push_back(__Operand);
//     }
//     if(const auto *_LoadInst = dynamic_cast<LoadInst*>(inst))
//         return ConstantFoldLoadInst(_LoadInst);
//     return ConstantFoldInstOperands(inst, Operands);
// }

// ConstantData ConstantFolding::*SymbolicallyEvaluateBinop(unsigned Opcode, Value* Op0, Value* Op1)
// {
//     if(Opcode == BinaryInst::Op_And)
//     {

//     }
//     if(Opcode == BinaryInst::Op_Sub)
//     {

//     }

//     return nullptr;
// }

// ConstantData ConstantFolding::*ConstantFoldBinaryOpOperands(unsigned Opcode, Value* LHS, Value* RHS)
// {
    
// }

// ConstantData ConstantFolding::*ConstantFoldInstOperands(User* inst, std::vector<Value*> _Operands);

// ConstantData ConstantFolding::*ConstantFoldCompareInstOperands(User* Pred, Value* LHS, Value* RHS);

// ConstantData ConstantFolding::*ConstantFoldLoadFromConstPtr(Value* _Const, Type* type);

// bool canConstantFoldCallto(User* inst);

// ConstantData ConstantFolding::*ConstantFoldCall(Function* func, std::vector<Value*> Operands);

// void ConstantFolding::Pass(Function* func, dominance& dom)
// {
//     bfsTraversal(func, dom);
// }
// void ConstantFolding::bfsTraversal(Function* func, dominance& dom)
// {
//     std::queue<int> q;
//     std::vector<bool> visited(sizeof(dominance::Node), false);

//     //从根节点开始
//     int rootIndex = 1;
//     q.push(rootIndex);
//     visited[rootIndex] = true;

//     while(!q.empty())
//     {
//         int current = q.front();
//         q.pop();
//         dominance::Node* currentNode = &dom.node[current];

//         //TODO
//         RunOnBlock(currentNode->thisBlock);

//         for(int childIndex : currentNode->idom_child)
//         {
//             if(!visited[childIndex])
//             {
//                 q.push(childIndex);
//                 visited[childIndex] = true;
//             }
//         }
//     }
// }

// void ConstantFolding::RunOnBlock(BasicBlock* block)
// {
//     for(User* inst:*block)
//     {
//         if(isConstantAssignment(inst))
//             propConstToRef(inst);
//         else if(isBranchAndConstPredicate(inst))
//             changeCondBranchToAbsBranchAndMark(inst);
//         else if(isPhi(inst))
//             if(isOneBlockUnreachable(inst) || IsSameValPre(inst))
//                 propPhiToRef(inst);
//     }
// }

// bool isConstantAssignment(User* inst)
// {

// }
//  /*
//     沿CFG对应的 dominant tree 从entry开始按BFS顺序遍历BasicBlock
//     foreach block in blocks do:
//         遍历每个inst
//         foreach instr in block do:
//             如果是常量赋值或者常量计算的结果
//             if isConstantAssignment(instr):
//                 用常量值替换该变量的所有引用
//                 propConstToRef(instr)
//             如果是常量值的分支条件
//             elif isBranchAndConstPredicate(instr):
//                 替换为强制跳转，并标记另一个分支不可达
//                 changeCondBranchToAbsBranchAndMark(instr)
//             如果是phi
//             elif isPhi(instr):
//                 如果有一个基本块不可达，或者两个基本块的值相同
//                 if isOneBlockUnreachable(instr) || IsSameValPre(instr):
//                     将可达块的值传播到对该指令的引用
//                     propPhiToRef(instr)
//     */

// Constant *llvm::ConstantFoldInstruction(Instruction *I, const DataLayout &DL,
//                                         const TargetLibraryInfo *TLI) {
//   // Handle PHI nodes quickly here...
//   if (auto *PN = dyn_cast<PHINode>(I)) {
//     Constant *CommonValue = nullptr;

//     for (Value *Incoming : PN->incoming_values()) {
//       // If the incoming value is undef then skip it.  Note that while we could
//       // skip the value if it is equal to the phi node itself we choose not to
//       // because that would break the rule that constant folding only applies if
//       // all operands are constants.
//       if (isa<UndefValue>(Incoming))
//         continue;
//       // If the incoming value is not a constant, then give up.
//       auto *C = dyn_cast<Constant>(Incoming);
//       if (!C)
//         return nullptr;
//       // Fold the PHI's operands.
//       if (auto *NewC = dyn_cast<ConstantExpr>(C))
//         C = ConstantFoldConstantExpression(NewC, DL, TLI);
//       // If the incoming value is a different constant to
//       // the one we saw previously, then give up.
//       if (CommonValue && C != CommonValue)
//         return nullptr;
//       CommonValue = C;
//     }


//     // If we reach here, all incoming values are the same constant or undef.
//     return CommonValue ? CommonValue : UndefValue::get(PN->getType());
//   }

//   // Scan the operand list, checking to see if they are all constants, if so,
//   // hand off to ConstantFoldInstOperandsImpl.
//   if (!all_of(I->operands(), [](Use &U) { return isa<Constant>(U); }))
//     return nullptr;

//   SmallVector<Constant *, 8> Ops;
//   for (const Use &OpU : I->operands()) {
//     auto *Op = cast<Constant>(&OpU);
//     // Fold the Instruction's operands.
//     if (auto *NewCE = dyn_cast<ConstantExpr>(Op))
//       Op = ConstantFoldConstantExpression(NewCE, DL, TLI);

//     Ops.push_back(Op);
//   }

//   if (const auto *CI = dyn_cast<CmpInst>(I))
//     return ConstantFoldCompareInstOperands(CI->getPredicate(), Ops[0], Ops[1],
//                                            DL, TLI);

//   if (const auto *LI = dyn_cast<LoadInst>(I))
//     return ConstantFoldLoadInst(LI, DL);

//   if (auto *IVI = dyn_cast<InsertValueInst>(I)) {
//     return ConstantExpr::getInsertValue(
//                                 cast<Constant>(IVI->getAggregateOperand()),
//                                 cast<Constant>(IVI->getInsertedValueOperand()),
//                                 IVI->getIndices());
//   }

//   if (auto *EVI = dyn_cast<ExtractValueInst>(I)) {
//     return ConstantExpr::getExtractValue(
//                                     cast<Constant>(EVI->getAggregateOperand()),
//                                     EVI->getIndices());
//   }

//   return ConstantFoldInstOperands(I, Ops, DL, TLI);
// }
