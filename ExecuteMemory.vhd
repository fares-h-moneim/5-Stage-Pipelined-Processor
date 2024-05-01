library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ExecuteMemory is
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
        OutEnableOut : out std_logic
    );
end entity ExecuteMemory;

architecture Behavioural of ExecuteMemory is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            ZeroFlagOut <= '0';
            RegDstOut <= (others => '0');
            AluResultOut <= (others => '0');
            ReadDataOut <= (others => '0');
            ReadData2Out <= (others => '0');
            MemWriteOut <= '0';
            MemReadOut <= '0';
            MemToRegOut <= (others => '0');
            RegWriteOut <= '0';
            RegWrite2Out <= '0';
            SpPointersOut <= (others => '0');
            ProtectWriteOut <= '0';
            FreeWriteOut <= '0';
            BranchingOut <= '0';
            Instruction_Src1Out <= (others => '0');
            Instruction_Src2Out <= (others => '0');
            InPortOut <= (others => '0');
            OutEnableOut <= '0';
        elsif rising_edge(clk) then
            ZeroFlagOut <= ZeroFlagIn;
            RegDstOut <= RegDst;
            AluResultOut <= AluResultIn;
            ReadDataOut <= ReadData;
            ReadData2Out <= ReadData2;
            MemWriteOut <= MemWrite;
            MemReadOut <= MemRead;
            MemToRegOut <= MemToReg;
            RegWriteOut <= RegWrite;
            RegWrite2Out <= RegWrite2;
            SpPointersOut <= SpPointers;
            ProtectWriteOut <= ProtectWrite;
            FreeWriteOut <= FreeWrite;
            BranchingOut <= Branching;
            Instruction_Src1Out <= Instruction_Src1;
            Instruction_Src2Out <= Instruction_Src2;
            InPortOut <= InPort;
            OutEnableOut <= OutEnable;
        end if;
    end process;
end Behavioural;