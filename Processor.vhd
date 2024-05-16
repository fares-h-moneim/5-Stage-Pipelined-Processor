library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processor is
    port (
        Clk, Rst : in std_logic;
        interrupt : in std_logic;
        InPort : in std_logic_vector(31 downto 0);
        OutPort : out std_logic_vector(31 downto 0);
        Exception : out std_logic
    );
end entity Processor;

architecture Behavioral of Processor is
    ------------- Fetch ------------
    component FetchBlock is
        port (
            clk : in std_logic;
            rst : in std_logic;
            interrupt : in std_logic;
            instruction : OUT std_logic_vector(15 DOWNTO 0);
            PCOUT : OUT std_logic_vector(31 DOWNTO 0);
            changePCDecode : IN std_logic;
            changePCExecute : IN std_logic;
            newPCDecode : IN std_logic_vector(31 DOWNTO 0);
            newPCExecute : IN std_logic_vector(31 DOWNTO 0);
            changePCFromException : IN std_logic;
            changePCFromRet : IN std_logic;
            newPCFromRet : IN std_logic_vector(31 DOWNTO 0)
        );
    end component FetchBlock;

    component FetchDecode is
        port(
            clk: in std_logic;
            reset: in std_logic;
            instructionIn: in std_logic_vector(15 downto 0);
            instructionOut: out std_logic_vector(15 downto 0);
            InPort: in std_logic_vector(31 downto 0);
            InPortOut: out std_logic_vector(31 downto 0);
            PCIN : in std_logic_vector(31 downto 0);
            PCOUT : out std_logic_vector(31 downto 0);
            flushDecodeRETfromDecode, flushDecodeRETfromExecute, flushDecodeRETfromMemory, flush_decode_branching1, flush_decode_branching2 : IN std_logic;
            flush_exception_until_execute : IN std_logic;
            flush_exception_until_write_back : IN std_logic
        );
    end component FetchDecode;

    ------------- Decode ------------
    component DecodeBlock is
        port(
            clk : IN std_logic;
            reset : IN std_logic;
            we : IN std_logic;
            we2 : IN std_logic;
            w_address : IN std_logic_vector(2 DOWNTO 0);
            w_address2 : IN std_logic_vector(2 DOWNTO 0);
            r_address1 : IN std_logic_vector(2 DOWNTO 0);
            r_address2 : IN std_logic_vector(2 DOWNTO 0);
            data_in   : IN std_logic_vector(31 DOWNTO 0);
            data_in2   : IN std_logic_vector(31 DOWNTO 0);
            dataout_1 : OUT std_logic_vector(31 DOWNTO 0);
            dataout_2 : OUT std_logic_vector(31 DOWNTO 0);
            Opcode : in std_logic_vector(5 downto 0);
            IsInstructionIn : in std_logic;
            AluSelector : out std_logic_vector(3 downto 0);
            AluSrc : out std_logic;
            MemWrite : out std_logic;
            MemRead : out std_logic;
            MemToReg : out std_logic_vector(1 downto 0);
            RegWrite : out std_logic;
            RegWrite2 : out std_logic;
            SpPointers : out std_logic_vector(1 downto 0);
            ProtectWrite : out std_logic;
            FreeWrite : out std_logic;
            Branching : out std_logic;
            IsInstructionOut : out std_logic;
            OutEnable: out std_logic;
            ConditionalBranch : out std_logic;
            UnConditionalBranch : out std_logic;
            PCIN : in std_logic_vector(31 downto 0);
            PCOUT : out std_logic_vector(31 downto 0);
            RegRead1 : out std_logic;
            RegRead2 : out std_logic;
            InPortInstruction : out std_logic;
            call_signal : out std_logic;
            RET : out std_logic
        );
    end component DecodeBlock;
    component RegisterFile is
        port(
            clk : IN std_logic;
            reset : IN std_logic;
            we : IN std_logic;
            we2 : IN std_logic;
            w_address : IN std_logic_vector(2 DOWNTO 0);
            w_address2 : IN std_logic_vector(2 DOWNTO 0);
            r_address1 : IN std_logic_vector(2 DOWNTO 0);
            r_address2 : IN std_logic_vector(2 DOWNTO 0);
            data_in   : IN std_logic_vector(31 DOWNTO 0);
            data_in2 : IN std_logic_vector(31 DOWNTO 0);
            dataout_1 : OUT std_logic_vector(31 DOWNTO 0);
            dataout_2 : OUT std_logic_vector(31 DOWNTO 0)
        );
    end component RegisterFile;

    component SignExtend is 
        port(
            input : in std_logic_vector(15 downto 0);
            output : out std_logic_vector(31 downto 0);
            Opcode : in std_logic_vector(5 downto 0)
        );
    end component SignExtend;

    component DecodeExecute is
        port(
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            AluSelector : IN std_logic_vector(3 downto 0);
            AluSrc : IN std_logic;
            MemWrite : IN std_logic;
            MemRead : IN std_logic;
            MemToReg : IN std_logic_vector(1 downto 0);
            RegWrite : IN std_logic;
            RegWrite2 : IN std_logic;
            SpPointers : IN std_logic_vector(1 downto 0);
            ProtectWrite : IN std_logic;
            FreeWrite : IN std_logic;
            Branching : IN std_logic;
            ReadData1 : IN std_logic_vector(31 downto 0);
            ReadData2 : IN std_logic_vector(31 downto 0);
            Instruction_Src1 : IN std_logic_vector(2 downto 0);
            Instruction_Src2 : IN std_logic_vector(2 downto 0);
            Destination : IN std_logic_vector(2 downto 0);
            Imm : IN std_logic_vector(31 downto 0);
            InPort : IN std_logic_vector(31 downto 0);
            OutEnable : In std_logic;
            ReadReg1 : IN std_logic;
            ReadReg2 : IN std_logic;
            InPortInstruction : IN std_logic;
            RTI : IN std_logic;

            AluSelectorOut : OUT std_logic_vector(3 downto 0);
            AluSrcOut : OUT std_logic;
            MemWriteOut : OUT std_logic;
            MemReadOut : OUT std_logic;
            MemToRegOut : OUT std_logic_vector(1 downto 0);
            RegWriteOut : OUT std_logic;
            RegWrite2Out : OUT std_logic;
            SpPointersOut : OUT std_logic_vector(1 downto 0);
            ProtectWriteOut : OUT std_logic;
            FreeWriteOut : OUT std_logic;
            BranchingOut : OUT std_logic;
            ReadData1Out : OUT std_logic_vector(31 downto 0);
            ReadData2Out : OUT std_logic_vector(31 downto 0);
            Instruction_Src1Out : OUT std_logic_vector(2 downto 0);
            Instruction_Src2Out : OUT std_logic_vector(2 downto 0);
            DestinationOut : OUT std_logic_vector(2 downto 0);
            ImmOut : OUT std_logic_vector(31 downto 0);
            InPortOut : OUT std_logic_vector(31 downto 0);
            OutEnableOut : OUT std_logic;
            ReadReg1Out : OUT std_logic;
            ReadReg2Out : OUT std_logic;
            InPortInstructionOut : OUT std_logic;
            PCIN : IN std_logic_vector(31 downto 0);
            PCOUT : OUT std_logic_vector(31 downto 0);
            ConditionalBranchIn : IN std_logic;
            ConditionalBranchOut : OUT std_logic;
            call_signal_in : IN std_logic;
            call_signal_out : OUT std_logic;
            RETIN : IN std_logic;
            RETOUT : out std_logic;
            flush_execute_branching : IN std_logic;
            flush_exception_until_execute : IN std_logic;
            flush_exception_until_write_back : IN std_logic;
            RTI_OUT : OUT std_logic
        );
    end component DecodeExecute;

    component BranchingDecodeUnit is
        port (
            reset : in std_logic;
            DisableBranching : in std_logic;
            ConditionalBranch : in std_logic; -- 1 if conditional branch
            UnConditionalBranch : in std_logic; -- 1 if unconditional branch
            BranchingAddressIn : in std_logic_vector(31 downto 0); -- the address of the branch
            Branching : in std_logic; --The prediction if T or F
            FlushDecode : out std_logic;
            ChangePC : out std_logic; -- will be 1 if i need to jump to the branch address
            BranchingAddressOut : out std_logic_vector(31 downto 0)
        );
    end component BranchingDecodeUnit;
    ------------- Execute ------------
    component ExecuteBlock is
        port (
            clk : in std_logic;
            reset : in std_logic;
            AluSrc : in std_logic;
            Sel1: in std_logic_vector(2 downto 0);
            Sel2: in std_logic_vector(2 downto 0);
            ReadData1 : in std_logic_vector(31 downto 0);
            ReadData2 : in std_logic_vector(31 downto 0);
            Immediate : in std_logic_vector(31 downto 0);
            AluSelector : in std_logic_vector(3 downto 0);
            AluResExecuteMemory : in std_logic_vector(31 downto 0);
            AluResMemoryWriteBack : in std_logic_vector(31 downto 0);
            ReadData1ExecuteMemory : in std_logic_vector(31 downto 0);
            ReadData1MemoryWriteBack : in std_logic_vector(31 downto 0);
            MemOutMemoryWriteBack : in std_logic_vector(31 downto 0);
            InPortExecuteMemory : in std_logic_vector(31 downto 0);
            InPortMemoryWriteBack : in std_logic_vector(31 downto 0);

            ZeroFlag : out std_logic;
            NegativeFlag : out std_logic;
            CarryFlag : out std_logic;
            OverflowFlag : out std_logic;
            AluOut : out std_logic_vector(31 downto 0);
            ReadDataOut : out std_logic_vector(31 downto 0);
            call_signal_in : in std_logic;
            call_signal_out : out std_logic
        );
    end component ExecuteBlock; 

    component ExecuteMemory is
        port (
            clk : in std_logic;
            reset : in std_logic;
            ZeroFlagIn : in std_logic;
            RegDst : in std_logic_vector(2 downto 0);
            AluResultIn : in std_logic_vector(31 downto 0);
            ReadData : in std_logic_vector(31 downto 0);
            ReadData2 : in std_logic_vector(31 downto 0);
            MemWrite : in std_logic;
            MemRead : in std_logic;
            MemToReg : in std_logic_vector (1 downto 0);
            RegWrite : in std_logic;
            RegWrite2 : in std_logic;
            SpPointers : in std_logic_vector(1 downto 0);
            ProtectWrite : in std_logic;
            FreeWrite : in std_logic;
            Branching : in std_logic;
            Instruction_Src1 : in std_logic_vector(2 downto 0);
            Instruction_Src2 : in std_logic_vector(2 downto 0);
            InPort : in std_logic_vector(31 downto 0);
            OutEnable : in std_logic;
            ReadReg1 : in std_logic;
            ReadReg2 : in std_logic;
            InPortInstruction : in std_logic;
            RTI : in std_logic;
    
            ZeroFlagOut : out std_logic;
            RegDstOut : out std_logic_vector(2 downto 0);
            AluResultOut : out std_logic_vector(31 downto 0);
            ReadDataOut : out std_logic_vector(31 downto 0);
            ReadData2Out : out std_logic_vector(31 downto 0);
            MemWriteOut : out std_logic;
            MemReadOut : out std_logic;
            MemToRegOut : out std_logic_vector(1 downto 0);
            RegWriteOut : out std_logic;
            RegWrite2Out : out std_logic;
            SpPointersOut : out std_logic_vector(1 downto 0);
            ProtectWriteOut : out std_logic;
            FreeWriteOut : out std_logic;
            BranchingOut : out std_logic;
            Instruction_Src1Out : out std_logic_vector(2 downto 0);
            Instruction_Src2Out : out std_logic_vector(2 downto 0);
            InPortOut : out std_logic_vector(31 downto 0);
            OutEnableOut : out std_logic;
            ReadReg1Out : out std_logic;
            ReadReg2Out : out std_logic;
            InPortInstructionOut : out std_logic;
            call_signal_in : in std_logic;
            call_signal_out : out std_logic;
            PCIN : in std_logic_vector(31 downto 0);
            PCOUT : out std_logic_vector(31 downto 0);
            RETIN : in std_logic;
            RETOUT : out std_logic;
            flush_exception_until_execute : in std_logic;
            flush_exception_until_write_back : in std_logic;
            RTI_OUT : out std_logic
        );
    end component ExecuteMemory;

    component BranchingExecuteUnit is 
    port (
        reset : in std_logic;
       -- WasPredictionDisabled : in std_logic; AZON MALHA4 LAZMA
        ZeroFlag : in std_logic;
        PCPlus1 : in std_logic_vector(31 downto 0);
        ConditionalJumpAddress : in std_logic_vector(31 downto 0);
        BranchPrediction : in std_logic;
        ConditionalJump : in std_logic;
        FlushDecode : out std_logic;
        FlushExecute : out std_logic;
        ChangePC : out std_logic;
        JumpAddress : out std_logic_vector(31 downto 0)
    );
    end component BranchingExecuteUnit;

    ------------- Memory -------------

    COMPONENT MemoryBlock IS
    PORT (
            clk : IN std_logic;
            reset : IN std_logic;
            address : IN std_logic_vector(11 DOWNTO 0);
            data_in : IN std_logic_vector(31 DOWNTO 0);
            mem_write : IN std_logic;
            mem_read : IN std_logic;
            read_data : OUT std_logic_vector(31 DOWNTO 0);
            sp_signal : IN std_logic_vector(1 DOWNTO 0);
            pc_value : IN std_logic_vector(31 DOWNTO 0);
            reg2_value : IN std_logic_vector(31 DOWNTO 0);
            protect_signal : IN std_logic;
            free_signal : IN std_logic;
            read_data_protected : OUT std_logic;
            read_data_protected_after : OUT std_logic;
            call_signal : IN std_logic;
            RETIN : IN STD_LOGIC;
            changePCRET : OUT STD_LOGIC
        );
    END COMPONENT MemoryBlock;

    COMPONENT MemoryWriteBack IS
        PORT(
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            MemToReg : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            RegWrite : IN STD_LOGIC;
            RegWrite2 : IN STD_LOGIC;
            MemoryData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            AluResult : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            RegDst : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            ReadData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Instruction_Src_1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            Instruction_Src_2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            InPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            OutEnable : IN STD_LOGIC;
            ReadReg1 : IN STD_LOGIC;
            ReadReg2 : IN STD_LOGIC;
            InPortInstruction : IN STD_LOGIC;

            MemToRegOut : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            RegWriteOut : OUT STD_LOGIC;
            RegWrite2Out : OUT STD_LOGIC;
            MemoryDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            AluResultOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            RegDstOut : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            ReadDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            Instruction_Src_1Out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            Instruction_Src_2Out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            InPortOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            OutEnableOut : OUT STD_LOGIC;
            ReadReg1Out : OUT STD_LOGIC;
            ReadReg2Out : OUT STD_LOGIC;
            InPortInstructionOut : OUT std_logic;
            RETIN : IN STD_LOGIC;
            RETOUT : OUT STD_LOGIC;
            flush_exception_until_write_back : IN STD_LOGIC
        );
    END COMPONENT MemoryWriteBack;

    ------------- Write Back ------------
    component WriteBackBlock is 
    port (
        clk : in std_logic;
        reset : in std_logic;
        MemToReg : in std_logic_vector(1 downto 0);
        MemoryOutput : in std_logic_vector(31 downto 0);
        ALUOutput : in std_logic_vector(31 downto 0);
        ReadData1 : in std_logic_vector(31 downto 0);
        InPort : in std_logic_vector(31 downto 0);
        WriteData: out std_logic_vector(31 downto 0);
        WriteData2: out std_logic_vector(31 downto 0)
    );
    end component WriteBackBlock;

    ----------- FU ------------
    component ForwardingUnit is
        port(
            DecodeExecuteSrc1 : in std_logic_vector(2 downto 0);
            DecodeExecuteSrc2 : in std_logic_vector(2 downto 0);
            DecodeExecuteRegDst1 : in std_logic_vector(2 downto 0);
            DecodeExecuteRegRead1 : in std_logic;
            DecodeExecuteRegRead2 : in std_logic;

            ExecuteMemoryRegWrite1 : in std_logic;
            ExecuteMemoryRegWrite2 : in std_logic;
            ExecuteMemoryRegDst1 : in std_logic_vector(2 downto 0);
            ExecuteMemoryRegDst2 : in std_logic_vector(2 downto 0);
            ExecuteMemoryMemToReg : in std_logic_vector(1 downto 0);

            MemoryWriteBackRegWrite1 : in std_logic;
            MemoryWriteBackRegWrite2 : in std_logic;
            MemoryWriteBackRegDst1 : in std_logic_vector(2 downto 0);
            MemoryWriteBackRegDst2 : in std_logic_vector(2 downto 0);
            MemoryWriteBackMemToReg : in std_logic_vector(1 downto 0);

            ExecuteMemoryInPort : in std_logic;
            MemoryWriteBackInPort : in std_logic;

            AluMuxSel1 : out std_logic_vector(2 downto 0); -- First Operand (ALU A)
            AluMuxSel2 : out std_logic_vector(2 downto 0) -- Second Operand (ALU B)
        );
    end component;

    ---------- Exception Handler ---------
    component ExceptionHandler is
        port(
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            overflow : IN STD_LOGIC;
            protect : IN STD_LOGIC;
            flush_exception_until_execute : OUT STD_LOGIC;
            flush_exception_until_write_back : OUT STD_LOGIC;
            exception_handler_address: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            change_pc_from_exception : OUT STD_LOGIC
        );
    end component ExceptionHandler;

    
    ----------- Signals Fetch ------------
    
    signal fetch_instruction_out : std_logic_vector(15 downto 0); -- WHAT COMES OUT OF FETCHDECODE
    signal internal_fetch_instruction : std_logic_vector(15 downto 0); -- WHAT COMES OUT OF FETCH BLOCK
    signal FetchPC : std_logic_vector(31 downto 0);

    ----------- Signals Decode ------------
    signal isRETURN : std_logic;
    signal flushDecodeRETfromDecode, flushDecodeRETfromExecute, flushDecodeRETfromMemory : std_logic;
    signal changePCfromRET : std_logic;
    signal call_signal_decode : std_logic;
    signal FetchDecodePC, DecodeBlockPC: std_logic_vector(31 downto 0); -- WHAT COMES OUT OF FETCHDECODE
    signal read_data1, read_data2 : std_logic_vector(31 downto 0); -- WHAT COMES OUT OF REGISTER FILE
    signal decode_alu_selector : std_logic_vector(3 downto 0); -- WHAT COMES OUT OF CONTROL
    signal decode_alu_src : std_logic; -- WHAT COMES OUT OF CONTROL 
    signal decode_mem_write : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_mem_read : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_mem_to_reg : std_logic_vector(1 downto 0); -- WHAT COMES OUT OF CONTROL
    signal decode_reg_write : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_sp_pointers : std_logic_vector(1 downto 0); -- WHAT COMES OUT OF CONTROL
    signal decode_protect_write : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_free_write : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_branching : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_in_port : std_logic_vector(31 downto 0); -- WHAT COMES OUT OF FETCHDECODE
    signal immediate_sign_extended : std_logic_vector(31 downto 0); -- WHAT COMES OUT OF SIGN EXTEND
    signal decode_reg_write2 : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_out_en : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_read_reg1 : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_read_reg2 : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_in : std_logic;
    signal ConditionalBranch : std_logic;
    signal UnConditionalBranch : std_logic;

    signal flush_decode : std_logic; -- WHAT COMES OUT OF BRANCHINGDECODEUNIT
    signal changePCDecode : std_logic; -- WHAT COMES OUT OF BRANCHINGDECODEUNIT
    signal branching_address_out : std_logic_vector(31 downto 0); -- WHAT COMES OUT OF BRANCHINGDECODEUNIT
    signal decode_rti : std_logic;

    ----------- Signals Execute -----------
    signal call_signal_execute : std_logic;
    signal execute_block_read_data1 : std_logic_vector(31 downto 0);

    signal ConditionalBranchExecute : std_logic;
    signal ExecuteBlockPC : std_logic_vector(31 downto 0);
    signal execute_zero_out : std_logic;
    signal execute_negative_out : std_logic;
    signal execute_carry_out : std_logic;
    signal execute_overflow_out : std_logic;
    signal execute_alu_out : std_logic_vector(31 downto 0);
    signal execute_alu_selector : std_logic_vector(3 downto 0);
    signal execute_alu_src : std_logic;
    signal execute_immediate : std_logic_vector(31 downto 0);
    signal execute_read_data1 : std_logic_vector(31 downto 0);
    signal execute_read_data2 : std_logic_vector(31 downto 0);
    signal execute_mem_write : std_logic;
    signal execute_mem_read : std_logic;
    signal execute_mem_to_reg : std_logic_vector(1 downto 0);
    signal execute_reg_write : std_logic;
    signal execute_reg_write2 : std_logic;
    signal execute_sp_pointers : std_logic_vector(1 downto 0);
    signal execute_protect_write : std_logic;
    signal execute_free_write : std_logic;
    signal execute_branching : std_logic;
    signal execute_reg_destination : std_logic_vector(2 downto 0);
    signal execute_instruction_src1 : std_logic_vector(2 downto 0);
    signal execute_instruction_src2 : std_logic_vector(2 downto 0);
    signal execute_in_port : std_logic_vector(31 downto 0);
    signal execute_out_en : std_logic;
    signal execute_read_reg1 : std_logic;
    signal execute_read_reg2 : std_logic;
    signal execute_in : std_logic;
    signal call_signal_memory, call_signal_final : std_logic;

    signal flushDecode2 : std_logic; -- WHAT COMES OUT OF BRANCHINGEXECUTEUNIT
    signal flushExecute : std_logic; -- WHAT COMES OUT OF BRANCHINGEXECUTEUNIT
    signal changePCExecute : std_logic; -- WHAT COMES OUT OF BRANCHINGEXECUTEUNIT
    signal branching_address_out2 : std_logic_vector(31 downto 0); -- WHAT COMES OUT OF BRANCHINGEXECUTEUNIT
    signal execute_rti : std_logic;

    ----------- Signals Memory ------------
    signal memory_zero_out : std_logic;
    signal memory_alu_out : std_logic_vector(31 downto 0);
    signal memory_read_data_output : std_logic_vector(31 downto 0);
    signal memory_mem_write : std_logic;
    signal memory_mem_read : std_logic;
    signal memory_mem_to_reg : std_logic_vector(1 downto 0);
    signal memory_reg_write : std_logic;
    signal memory_sp_pointers : std_logic_vector(1 downto 0);
    signal memory_protect_write : std_logic;
    signal memory_free_write : std_logic;
    signal memory_branching : std_logic;
    signal memory_read_data1 : std_logic_vector(31 downto 0);
    signal memory_read_data2 : std_logic_vector(31 downto 0);
    signal memory_reg_destination : std_logic_vector(2 downto 0);
    signal memory_reg_write2 : std_logic;
    signal memory_instruction_src1 : std_logic_vector(2 downto 0);
    signal memory_instruction_src2 : std_logic_vector(2 downto 0);
    signal memory_in_port : std_logic_vector(31 downto 0);
    signal memory_out_en : std_logic;
    signal memory_read_data_protected : std_logic;
    signal memory_read_data_protected_after : std_logic;
    signal memory_read_reg1 : std_logic;
    signal memory_read_reg2 : std_logic;
    signal memory_in : std_logic;
    signal ExecuteMemoryPC, MemoryBlockPC : std_logic_vector(31 downto 0);
    signal memory_rti : std_logic;

    --------- Signals Write Back ----------
    signal WriteBackData : std_logic_vector(31 downto 0);
    signal WriteBackData2 : std_logic_vector(31 downto 0);
    signal write_back_mem_to_reg : std_logic_vector(1 downto 0);
    signal write_back_reg_write : std_logic;
    signal write_back_reg_write2 : std_logic;
    signal write_back_data_output : std_logic_vector(31 downto 0);
    signal write_back_alu_out : std_logic_vector(31 downto 0);
    signal write_back_reg_destination : std_logic_vector(2 downto 0);
    signal write_back_read_data1 : std_logic_vector(31 downto 0);
    signal write_back_instruction_src1 : std_logic_vector(2 downto 0);
    signal write_back_instruction_src2 : std_logic_vector(2 downto 0);
    signal write_back_in_port : std_logic_vector(31 downto 0);
    signal write_back_out_en : std_logic;
    signal write_back_read_reg1 : std_logic;
    signal write_back_read_reg2 : std_logic;
    signal write_back_in : std_logic;

    ----------- Signals Forwarding ------------
    signal forwarding_sel1 : std_logic_vector(2 downto 0);
    signal forwarding_sel2 : std_logic_vector(2 downto 0);


    ----------- Signals Exception ------------
    signal flush_exception_until_execute : std_logic;
    signal flush_exception_until_write_back : std_logic;
    signal exception_handler_address : std_logic_vector(31 downto 0);
    signal change_pc_from_exception : std_logic;
    signal exception_from_protect : std_logic;


    signal IsInstructionIN: std_logic := '1';
    signal IsInstructionOUT: std_logic;
    begin
        ----------- Fetch ------------
        FetchBlock1: FetchBlock port map (
                                            Clk, Rst, interrupt, internal_fetch_instruction, FetchPC, changePCDecode, changePCExecute, branching_address_out, branching_address_out2, change_pc_from_exception, changePCfromRET, memory_read_data_output
                                        );

        FetchDecode1: FetchDecode port map (
                                            Clk, Rst, internal_fetch_instruction,
                                            fetch_instruction_out, InPort, decode_in_port, FetchPC, FetchDecodePC, flushDecodeRETfromDecode, flushDecodeRETfromExecute, flushDecodeRETfromMemory, flush_decode, flushDecode2, flush_exception_until_execute, flush_exception_until_write_back
                                        );
        
        ----------- Decode ------------
        DecodeBlock1: DecodeBlock port map (
                                            Clk, Rst, write_back_reg_write, write_back_reg_write2, write_back_reg_destination, write_back_instruction_src2,
                                            fetch_instruction_out(9 downto 7), fetch_instruction_out(3 downto 1), WriteBackData, write_back_read_data1,
                                            read_data1, read_data2, fetch_instruction_out(15 downto 10), IsInstructionIN, decode_alu_selector, decode_alu_src,
                                            decode_mem_write, decode_mem_read, decode_mem_to_reg, decode_reg_write, decode_reg_write2,
                                            decode_sp_pointers, decode_protect_write, decode_free_write, decode_branching, IsInstructionOUT, decode_out_en, ConditionalBranch, UnConditionalBranch, FetchDecodePC, DecodeBlockPC, decode_read_reg1, decode_read_reg2, decode_in, 
                                            call_signal_decode, isRETURN
                                        );

        SignExtend1: SignExtend port map (
                                            internal_fetch_instruction, immediate_sign_extended, fetch_instruction_out(15 downto 10)
                                        );


        DecodeExecute1: DecodeExecute port map (
                                                Clk, Rst, '1', decode_alu_selector,
                                                decode_alu_src, decode_mem_write, decode_mem_read,
                                                decode_mem_to_reg, decode_reg_write, decode_reg_write2, decode_sp_pointers, decode_protect_write, decode_free_write,
                                                decode_branching, read_data1, read_data2, fetch_instruction_out(9 downto 7), fetch_instruction_out(3 downto 1),
                                                fetch_instruction_out(6 downto 4), immediate_sign_extended, decode_in_port, decode_out_en, decode_read_reg1, decode_read_reg2, decode_in, decode_rti, execute_alu_selector,
                                                execute_alu_src, execute_mem_write, execute_mem_read,
                                                execute_mem_to_reg, execute_reg_write, execute_reg_write2, execute_sp_pointers,
                                                execute_protect_write, execute_free_write, execute_branching, execute_read_data1,
                                                execute_read_data2, execute_instruction_src1, execute_instruction_src2, execute_reg_destination, execute_immediate, execute_in_port, execute_out_en,  execute_read_reg1, execute_read_reg2, execute_in,
                                                DecodeBlockPC, ExecuteBlockPC, ConditionalBranch, ConditionalBranchExecute, call_signal_decode, call_signal_execute, isRETURN, flushDecodeRETfromDecode, flushExecute, flush_exception_until_execute, flush_exception_until_write_back, execute_rti
                                            );
                                            
                                            BranchingDecodeUnit1: BranchingDecodeUnit port map(
                                                Rst, '0', ConditionalBranch, UnConditionalBranch, read_data1, '0', flush_decode, changePCDecode, branching_address_out
                                            ); 
                                            --the 1 means prediction = true
                                            --need to test here
                                            -- 1. Prediction = false & Unconditional tmam
                                            -- 3. Prediction = true & Unconditional tmam
                                    
                                            -- 2. Prediction = false & Conditional msh h3ml haga tmam
                                            -- 4. Prediction = true & Conditional el mafrood a change.


        ----------- Execute ------------

        ExecuteBlock1: ExecuteBlock port map (
                                                Clk, Rst, execute_alu_src, forwarding_sel1, forwarding_sel2,
                                                execute_read_data1, execute_read_data2, execute_immediate,
                                                execute_alu_selector, memory_alu_out, write_back_alu_out, memory_read_data1, write_back_read_data1, memory_read_data_output, memory_in_port, write_back_in_port, execute_zero_out, execute_negative_out, execute_carry_out, execute_overflow_out, execute_alu_out, execute_block_read_data1,
                                                call_signal_execute, call_signal_memory
                                            );

        ExecuteMemory1: ExecuteMemory port map (
                                                Clk, Rst, execute_zero_out,
                                                execute_reg_destination, execute_alu_out, execute_block_read_data1, execute_read_data2, execute_mem_write,
                                                execute_mem_read, execute_mem_to_reg, execute_reg_write, execute_reg_write2,
                                                execute_sp_pointers, execute_protect_write, execute_free_write, execute_branching, execute_instruction_src1, execute_instruction_src2, execute_in_port, execute_out_en, execute_read_reg1, execute_read_reg2, execute_in, execute_rti,
                                                memory_zero_out, memory_reg_destination, memory_alu_out, memory_read_data1, memory_read_data2,
                                                memory_mem_write, memory_mem_read, memory_mem_to_reg,
                                                memory_reg_write, memory_reg_write2, memory_sp_pointers, memory_protect_write, memory_free_write,
                                                memory_branching, memory_instruction_src1, memory_instruction_src2, memory_in_port, memory_out_en, memory_read_reg1, memory_read_reg2, memory_in,
                                                call_signal_memory, call_signal_final, ExecuteBlockPC, MemoryBlockPC, flushDecodeRETfromDecode, flushDecodeRETfromExecute, flush_exception_until_execute, flush_exception_until_write_back, memory_rti
                                            );
        
        BranchingExecuteUnit1: BranchingExecuteUnit port map(
            Rst, execute_zero_out, ExecuteBlockPC, execute_read_data1, '0', ConditionalBranchExecute, flushDecode2, flushExecute, changePCExecute, branching_address_out2
        ); 
        -- Branch prediciton & conditional jump which i have to forward
        --need to test here
        -- 1. Prediction = false & Unconditional tmam
        -- 3. Prediction = true & Unconditional tmam

        -- 2. Prediction = false & Conditional & zero = 0 msh h3ml haga tmam
        -- 2.1 Prediction = fals & Conditional & zero = 1 i need to change tmam
        -- 4. Prediction = true & Conditional & zero = 0 i need to change
        -- 4.1 Prediction = tr  & Conditional & zero = 1 msh h3ml haga
        ----------- Memory -------------

        DataMemory1: MemoryBlock port map (
                                            Clk, Rst, memory_alu_out(11 downto 0), memory_alu_out(31 downto 0),
                                            memory_mem_write, memory_mem_read,
                                            memory_read_data_output, memory_sp_pointers,MemoryBlockPC, memory_read_data2, memory_protect_write, memory_free_write, memory_read_data_protected,
                                            memory_read_data_protected_after, call_signal_final, flushDecodeRETfromExecute, changePCfromRET
                                        );

        MemoryWriteBack1: MemoryWriteBack port map (
                                                    Clk, Rst, '1', memory_mem_to_reg,
                                                    memory_reg_write, memory_reg_write2, memory_read_data_output,
                                                    memory_alu_out, memory_reg_destination, memory_read_data1, memory_instruction_src1, memory_instruction_src2, memory_in_port, memory_out_en, memory_read_reg1, memory_read_reg2, memory_in,
                                                    write_back_mem_to_reg, write_back_reg_write,
                                                    write_back_reg_write2, write_back_data_output, write_back_alu_out,
                                                    write_back_reg_destination, write_back_read_data1, write_back_instruction_src1, write_back_instruction_src2, write_back_in_port, write_back_out_en, write_back_read_reg1, write_back_read_reg2, write_back_in,
                                                    flushDecodeRETfromExecute, flushDecodeRETfromMemory, flush_exception_until_write_back
                                                );

        ----------- Write Back ------------
        WriteBackBlock1: WriteBackBlock port map(Clk, Rst, write_back_mem_to_reg, write_back_data_output, write_back_alu_out, write_back_read_data1, write_back_in_port, WriteBackData, WriteBackData2);

        OutPort <= WriteBackData when write_back_out_en = '1' else (others => '0');

        ----------- Forwarding Unit ------------
        ForwardingUnit1: ForwardingUnit port map (
                                                    execute_instruction_src1, execute_instruction_src2, execute_reg_destination, execute_read_reg1, execute_read_reg2,
                                                    memory_reg_write, memory_reg_write2, memory_reg_destination, memory_reg_destination, memory_mem_to_reg,
                                                    write_back_reg_write, write_back_reg_write2, write_back_reg_destination, memory_reg_destination, memory_mem_to_reg,
                                                    memory_in, write_back_in, forwarding_sel1, forwarding_sel2
        );

        ----------- Exception Handler ------------
        ExceptionHandlerUnit: ExceptionHandler port map (
            Clk, Rst, execute_overflow_out,
             exception_from_protect, flush_exception_until_execute, flush_exception_until_write_back,
             exception_handler_address, change_pc_from_exception
        );

        exception_from_protect <= memory_read_data_protected_after or memory_read_data_protected;
        Exception <= change_pc_from_exception;
        process(Clk)
        begin
            if rising_edge(Clk) then
                IsInstructionIN <= IsInstructionOUT;
            end if;
        end process;
end architecture Behavioral;