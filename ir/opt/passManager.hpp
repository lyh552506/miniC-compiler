#pragma once
#include "ConstantFold.hpp"
#include "ConstantProp.hpp"
#include "GVN.hpp"
#include "IDF.hpp"
#include "LivenessAnalysis.hpp"
#include "PromoteMemtoRegister.hpp"
#include "SSAPRE.hpp"
#include "dominant.hpp"
#include "DCE.hpp"
#include "ADCE.hpp"

class PassManager {
public:
  PassManager() : InitpassRecorder(50) {}

  void IncludePass(int pass);

  void Init_Pass();

  void print_result();

private:
  std::vector<int> InitpassRecorder;
  std::vector<Function*> FList;
};