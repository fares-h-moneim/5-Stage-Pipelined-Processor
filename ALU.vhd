library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    generic (n: integer := 32);
    port (
        A, B: in std_logic_vector(n-1 downto 0); -- Two operands
        Sel: in std_logic_vector(3 downto 0); -- Select lines
        FlagsIn: in std_logic_vector(2 downto 0); -- Flags input (Zero, Negative, Carry)
        FlagsOut: out std_logic_vector(2 downto 0); -- Flags output (Zero, Negative, Carry)
        Res: out std_logic_vector(n-1 downto 0) -- Result
    );
end entity ALU;

architecture Behavioral of ALU is
    -- Operations

    constant ALU_NOT : std_logic_vector(3 downto 0) := "0000";
    constant ALU_NEG : std_logic_vector(3 downto 0) := "0001";
    constant ALU_INC : std_logic_vector(3 downto 0) := "0010";
    constant ALU_DEC : std_logic_vector(3 downto 0) := "0011";
    constant ALU_ADD : std_logic_vector(3 downto 0) := "0100";
    constant ALU_SUB : std_logic_vector(3 downto 0) := "0101";
    constant ALU_OR : std_logic_vector(3 downto 0) := "0110";
    constant ALU_XOR : std_logic_vector(3 downto 0) := "0111";
    constant ALU_AND : std_logic_vector(3 downto 0) := "1000";
    constant ALU_CMP : std_logic_vector(3 downto 0) := "1011";
    constant ALU_A : std_logic_vector(3 downto 0) := "1001"; -- Output readdata1
    constant ALU_B : std_logic_vector(3 downto 0) := "1110"; -- output readdata2 or immediate
    

    signal TempOut : std_logic_vector(n downto 0);
    signal TempA, TempB:std_logic_vector(n downto 0);
    
    Begin
    
    TempA <= '0' & A(n-1 DOWNTO 0);
    TempB <= '0' & B(n-1 DOWNTO 0);
    
    
    TempOut <= NOT TempA when Sel = ALU_NOT
    else std_logic_vector(0 - signed(TempA))                 when Sel = ALU_NEG
    else std_logic_vector(unsigned(TempA) + 1)               when Sel = ALU_INC
    else std_logic_vector(unsigned(TempA) - 1)               when Sel = ALU_DEC 
    else std_logic_vector(unsigned(TempA) + unsigned(TempB)) when Sel = ALU_ADD
    else std_logic_vector(unsigned(TempA) - unsigned(TempB)) when Sel = ALU_SUB or Sel = ALU_CMP
    else  TempA or  TempB                                    when Sel = ALU_OR
    else  TempA xor TempB                                    when Sel = ALU_XOR
    else  TempA and TempB                                    when Sel = ALU_AND
    else  TempA                                              when Sel = ALU_A
    else  TempB                                              when Sel = ALU_B
    else (others => '0');

    FlagsOut(0) <= '1'  when (Sel = ALU_NOT or Sel = ALU_NEG or Sel = ALU_INC or Sel = ALU_DEC or Sel = ALU_ADD or Sel = ALU_SUB or Sel = ALU_CMP or Sel = ALU_OR or Sel = ALU_XOR or Sel = ALU_AND) AND TempOut(n-1 downto 0) = "00000000000000000000000000000000"
    else '0';
    
    FlagsOut(1) <= '1' when (Sel = ALU_NOT or Sel = ALU_NEG or Sel = ALU_INC or Sel = ALU_DEC or Sel = ALU_ADD or Sel = ALU_SUB or Sel = ALU_CMP or Sel = ALU_OR or Sel = ALU_XOR or Sel = ALU_AND) AND (to_integer(signed(TempOut(n-1 downto 0))) < 0)
    else '0';

    FlagsOut(2) <= TempOut(n) when (Sel = ALU_NEG or Sel = ALU_INC or Sel = ALU_DEC or Sel = ALU_ADD or Sel = ALU_SUB or Sel = ALU_CMP)
    else '0';

    Res <= TempOut(n-1 downto 0);
end architecture Behavioral;