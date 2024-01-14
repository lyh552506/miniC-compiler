#pragma once
#include<queue>
#include"dominant.hpp"

class IDF{
private:
   dominance& m_dom;
   bool uselivein;//是否可以使用livein来进行剪枝
   //bool Level;
   std::set<BasicBlock *>* DefineBlock;
   std::set<BasicBlock *>* LiveInBlocks;
   std::map<dominance::Node*,unsigned> Level;//记录支配树上的结点的层级
   std::stack<dominance::Node*> worklists;//深度遍历栈
   std::map<dominance::Node*,bool> WorklistVisited;
public:
   IDF(dominance& dom):m_dom(dom),uselivein{false}
   {}

   void SetDefBB(std::set<BasicBlock*> DefBlock);

   void SetLiveInBlock(std::set<BasicBlock *> LiveInBlock);

   void caculateDTlevel(dominance::Node* node);

   void caculateIDF(std::vector<BasicBlock*>& PhiBlocks);
   
};