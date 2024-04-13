library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ExecuteBlock is
    port (
        clk : in std_logic;
        reset : in std_logic;
        AluSrc : in std_logic;
        ReadData1 : in std_logic_vector(31 downto 0);
        ReadData2 : in std_logic_vector(31 downto 0);
        Immediate : in std_logic_vector(31 downto 0);
        AluSelector : in std_logic_vector(3 downto 0);
        
        ZeroFlag : out std_logic;
        AluOut : out std_logic_vector(31 downto 0)
    );
end entity ExecuteBlock; 

architecture Behavioral of ExecuteBlock is
    component ALU is
        generic (n: integer := 32);
        port (
            A, B: in std_logic_vector(n-1 downto 0); -- Two operands
            Sel: in std_logic_vector(3 downto 0); -- Select lines
            FlagsIn: in std_logic_vector(2 downto 0); -- Flags input (Zero, Negative, Carry)
            FlagsOut: out std_logic_vector(2 downto 0); -- Flags output (Zero, Negative, Carry)
            Res: out std_logic_vector(n-1 downto 0) -- Result
        );
    end component;

    component FlagReg is
        generic (n: integer := 3);
        port (
            clk: in std_logic;
            rst: in std_logic;
            en: in std_logic;
            flag: in std_logic_vector(n-1 downto 0);
            flag_out: out std_logic_vector(n-1 downto 0)
        );
    end component;

    signal Flags: std_logic_vector(2 downto 0);
    signal FlagsOut: std_logic_vector(2 downto 0);
    signal AluIn1: std_logic_vector(31 downto 0);
    signal AluIn2: std_logic_vector(31 downto 0);
    signal TempFlags: std_logic_vector(2 downto 0);
    signal TempAluOut: std_logic_vector(31 downto 0);

begin
    TempFlags <= FlagsOut;


    AluIn1 <= ReadData1;
    AluIn2 <= immediate when AluSrc = '1' else ReadData2;

    ALU1: ALU generic map (32) port map (AluIn1, AluIn2, AluSelector, TempFlags, Flags, TempAluOut);

    FlagsReg1: FlagReg generic map (3) port map (clk, reset, '1', Flags, FlagsOut);

    ZeroFlag <= FlagsOut(0);
    AluOut <= TempAluOut;

end architecture Behavioral;


