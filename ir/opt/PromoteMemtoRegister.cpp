#include"PromoteMemtoRegister.hpp"


void PromoteMem2Reg::RemoveFromAllocaList(int& index){
    m_Allocas[index]=m_Allocas.back();
    m_Allocas.pop_back();
    index--;
}


void PromoteMem2Reg::run(){
    AllocaInfo Info;
    //starting to deal alloca with promotable,this place are method3,method4
    for(int i=0;i!=m_Allocas.size();i++){
        AllocaInst* AI=m_Allocas[i];
        //do some basic opt
        if(!AI->IsUsed())//if not used,then delete
        {
          AI->DeletFromList();
          RemoveFromAllocaList(i);
          DeadAlloca++;
          continue;
        }
        //TODO 看下哪些基本块在使用这些ALLOC，哪些基本块定义了这个ALLOC
        Info.AnalyzeAlloca(AI);
        if(Info.DefineBlocks.size()==1){//只有一个定义基本块
           if(RewriteSingleStoreAlloca()){
             SingleStore++;//rewrite success
             RemoveFromAllocaList(i);
             continue;
           }
        }
        if(Info.IO_OnlySigleBlock&&Rewrite_IO_SingleBlock()){
            RemoveFromAllocaList(i);
            continue;
        }
        std::vector<BasicBlock*> DefineBlock(Info.DefineBlocks.begin(),Info.DefineBlocks.end());
        PreWorkingAfterInsertPhi(DefineBlock);
    }
}

bool PromoteMem2Reg::Rewrite_IO_SingleBlock(){

}

void AllocaInfo::AnalyzeAlloca(AllocaInst* Inst){

}

bool RewriteSingleStoreAlloca(){

}

void PreWorkingAfterInsertPhi(std::vector<BasicBlock*> DefineBlock){

}