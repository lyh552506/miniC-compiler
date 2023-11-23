#include"graph_draw.hpp"

//寄存器集合(假设有6个可供分配的寄存器)
std::unordered_set<int> Reg={1,2,3,4,5,6};

//低度数的传送无关节点表
std::unordered_set<_Node*> simplifyWorkList;
//低度数的传送有关节点表
std::unordered_set<_Node*> freezeWorkLists;
//高度数的节点表
std::unordered_set<_Node*> spillWorkLists;
//本轮中要溢出的节点集合
std::unordered_set<_Node*> spilledNodes;
//有可能合并的传送指令
std::unordered_set<Instruction*> worklistMoves;



void startColoring(){
    LivenessAnalysis();


}



void Build(){

}