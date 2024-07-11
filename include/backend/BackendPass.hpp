#pragma once
#include "../../include/lib/CFG.hpp"
template<typename T>
class BackEndPass{
    public:
    virtual bool run(T*)=0;
};