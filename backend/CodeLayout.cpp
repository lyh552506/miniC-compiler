#include "../include/backend/CodeLayout.hpp"
#include <cmath>

std::vector<double> CodeLayout::getFreq(std::vector<std::vector<double>>& mat,int size){
    auto dumpMat=[&](){
        std::cerr<<"Mat:\n";
        for(auto i=0;i<size;i++){
            for(auto j=0;j<=size;j++)
                std::cerr<<mat[i][j]<<" ";
            std::cerr<<"\n";
        }
    };

    // dumpMat();

    const double eps=1e-6;
    int Rank=0;
    for(int j=0;j<size;j++){
        // dumpMat();
		int loc=-1;
		for(int i=Rank;i<size;i++){
			if(fabs(mat[i][j])>eps){
				loc=i;
				break;
			}
		}
		if(loc==-1)
			continue;
        if(Rank!=loc)
            swap(mat[Rank],mat[loc]);

		for(int i=0;i<size;i++){
			if(i==Rank)continue;
			double temp=-mat[i][j]/mat[Rank][j];
			for(int jj=j;jj<=size;jj++)
				mat[i][jj]+=temp*mat[Rank][jj];
		}

        Rank++;
	}

    assert(Rank==size&&"Matrix is not full rank");

    auto freq=std::vector<double>(size);
    
    for(int j=0;j<size;j++)
        freq[j]=mat[j][size]/mat[j][j];

    auto dumpResult=[&](){
        std::cerr<<"Result:\n";
        for(auto j=0;j<size;j++)
            std::cerr<<freq[j]<<" ";
        std::cerr<<"\n";
    };

    // dumpResult();

    for(auto i=0;i<size;i++)
        assert(freq[i]>=0&&"Negative frequency");
    
    return freq;
}

bool CodeLayout::run(RISCVFunction* func){
    // An alternative way is to use loop depth directly as block frequency
    /* begin get block freq */
    auto size=func->Size();
    if(size>1000){
        // It was at this moment he knew, he fucked up.
        return false;
    }
    auto mat=std::vector<std::vector<double>>(size,std::vector<double>(size+1));
    auto add_edge=[&](auto i,auto j,auto prob){mat[j][i]-=prob;};
    auto block2num=std::unordered_map<RISCVBasicBlock*,int>();
    auto num2block=std::vector<RISCVBasicBlock*>(size);
    auto getNum=[&](auto bb){return block2num[bb];};
    auto getBB=[&](auto num){return num2block[num];};
    
    for(auto i=0;i<size;i++)
        mat[i][i]=1;
    
    mat[0][0]+=1;mat[0][size]=2;
    auto rec=0;
    for(auto bb:*func){
        block2num[bb]=rec;
        num2block[rec]=bb;
        rec++;
    }
    
    for(auto bb:*func){
        auto terminator=bb->getTerminator();
        if(terminator.isRet())continue;
        auto u=getNum(bb);
        auto v=getNum(terminator.trueblock);
        add_edge(u,v,terminator.prob2true);
        if(terminator.falseblock){
            v=getNum(terminator.falseblock);
            add_edge(u,v,1-terminator.prob2true);
        }
    }
    auto freq=getFreq(mat,size);
    /* end get block freq*/
    
    /* begin get order */
    // 按边的大小排序，按类似kruscal的方法跑一个最大生成链群
    struct EdgeInfo{
        double weight;
        int u,v;
    };
    struct BlockChain{
        std::list<int> chain;
        int prio=INT32_MAX;
    };

    std::vector<EdgeInfo> edgeinfo;
    for(auto bb:*func){
        auto terminator=bb->getTerminator();
        if(terminator.isRet())continue;
        auto u=getNum(bb);
        auto v=getNum(terminator.trueblock);
        edgeinfo.push_back({freq[u]*terminator.prob2true,u,v});
        if(terminator.falseblock){
            v=getNum(terminator.falseblock);
            edgeinfo.push_back({(1-terminator.prob2true)*freq[u],u,v});
        }
    }

    std::vector<BlockChain> chains(size);
    std::vector<int> fat(size);

    std::function<int(int)> findFat=[&](int x){
        if(x==fat[x])return x;
        return fat[x]=findFat(fat[x]);
    };
    
    for(auto i=0;i<size;i++){
        fat[i]=i;
        chains[i].chain.push_back(i);
        chains[i].prio=size<<1;
    }

    std::sort(edgeinfo.begin(),edgeinfo.end(),[](auto a,auto b){return a.weight>b.weight;});

    auto priocnt=0;
    for(auto& edge:edgeinfo){
        auto u=edge.u,v=edge.v;
        auto fu=findFat(u),fv=findFat(v);
        if(fu==fv)continue; //自环
        if(v!=chains[fv].chain.front())continue; //是不是尾接头
        if(u!=chains[fu].chain.back())continue;
        chains[fu].chain.splice(chains[fu].chain.end(),chains[fv].chain);
        chains[fv].chain.clear();
        chains[fu].prio=std::min(std::min(chains[fu].prio,chains[fv].prio),priocnt++);
        chains[fv].prio=INT32_MAX;
        fat[fv]=fu;
    }

    std::sort(chains.begin(),chains.end(),[](auto a,auto b){
        return a.prio<b.prio;
    });

    std::list<int> bestorder;
    for(auto& chain:chains){
        if(chain.chain.empty())continue;;
        if(getBB(chain.chain.front())==func->front())bestorder.splice(bestorder.end(),chain.chain);
    }
    for(auto& chain:chains){
        if(chain.chain.empty())continue;;
        if(getBB(chain.chain.front())!=func->front())bestorder.splice(bestorder.end(),chain.chain);
    }
    /* end get order */
    // make sure entry block will be the first
    assert(getBB(bestorder.front())==func->front());
    /* begin rotate branches and reordering */
    for(auto it=bestorder.begin();;it++){
        auto nxt=std::next(it);
        if(nxt==bestorder.end())break;
        auto bb=getBB(*it);
        auto bestnext=getBB(*nxt);
        auto terminator=bb->getTerminator();
        if(terminator.isRet())continue;
        if(terminator.trueblock==bestnext||terminator.falseblock==bestnext)
            terminator.makeFallthrough(bestnext);
    }

    for(auto it=bestorder.begin();it!=bestorder.end();it++){
        auto bb=getBB(*it);
        bb->EraseFromParent();
    }

    assert(func->Size()==0);

    for(auto it=bestorder.begin();it!=bestorder.end();it++){
        auto bb=getBB(*it);
        func->push_back(bb);
    }
    /* end rotate branches and reordering */
    return false;
}