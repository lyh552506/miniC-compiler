#pragma once
#include<queue>
#include"dominant.hpp"

class IDF{
private:
   using NodePair = std::pair<dominance::Node *, int>;
   using NodeContainer = std::vector<NodePair>;
   using DTNode=dominance::Node*;
  
   dominance& m_dom;
   bool uselivein;//是否可以使用livein来进行剪枝
   //bool Level;
   std::set<BasicBlock *>* DefineBlock;
   std::set<BasicBlock *>* LiveInBlocks;
   std::map<DTNode,unsigned> Level;//记录支配树上的结点的层级
   std::stack<DTNode> worklists;//深度遍历栈
   std::map<DTNode,bool> WorklistVisited;
   std::vector<std::unique_ptr<BasicBlock>> bbs;
public:
   IDF(dominance& dom):m_dom(dom),uselivein{false}
   {}

   void SetDefBB(std::set<BasicBlock*> DefBlock);

   void SetLiveInBlock(std::set<BasicBlock *> LiveInBlock);

   void SetBBs(std::vector<std::unique_ptr<BasicBlock>>& bbs);

   void caculateDTlevel(DTNode node);

   void caculateIDF(std::vector<BasicBlock*>& IDFBlocks);
   
};