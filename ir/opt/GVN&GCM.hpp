#include"dominant.hpp"


class Gvn_Gcm{
private:
   dominance* m_dom;
   
public:
   Gvn_Gcm()=default;
   
   void GCM();

   void GVN();
    
   void init_pass();

   void Schedule_Early(User* inst);

   void Schedule_Late(User* inst);
};