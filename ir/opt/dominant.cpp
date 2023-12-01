#include"dominant.hpp"

void dom_begin(){
    int n,m;//CFG的结点数和边数
    dominance Dom{n,m};
    Dom.Init(m);//记录有向边的关系
    Dom.DFS(1);//起始节点的序号记为1
    Dom.find_dom();//寻找支配节点
    Dom.build_tree(); //构建支配树
    Dom.computeDF(1);
}