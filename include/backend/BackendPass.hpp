#pragma once
#include "CFG.hpp"
template<typename T>
class BackEndPass{
    public:
    virtual bool run(T*)=0;
};