library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Execute is
    port (
        clk : in std_logic;
        reset : in std_logic;
        instruction : in std_logic_vector(31 downto 0);
        data1 : in std_logic_vector(31 downto 0);
        data2 : in std_logic_vector(31 downto 0);
        immediate : in std_logic_vector(31 downto 0 );
        result : out std_logic_vector(31 downto 0);
        zero : out std_logic;
        ALUSrc : in std_logic;
        RegDst : in std_logic;
        Dst : out std_logic_vector(2 downto 0);
        SigFromWB : in std_logic; -- Msh fahem eh 
        SigFromMEM : in std_logic; -- dool mn draw.io
    );
end entity Execute; 

architecture Behavioral of Execute is
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

    signal AluOut: std_logic_vector(31 downto 0);
    signal Flags: std_logic_vector(2 downto 0);
    signal FlagsOut: std_logic_vector(2 downto 0);
    signal ZeroFlag: std_logic;
    signal AluIn1: std_logic_vector(31 downto 0);
    signal AluIn2: std_logic_vector(31 downto 0);

begin

    -- MUX
    if (ALUSrc = '1') then
        AluIn2 <= immediate;
    else
        AluIn2 <= data2;
    end if;
end architecture Behavioral;


