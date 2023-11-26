#include "graph_draw.hpp"

// 可着色的数量K
#define K 10

// 寄存器集合(假设有6个可供分配的寄存器)
std::unordered_set<int> Reg = {1, 2, 3, 4, 5, 6};

// 机器寄存器的集合，每个寄存器都预先指派了一种颜色
std::unordered_set<_Node> Precolored;
// 临时寄存器集合，其中的元素既没有预着色，也没有被处理
std::unordered_set<_Node> initial;
// 低度数的传送无关节点表
std::list<_Node> simplifyWorkList;
// 低度数的传送有关节点表
std::unordered_set<_Node> freezeWorkLists;
// 高度数的节点表
std::unordered_set<_Node> spillWorkLists;
// 本轮中要溢出的节点集合
std::unordered_set<_Node> spilledNodes;
// 有可能合并的传送指令
std::list<Instruction> worklistMoves;
// 还未做好准备的传送指令集合
std::list<Instruction> activeMoves;
//已经合并的传送指令集合
std::list<Instruction> coalescedMoves;
//源操作数和目标操作数冲突的传送指令集合
std::list<Instruction> constrainedMoves;
//不再考虑合并的传送指令集合
std::list<Instruction> frozenMoves;
// 从一个结点到与该节点相关的传送指令表的映射
std::map<_Node, std::list<Instruction>> moveList;
// 图中冲突边的结合
std::unordered_map<_Node, _Node> AdjSet;
// 从图中删除的临时变量的栈
std::unordered_set<_Node> selectlist;
// 已合并的寄存器集合，当合并u<--v，将v加入到这个集合中，u则被放回到某个工作表中(或反之)
std::unordered_set<_Node> coalescedNodes;

/// @brief 开始着色
void start()
{
    // LivenessAnalysis();
    Function function;
    Build(function);
    MakeWorkList();
    do
    {
        if (!simplifyWorkList.empty())
        {
            Simplify();
        }
        else if (!worklistMoves.empty())
        {
            coalesce();
        }
        else if (!freezeWorkLists.empty())
        {
            Freeze();
        }
        else if (!spillWorkLists.empty())
        {
            SelectSpill();
        }
    } while (!simplifyWorkList.empty() || !worklistMoves.empty() ||
             !freezeWorkLists.empty() || !spillWorkLists.empty());
    AssignColor();
    // 如果在colorassign的时候存在溢出
    if (!spilledNodes.empty())
    {
        ReWriteProgram(
            spilledNodes); // 为被溢出的临时变量分配存储单元，并插入访问这些单元的存/取指令
        start();
    }
    else
    {
        simplifyInstr(); // 删除无用的move指令
        return;
    }
}

/// @brief
/// 根据活跃性变量分析的结果构建冲突图（和位矩阵），并且初始化worklistmoves，使之包含程序之中所有的传送指令
/// @param function
void Build(Function& function)
{
    // 遍历每一个basicblock
    for (auto block : function.bbs)
    {
        std::unordered_set<_Node> live = block.liveout;
        // 从后往前开始遍历BasicBlock里面的每个Instuction
        for (auto InstEnd = block.Inst.rbegin(); InstEnd != block.Inst.rend();InstEnd++)
        {
            Instruction& Inst = *InstEnd;
            std::vector<_Node> use = GetInst_Use(Inst);//use可能有多个
            _Node& def = GetInst_Def(Inst);//def只有一个
            if (IsMoveInstruction(Inst))// TODO 这一处的实现需要处理后的inst，来查询是否是mov指令
            { 
                _Node& Use=use[0];//如果是move指令use的vector只会有一个Node
                live.erase(Use); //live<---live\use(I)  (为什么需要删除use)
                //将这些结点与当前传送指令关联
                moveList[Use].emplace_back(Inst);
                moveList[def].emplace_back(Inst);
                //std::unique_ptr<MoveInstruction> moveInst;
                //moveInst->dst.reset(GetInst_Def(Inst));
                //std::list<_Node> temp=GetInst_Use(Inst);
                //moveInst->src=std::make_unique<_Node>(temp.front());//move指令中获取到的use只会有一个元素，此时只需要取list的头部并转移所有权                
                worklistMoves.emplace_back(Inst);
            }
            live.emplace(def);//live<--live U def(l)
            // 对于每个当前的def内结点，他与目前的live都冲突
            for (auto l : live)
            {
                AddEdge(def, l);
            }
            //live<--use(I) U (live\def(I))，即更新活跃变量
            live.erase(def);
            for(auto l:use){
                live.emplace(l);
            }
        }
    }
}

/// @brief //TODO 判断是否为Move指令
/// @param Inst
/// @return bool
bool IsMoveInstruction(Instruction& Inst)
{
    //...........
    return true;
}

/// @brief 构建冲突边
/// @param u
/// @param v
void AddEdge(_Node& u, _Node& v)
{
    if ((AdjSet[u] != v) && (u != v))
    { // 构建冲突关系
        AdjSet[u] = v;
        AdjSet[v] = u;
        auto it1 = Precolored.find(u);
        auto it2 = Precolored.find(v);
        if (it1 != Precolored.end())
        { // u不是预着色的机器寄存器
            u.Insert(v);
            u.degree++;
        }
        if (it2 != Precolored.end())
        { // v不是预着色的机器寄存器
            v.Insert(u);
            v.degree++;
        }
    }
}

/// @brief 给节点进行分类（预处理）
void MakeWorkList()
{
    for (auto it = initial.begin(); it != initial.end();)
    {
        const _Node& node = *it;
        if (node.degree >= K)
        { // 归入到高度数结点
            spillWorkLists.emplace(node);
        }
        else if (IsMoveRelated(node))
        { // 归入到低度数的传送有关节点
            freezeWorkLists.emplace(node);
        }
        else
        { // 低度数的传送无关节点，可以简化
            simplifyWorkList.emplace_back(node);
        }
        it = initial.erase(it); // erase 返回指向下一个元素的迭代器
    }
}

/// @brief 简化结点
void Simplify()
{
    // 获取其中一个可简化结点，将他加入到selectlist并从simplifylist里删除
    _Node node = simplifyWorkList.front();
    simplifyWorkList.pop_front();
    selectlist.insert(node);

    std::list<_Node>& adjlist = node.GetList(); // 获取结点的邻接表AdjList
    for (_Node& m : adjlist)
    {
        if (selectlist.find(m) == selectlist.end() &&
            coalescedNodes.find(m) == coalescedNodes.end())
        {
            DecrementDegree(m);
        }
    }
}

// 合并
void coalesce() { 
    Instruction& Inst = worklistMoves.front();
    _Node dst=Inst.def;
    std::vector<_Node> Use=Inst.use;
    _Node src=Use[0];
    GetAlias(&dst);
    GetAlias(&src);
    std::pair<_Node,_Node> coales;
    if(Precolored.find(src)!=Precolored.end())//src是机器寄存器集合,则合并的话只能是dst合并到src
       coales=std::make_pair(src,dst);
    else
       coales=std::make_pair(dst,src);
    worklistMoves.pop_front();
    if(src==dst){//源操作结点和目标结点是同一个节点
      coalescedMoves.emplace_back(Inst);
      AddWorkList(src);
    }else if(Precolored.find(coales.second)!=Precolored.end()||IsAdjset(coales)){//src和dst都是机器寄存器（互相冲突）或者两节点存在冲突边，则不考虑合并，考虑是否可以简化
        constrainedMoves.emplace_back(Inst);
        AddWorkList(src);
        AddWorkList(dst);
    }else if(Precolored.find(coales.first)!=Precolored.end()){

    }


    
}

/// @brief 获取结点，对于已经合并的结点，返回他合并到的结点名
/// @param node
/// @return void
void GetAlias(_Node* node)
{
    if (coalescedNodes.find(*node) != coalescedNodes.end())// node被合并
    { 
        if (node->alias != node) 
          GetAlias(node->alias);
    }
}

/// @brief 对传入结点进行判定，如果满足条件就将他加入到可简化节点
/// @param node 
void AddWorkList(_Node& node){
    if(Precolored.find(node)!=Precolored.end()){
        if(!IsMoveRelated(node)){
            if(node.degree<K){
                freezeWorkLists.erase(node);
                simplifyWorkList.emplace_back(node);
            }
        }
    }
}



void Freeze() {}

void SelectSpill() {}

void AssignColor() {}

void ReWriteProgram(std::unordered_set<_Node>& myset) {}

// 获取指定指令的Use
std::vector<_Node> GetInst_Use(Instruction& Inst) {}
// 获取指定指令的Def
_Node& GetInst_Def(Instruction& Inst) {}

/// @brief 判断是否是移动相关结点
/// @param node
/// @return bool
bool IsMoveRelated(const _Node& node)
{
    std::list<Instruction> Inst = NodeMoves(node);
    if (!Inst.empty())
    {
        return true;
    }
    return false;
}

/// @brief 获取传入节点的所有冲突节点（除了已经被压入删除栈的和被合并的）
/// @param node
/// @return 一个双向链表（不用担心返回一个list所带来的效率问题）
std::list<_Node> Adjacent(_Node& node)
{
    std::list<_Node> L = node.GetList();
    std::list<_Node> result{};
    for (auto& Nod : L)
    {
        auto it1 = selectlist.find(Nod);
        auto it2 = coalescedNodes.find(Nod);
        if (it1 == selectlist.end() && it2 == coalescedNodes.end())
        { //不在这两个集合则添加
            result.emplace_back(Nod);
        }
    }
    return result;
}

/// @brief
/// 找出该节点相关的传送指令中有可能合并的传送指令集合和还未做好准备的传送指令集合
/// （//TODO为什么？？）
/// @param node
/// @return 一个双向链表（不用担心返回一个list所带来的效率问题）
std::list<Instruction> NodeMoves(const _Node& node)
{
    auto it = moveList.find(node);
    std::list<Instruction> result{};
    if (it != moveList.end())
    {
        std::list<Instruction>& InstList = it->second; //获取映射到的move指令集
        for (auto& Inst : InstList)
        {
            auto it1 = std::find(
                activeMoves.begin(), activeMoves.end(),
                Inst); // TODO如果能把activeMoves和worklistMoves改成unordered_set效率会变快,前提是提供可哈希的变量
            auto it2 =
                std::find(worklistMoves.begin(), worklistMoves.end(), Inst);
            if (it1 != activeMoves.end() || it2 != worklistMoves.end())
            {
                result.emplace_back(Inst);
            }
        }
    }
    return result;
}

/// @brief 图中简化一个结点之后需要减少该节点的当前各个邻接点的度数
/// @param node
void DecrementDegree(_Node& node)
{
    node.degree--;
    if (node.degree == K-1)
    {
        std::list<_Node> EnableMove = Adjacent(node);
        EnableMove.emplace_back(node);
        // EnableMoves;
        for (auto& Nod : EnableMove)
        {
            std::list<Instruction> nodemove = NodeMoves(Nod);
            for (auto& Inst : nodemove)
            {
                auto it =std::find(activeMoves.begin(), activeMoves.end(), Inst);
                if (it != activeMoves.end())
                {
                    activeMoves.erase(it);
                    worklistMoves.emplace_back(Inst);
                }
            }
        }
        spillWorkLists.erase(node); //当使他的原度数恰好为K时，减小度数后他们不再属于高度数结点
        std::list<Instruction> move = NodeMoves(node);
        if (!move.empty())
        { //该节点是移动相关的，不能被简化，加入到freezeworklist
            freezeWorkLists.emplace(node);
        }
        else
        { //可简化结点
            simplifyWorkList.emplace_back(node);
        }
    }
}

/// @brief 判断传入一对node（u，v）是否存在于adjset中，即判断u，v是否冲突
/// @param key 
/// @return bool
bool IsAdjset(std::pair<_Node,_Node>& key){
    auto it=AdjSet.find(key.first);
    if(it!=AdjSet.end()){
        if(it->second==key.second)
          return true;
    }
    return false;
}

/// @brief 合并预着色寄存器的启发式函数
/// @param node_1 
/// @param node_2 
/// @return bool 
bool OK(_Node& node_1,_Node& node_2){
    std::pair<_Node,_Node> adj=std::make_pair(node_1,node_2);
    if(node_1.degree<K||Precolored.find(node_1)!=Precolored.end()||IsAdjset(adj)){ ///@Question 为什么第二个条件和第三个条件也需要？ 
        return true;
    }
    return false;
}

/// @brief 实现保守合并启发式的函数
/// @param nodes 
/// @return bool
bool Conservative(std::list<_Node> &nodes){
    int total=0;//冲突结点的高度数结点个数
    for(auto& node:nodes){
        if(node.degree>=K)
        total++;
    }
    return (total<K);//如果该节点的冲突高度数结点数小于K则可以合并（Briggs）
}

/// @brief 利用briggs启发式函数来判断
/// @param u,v
/// @return bool
bool ConservativeCoalesce(_Node& u,_Node& v){
    std::list<_Node> list_1=Adjacent(u);
    std::list<_Node> list_2=Adjacent(v);
    //首先需要合并两个list，并确保合并后的list每个元素是唯一的
    std::list<_Node> Merg;
    std::unordered_set<_Node> Uniq;
    for(auto& elem:list_1){
        if(Uniq.insert(elem).second){ //利用哈希set来去重
            Merg.emplace_back(elem);
        }
    }
    for(auto& elem:list_2){
        if(Uniq.insert(elem).second){ //利用哈希set来去重
            Merg.emplace_back(elem);
        }
    }
    return Conservative(Merg);
}



/// @brief 利用OK启发式函数判断
/// @param u,v
/// @return bool 
bool AdjOk(_Node& u,_Node& v){
    std::list<_Node> L=Adjacent(v);
    for(auto t:L){
        if(!OK(t,u))
          return false;
    }
    return true;
}