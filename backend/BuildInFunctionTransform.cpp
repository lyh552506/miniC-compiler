#include "../include/backend/BuildInFunctionTransform.hpp"
#include "../include/lib/Trival.hpp"

bool BuildInFunctionTransform::run(Function* func){
    for(auto bb:*func)
        for(auto it=bb->begin();it!=bb->end();++it){
            auto inst=*it;
            if(auto call=dynamic_cast<CallInst*>(inst))
                inst=Trival::BuildInTransform(call);
            it=mylist<BasicBlock,User>::iterator(inst);
        }
    return true;
}