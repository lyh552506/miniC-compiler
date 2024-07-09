#include "PeepHole.hpp"

std::vector<BackEndPass<RISCVFunction>> PeepHole::get_impl(){
    return {
        DeadCodeElimination()
    };
}

bool PeepHole::run(RISCVFunction* func){
    auto Impls=get_impl();
    bool Changed=false;
    do{
        for(auto& impl:Impls)
            Changed|=impl.run(func);
    }while(Changed);
    return true;
}