#include "CFG.hpp"
#include <set>
class ADCE
{
public:
    void Pass();
private:
    Function* _func;
    std::vector<Function*> flist;
    void AgressiveDCE(Function* func);
    void SetInstAliveRelation(User* inst);
public:
    ADCE(std::vector<Function*> flist_) : flist(flist_) {}
};