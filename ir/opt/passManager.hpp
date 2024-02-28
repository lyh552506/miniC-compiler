#include"dominant.hpp"
#include"ConstantFold.hpp"
#include"GVN&GCM.hpp"
#include"IDF.hpp"
#include"LivenessAnalysis.hpp"
#include"PromoteMemtoRegister.hpp"


class PassManager{
public:
   PassManager():InitpassRecorder(4){}

   void IncludePass(int pass);

   void Init_Pass();
private:
   std::vector<int> InitpassRecorder;
};