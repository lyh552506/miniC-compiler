#include "dominant.hpp"

class Gvn_Gcm {
private:
  dominance *m_dom;
  std::unordered_map<std::string, User *> Hash_Tab;
  std::unordered_map<std::string,int> ValueToNumer; //VN array
  std::set<User *> PinnedInst;
  Function* m_func;
  std::vector<BasicBlock*> RPO;
  std::unordered_set<BasicBlock*> visited;
public:
  Gvn_Gcm(dominance *dom,Function* func) : m_dom(dom), Hash_Tab{}, PinnedInst{},m_func(func) 
  {}

  void GCM();
  void GVN();
  void init_pass();
  void Schedule_Early(User *inst);
  void Schedule_Late(User *inst);
  bool IsPinned(User* inst);
  void caculateRPO(BasicBlock* bb);
  int OptConstBinary(int op,Value*a,Value* b);
};