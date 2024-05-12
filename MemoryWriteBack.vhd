library ieee;
use ieee.std_logic_1164.all;

ENTITY MemoryWriteBack IS
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
        Instruction_Src_1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Instruction_Src_2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ReadData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        InPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        OutEnable : IN STD_LOGIC;
        ReadReg1 : in std_logic;
        ReadReg2 : in std_logic;
        InPortInstruction : IN std_logic;

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
        ReadReg1Out : out std_logic;
        ReadReg2Out : out std_logic;
        InPortInstructionOut : OUT std_logic
    );
END MemoryWriteBack;

ARCHITECTURE MemoryWriteBack OF MemoryWriteBack IS
    
BEGIN
    PROCESS (clk, reset, enable)
    BEGIN
        IF reset = '1' THEN
            MemToRegOut <= (OTHERS => '0');
            RegWriteOut <= '0';
            RegWrite2Out <= '0';
            MemoryDataOut <= (OTHERS => '0');
            AluResultOut <= (OTHERS => '0');
            RegDstOut <= (OTHERS => '0');
            ReadDataOut <= (OTHERS => '0');
            Instruction_Src_1Out <= (OTHERS => '0');
            Instruction_Src_2Out <= (OTHERS => '0');
            InPortOut <= (OTHERS => '0');
            OutEnableOut <= '0';
            ReadReg1Out <= '0';
            ReadReg2Out <= '0';
            InPortInstructionOut <= '0';
        ELSIF rising_edge(clk) THEN
            IF enable = '1' THEN
                MemToRegOut <= MemToReg;
                RegWriteOut <= RegWrite;
                RegWrite2Out <= RegWrite2;
                MemoryDataOut <= MemoryData;
                AluResultOut <= AluResult;
                ReadDataOut <= ReadData;
                RegDstOut <= RegDst;
                Instruction_Src_1Out <= Instruction_Src_1;
                Instruction_Src_2Out <= Instruction_Src_2;
                InPortOut <= InPort;
                OutEnableOut <= OutEnable;
                ReadReg1Out <= ReadReg1;
                ReadReg2Out <= ReadReg2;
                InPortInstructionOut <= InPortInstruction;
            END IF;
    END IF;
    END PROCESS;
    
END MemoryWriteBack;

