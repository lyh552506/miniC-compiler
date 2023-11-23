#include<unordered_set>
#include"livenessalysis.hpp"


struct Instruction{
//zz实现
};

class _simplifyWQorkLists{
public:
    _simplifyWQorkLists()=default;

    std::unordered_set<_Node> GetLists(){

        return list;
    }

private:
    std::unordered_set<_Node> list{};
}

/// @brief 节点类
class _Node{
    
};


//TODO 首先构造冲突图，把每个节点分为传送有关和传送无关
void Build();



