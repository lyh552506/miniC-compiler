#include "BuildInFunctionTransform.hpp"
#include "Trival.hpp"

bool BuildInFunctionTransform::run(Function* func){
    for(auto bb:*func)
        for(auto inst:*bb)
            if(auto call=dynamic_cast<CallInst*>(inst))
                Trival::BuildInTransform(call);
    return true;
}