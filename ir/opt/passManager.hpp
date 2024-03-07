#include"dominant.hpp"
#include"ConstantProp.hpp"
#include"GVN.hpp"
#include"IDF.hpp"
#include"LivenessAnalysis.hpp"
#include"PromoteMemtoRegister.hpp"


class PassManager {
public:
   PassManager():InitpassRecorder(6){}

  void IncludePass(int pass);

  void Init_Pass();

  void print_result();

private:
  std::vector<int> InitpassRecorder;
};