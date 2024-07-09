#pragma once
#include "DeadCodeElimination.hpp"

// Peephole will loop inside, so just call peepholer.run().
class PeepHole : public BackEndPass<RISCVFunction> {
    /// @note Inner code better reduce the code size only.
    using Generic_PeepHole_Pass=BackEndPass<RISCVFunction>;
    static std::vector<Generic_PeepHole_Pass> get_impl();
    public:
    bool run(RISCVFunction*);
};