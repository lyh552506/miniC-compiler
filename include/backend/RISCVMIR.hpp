#pragma once
#include "../../include/lib/Trival.hpp"
#include "../../include/lib/MagicEnum.hpp"
#include "../../include/backend/RISCVFrameContext.hpp"
class RISCVFrame;
class RISCVFunction;
class RISCVBasicBlock;
class RISCVMIR;
/// @note RISCVMIR no longer is an MOperand for SSA is destructed
class RISCVMIR:public list_node<RISCVBasicBlock,RISCVMIR>
{
    RISCVMOperand* def = nullptr;
    std::vector<RISCVMOperand*> operands;
    public:
      enum RISCVISA {
        BeginShift,
        /// @todo need generation
        // shift left logical
        _sll,
        _slli,
        _sllw,
        _slliw,
        _srl,
        _srli,
        _srlw,
        _srliw,
        // shift right arithmetic
        _sra,
        _srai,
        _sraiw,
        _sraw,
        EndShift,

        BeginArithmetic,
        _add,
        _addi, //-2048~2047
        _addw,
        _addiw,
        _sub,
        _subw,
        _lui,
        _auipc, //?

        _max,
        _min,

        _mul,
        _mulh,
        _mulhsu,
        _mulhu,
        _mulw,

        _div,
        _divu,
        _rem,
        _remu,

        _divw,
        _remw,
        _remuw,
        EndArithmetic,

        BeginLogic,
        _xor,
        _xori,
        _or,
        _ori,
        _and,
        _andi,
        EndLogic,

        BeginComp,
        _seqz,
        _snez,
        _slt,
        _slti,
        _sltu,
        _sltiu,
        EndComp,

        BeginBranch,
        _j, // equals jal x0 ...
        /// @warning !!!CAUSION!!! condition can make it ^ 1 to get the opposite
        _beq=74,
        _bne,
        _blt,
        _bge,
        _ble,
        _bgt,
        _bltu,
        _bgeu,
        EndBranch,

        BeginJumpAndLink,
        _jalr,
        _jal,
        EndJumpAndLink,

        BeginMem,

        BeginLoadMem,
        _lb,
        _lbu,
        _lh,
        _lhu,
        _lw,
        _ld,
        EndLoadMem,

        BeginStoreMem,
        _sb,
        _sh,
        _sw,
        _sd,
        EndStoreMem,

        EndMem,

        BeginConvert,
        _sext_w,
        EndConvert,

        BeginFloat,

        BeginFloatMV,
        _fmv_w_x,
        _fmv_x_w,
        _fmv_s,
        EndFloatMV,

        BeginFloatConvert,
        _fcvt_s_w,
        _fcvt_s_wu,
        _fcvt_w_s,
        _fcvt_wu_s,
        EndFloatConvert,

        BeginFloatMem,

        BeginFloatLoadMem,
        _flw,
        _fld,
        EndFloatLoadMem,

        BeginFloatStoreMem,
        _fsw,
        _fsd,
        EndFloatStoreMem,

        EndFloatMem,

        BeginFloatArithmetic,
        _fadd_s,
        _fsub_s,
        _fmul_s,

        _fmadd_s,
        _fmsub_s,
        _fnmadd_s,
        _fnmsub_s,
        
        _fdiv_s,
        _fsqrt_s,

        _fsgnj_s,
        _fsgnjn_s,
        _fsgnjx_s,

        _fmin_s,
        _fmax_s,

        _feq_s,
        _flt_s,
        _fle_s,
        _fgt_s,
        _fge_s,

        EndFloatArithmetic,
        EndFloat,

        BeginAtomic,
        _amoadd_w_aqrl,
        EndAtomic,

        /// @brief Used for call and ret
        BeginMIRPseudo,
        mv,
        call,
        ret,
        li,

        // LocalVariableAddr <- MOperand, no register allocation
        //                      change after RA, use at most one temparary
        //                      register

        // Other address, like Global or LocalArray
        // In entry block, %vreg = LoadAddr{Global|Local}
        // For liveness analyze, only define %vreg, use doesn't matter
        // We SHOULD tell RA that this spill weight is generally low
        // It should be about 1/10 lower?(Let's consider cache hit and the inst
        // cycle it takes?) Spill : Do nothing Reload: LoadAddr{...} AddrLocal
        // <- vreg AddrGlobal <- vreg Before RA, we put all used address a
        // LoadAddr in enrty block After RA, first we do a DCE, in which we will
        // delete unnecessary LoadAddr{...} Then we change the LoadAddr into
        // Global: lui, addi
        // Local : addi reg, sp, imm or li reg \ add reg reg sp

        // LocalVariable can do this too, but not necessary
        LoadGlobalAddr,
        LoadImmReg,
        LoadLocalAddr,
        EndMIRPseudo,
        MarkDead,

        BeginPipeline,
        LoadImm12,
        LoadImm32,
        LoadFromStack,
        EndPipeline
      } opcode;
      /// @note def in the front while use in the back
      // RISCVMIR(RISCVISA,User* inst);
      // RISCVMIR(RISCVISA,RISCVMOperand*...);
      RISCVMIR(RISCVISA _isa) : opcode(_isa) {};
      RISCVMOperand *&GetDef();
      RISCVMOperand *&GetOperand(int);
      const int GetOperandSize() { return operands.size(); }
      void SetDef(RISCVMOperand *);
      void SetOperand(int, RISCVMOperand *);
      void AddOperand(RISCVMOperand *);
      void SetMopcode(RISCVISA);
      inline RISCVISA &GetOpcode() { return opcode; };
      bool isArithmetic() {
        return (EndArithmetic>opcode&&opcode>BeginArithmetic)|(EndFloatArithmetic>opcode&&opcode>BeginFloatArithmetic);
    }
    void printfull();
};

/// \p ret branchinst=nullptr
/// \p uncond falseblock=nullptr
struct Terminator{
  bool implictly=false;
  double prob2true=0.5;
  RISCVMIR* branchinst=nullptr;
  RISCVBasicBlock* trueblock=nullptr;
  RISCVBasicBlock* falseblock=nullptr;
  // This will rotate the condition and update THIS terminator
  inline void SetProb(double _p){prob2true=_p;};
  inline bool isUncond(){return falseblock==nullptr;};
  inline bool isRet(){return branchinst==nullptr;};
  void RotateCondition();
  void makeFallthrough(RISCVBasicBlock* _candidate);
};

class RISCVBasicBlock:public NamedMOperand,public mylist<RISCVBasicBlock,RISCVMIR>,public list_node<RISCVFunction,RISCVBasicBlock>
{    
    Terminator term;
    public:
    // RISCVBasicBlock();
    RISCVBasicBlock(std::string);
    static RISCVBasicBlock* CreateRISCVBasicBlock();
    void push_before_branch(RISCVMIR*);
    void printfull();
    void replace_succ(RISCVBasicBlock*,RISCVBasicBlock*);
    Terminator& getTerminator();
};

/// should we save return type here? I suppose not.
class RISCVFunction:public RISCVGlobalObject,public mylist<RISCVFunction,RISCVBasicBlock>{
    /// originally return type
    /// @todo some info like arguments doesn't need to store twice? 
    Value* func;
    // the exit bb for epilogue generation
    RISCVBasicBlock exit;
    using RISCVframe = std::unique_ptr<RISCVFrame>;
    RISCVframe frame;
    size_t max_param_size=0;
    /// @brief save the index of the params of func's paramlist that should be spilled
    std::vector<int> param_need_spill;

    std::unordered_map<RISCVMOperand*,VirRegister*> usedGlobals;
    std::unordered_map<VirRegister *, RISCVMOperand *> specialusage_remapping;

  public:
    RISCVMIR *CreateSpecialUsageMIR(RISCVMOperand *);
    inline RISCVMOperand *GetSpecialUsageMOperand(VirRegister *vreg) {
      if (specialusage_remapping.find(vreg) != specialusage_remapping.end())
        return specialusage_remapping[vreg];
      return nullptr;
    };

    Register* GetUsedGlobalMapping(RISCVMOperand*);
    RISCVFunction(Value*);
    RISCVframe& GetFrame();
    size_t GetMaxParamSize();
    void SetMaxParamSize(size_t);
    void GenerateParamNeedSpill();
    std::vector<int>& GetParamNeedSpill();
    void printfull();

    inline RISCVBasicBlock* GetEntry(){return front();};
    inline RISCVBasicBlock* GetExit(){return &exit;};
    uint64_t GetUsedPhyRegMask();
};


class RISCVFrame{
    private:
    RISCVFunction* parent;
    std::vector<std::unique_ptr<RISCVFrameObject>> frameobjs;
    size_t frame_size;
    std::vector<RISCVMOperand*> cantbespill;
    
    std::unordered_map<VirRegister*,StackRegister*> spillmap;
    public:
    RISCVFrame(RISCVFunction*);
    // StackRegister* spill(int);
    StackRegister* spill(VirRegister*);
    // StackRegister* spill(Value*);
    RISCVMIR* spill(PhyRegister*);
    RISCVMIR* load_to_preg(StackRegister*,PhyRegister*);
    std::vector<std::unique_ptr<RISCVFrameObject>>& GetFrameObjs();
    void GenerateFrame();
    void GenerateFrameHead();
    void GenerateFrameTail(); 
    void AddCantBeSpill(RISCVMOperand*);
    bool CantBeSpill(RISCVMOperand*);
};


