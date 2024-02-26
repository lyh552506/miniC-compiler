#include "dominant.hpp"

class Gvn_Gcm {
private:
  dominance *m_dom;
  std::unordered_map<std::string, User *> Hash_Tab;
  std::unordered_map<std::string,int> ValueToNumer; //VN array
  std::set<User *> PinnedInst;

public:
  Gvn_Gcm(dominance *dom) : m_dom(dom), Hash_Tab{}, PinnedInst{} {}

  void GCM();

  void GVN();

  void init_pass();

  void Schedule_Early(User *inst);

  void Schedule_Late(User *inst);
};