#include "New_passManager.hpp"

// template <typename Pass, typename DerivedT>
// bool _PassManager<Pass, DerivedT>::Run(DerivedT base,
//                                        _AnalysisManager<Pass, DerivedT> &AM) {
//   return true;
// }

// template <typename Pass, typename DerivedT>
// void _PassManager<Pass, DerivedT>::DecodeArgs(int argc, char *argv[]) {
//   int optionIndex, option;
//   while ((option = getopt_long(argc, argv, "", long_options, &optionIndex)) !=
//          -1) {
//     switch (option) {
//     default:
//       std::cerr << "No Such Opt!" << std::endl;
//       exit(0);
//     case mem2reg:
//       AddPass(mem2reg);
//       break;
//     case pre:
//       AddPass(pre);
//       break;
//     case constprop:
//       AddPass(constprop);
//       break;
//     case dce:
//       AddPass(dce);
//       break;
//     case simplifycfg:
//       AddPass(simplifycfg);
//       break;
//     case Inline:
//       AddPass(Inline);
//       break;
//     case global2local:
//       AddPass(global2local);
//       break;
//     case reassociate:
//       AddPass(reassociate);
//       break;
//     case cse:
//       AddPass(cse);
//       break;
//     case lcssa:
//       AddPass(lcssa);
//       break;
//     case licm:
//       AddPass(licm);
//       break;
//     case looprotate:
//       AddPass(looprotate);
//       break;
//     }
//   }
// }


// const Pass *_AnalysisManager<Pass, DerivedT>::get(DerivedT Base) {
//   return static_cast<Pass *>(GetResult(Base));
// }