library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ExecuteMemory is
    port (
        clk : in std_logic;
        reset : in std_logic;
        ZeroFlagIn : in std_logic;
        AluResultIn : in std_logic_vector(31 downto 0);
        ReadData2 : out std_logic_vector(31 downto 0);
        MemWrite : in std_logic;
        MemRead : in std_logic;
        MemToReg : in std_logic_vector (1 downto 0);
        RegWrite : in std_logic;
        SpPointers : in std_logic_vector(31 downto 0);
        ProtectWrite : in std_logic;
        Branching : in std_logic;

        ZeroFlagOut : out std_logic;
        AluResultOut : out std_logic_vector(31 downto 0);
        ReadData2Out : out std_logic_vector(31 downto 0);
        MemWriteOut : out std_logic;
        MemReadOut : out std_logic;
        MemToRegOut : out std_logic_vector(1 downto 0);
        RegWriteOut : out std_logic;
        SpPointersOut : out std_logic_vector(31 downto 0);
        ProtectWriteOut : out std_logic;
        BranchingOut : out std_logic
    );
end entity ExecuteMemory;

architecture Behavioural of ExecuteMemory is
    process(clk, reset)
    begin
        if reset = '1' then
            ZeroFlagOut <= '0';
            AluResultOut <= (others => '0');
            ReadData2Out <= (others => '0');
            MemWriteOut <= '0';
            MemReadOut <= '0';
            MemToRegOut <= (others => '0');
            RegWriteOut <= '0';
            SpPointersOut <= (others => '0');
            ProtectWriteOut <= '0';
            BranchingOut <= '0';
        elsif rising_edge(clk) then
            ZeroFlagOut <= ZeroFlagIn;
            AluResultOut <= AluResultIn;
            ReadData2Out <= ReadData2;
            MemWriteOut <= MemWrite;
            MemReadOut <= MemRead;
            MemToRegOut <= MemToReg;
            RegWriteOut <= RegWrite;
            SpPointersOut <= SpPointers;
            ProtectWriteOut <= ProtectWrite;
            BranchingOut <= Branching;
        end if;
    end process;
end Behavioural;