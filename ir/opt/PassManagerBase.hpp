#pragma once

class PassManagerBase{
public:
    PassManagerBase()=default;
    virtual void RunOnFunction()=0;
    virtual void InitPass(){};
    virtual void PrintPass()=0;
};