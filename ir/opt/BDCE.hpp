#include "CFG.hpp"

class DCE
{
public:
    void Pass();
    DCE() = default;
private:
    bool RunOnBlock(BasicBlock* block);
    bool isDeadInst(User* inst);
    bool DCEInst(User* inst, std::vector<User*> Worklist);
};