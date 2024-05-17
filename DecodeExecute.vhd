library ieee;
use ieee.std_logic_1164.all;

ENTITY DecodeExecute IS
    PORT(
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
        ReadData1 : IN std_logic_vector(31 downto 0); -- Register src 1
        ReadData2 : IN std_logic_vector(31 downto 0); -- Register src 2
        Instruction_Src1 : IN std_logic_vector(2 downto 0);
        Instruction_Src2 : IN std_logic_vector(2 downto 0);
        Destination : IN std_logic_vector(2 downto 0); -- Register destination address
        Imm : IN std_logic_vector(31 downto 0);
        InPort : IN std_logic_vector(31 downto 0);
        OutEnable : IN std_logic;
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
        RTI_OUT : OUT std_logic;
        interrupt_signalin : in std_logic;
        interrupt_signalout : out std_logic;
        instruction_opcode : in std_logic_vector(5 downto 0);
        instruction_opcode_out : out std_logic_vector(5 downto 0);
        disable_branching : in std_logic;
        disable_branching_out : out std_logic;
        predictIN : in std_logic;
        predictOUT : out std_logic;
        unconditional_branch : in std_logic;
        unconditional_branch_out : out std_logic
    );
END DecodeExecute;

ARCHITECTURE DecodeExecute OF DecodeExecute IS
    
BEGIN
    PROCESS (clk, reset, enable)
    BEGIN
        IF reset = '1' or (flush_execute_branching = '1' and falling_edge(clk)) or (flush_exception_until_execute = '1' and rising_edge(clk)) or (flush_exception_until_write_back = '1' and rising_edge(clk)) THEN
            AluSelectorOut <= "1001";
            AluSrcOut <= '0';
            MemWriteOut <= '0';
            MemReadOut <= '0';
            MemToRegOut <= (OTHERS=>'0');
            RegWriteOut <= '0';
            RegWrite2Out <= '0';
            SpPointersOut <= (OTHERS=>'0');
            ProtectWriteOut <= '0';
            FreeWriteOut <= '0';
            BranchingOut <= '0';
            ReadData1Out <= (OTHERS=>'0');
            ReadData2Out <= (OTHERS=>'0');
            DestinationOut <= (OTHERS=>'0');
            Instruction_Src1Out <= (OTHERS=>'0');
            Instruction_Src2Out <= (OTHERS=>'0');
            ImmOut <= (OTHERS=>'0');
            InPortOut <= (OTHERS=>'0');
            OutEnableOut <= '0';
            ReadReg1Out <= '0';
            ReadReg2Out <= '0';
            InPortInstructionOut <= '0';
            RTI_OUT <= '0';
        ELSIF rising_edge(clk) THEN
            IF enable = '1' THEN
                AluSelectorOut <= AluSelector;
                AluSrcOut <= AluSrc;
                MemWriteOut <= MemWrite;
                MemReadOut <= MemRead;
                MemToRegOut <= MemToReg;
                RegWriteOut <= RegWrite;
                RegWrite2Out <= RegWrite2;
                SpPointersOut <= SpPointers;
                ProtectWriteOut <= ProtectWrite;
                FreeWriteOut <= FreeWrite;
                BranchingOut <= Branching;
                ReadData1Out <= ReadData1;
                ReadData2Out <= ReadData2;
                DestinationOut <= Destination;
                Instruction_Src1Out <= Instruction_Src1;
                Instruction_Src2Out <= Instruction_Src2;
                ImmOut <= Imm;
                InPortOut <= InPort;
                OutEnableOut <= OutEnable;
                ReadReg1Out <= ReadReg1;
                ReadReg2Out <= ReadReg2;
                InPortInstructionOut <= InPortInstruction;
                PCOUT <= PCIN;
                ConditionalBranchOut <= ConditionalBranchIn;
                call_signal_out <= call_signal_in;
                RETOUT <= RETIN;
                RTI_OUT <= RTI;
                interrupt_signalout <= interrupt_signalin;
                instruction_opcode_out <= instruction_opcode;
                disable_branching_out <= disable_branching;
                predictOUT <= predictIN;
                unconditional_branch_out <= unconditional_branch;
            END IF;
        END IF;
    END PROCESS;
    
END DecodeExecute;
