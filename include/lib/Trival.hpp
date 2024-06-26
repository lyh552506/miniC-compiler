#pragma once
#include "CFG.hpp"

namespace Trival{
    bool check_builtin(std::string id);
    User* GenerateCallInst(std::string id,std::vector<Operand> args);
    /// @brief transform any buildin fuction so that it can be assembled and linked correctly
    /// @return return the new callinst 
    CallInst* BuildInTransform(CallInst*);
};