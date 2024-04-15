library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity Control is
    port(
        Opcode : in std_logic_vector(5 downto 0);
        IsInstructionIn : in std_logic;
        AluSelector : out std_logic_vector(3 downto 0);
        AluSrc : out std_logic;
        MemWrite : out std_logic;
        MemRead : out std_logic;
        MemToReg : out std_logic_vector(1 downto 0); -- 10 writes from ALU to register, 01 writes from Memory to register, 00 writes from inport to register;
        RegWrite : out std_logic;
        RegWrite2 : out std_logic;
        SpPointers : out std_logic_vector(1 downto 0);
        ProtectWrite : out std_logic;
        Branching : out std_logic;
        IsInstructionOut : out std_logic -- Corrected syntax error here, no semicolon needed before this declaration
    );
end Control;
architecture Behavioral of Control is

begin

    IsInstructionOut <= '0' when Opcode = "010010" else '1';

    AluSelector <= "1001" when IsInstructionIn = '0' else
    Opcode(3 downto 0) when Opcode(5 downto 4) = "00" -- R-type
    else "1110" when Opcode = "010010" --LDM outputs the selector for ALU that outputs TempB
    else "0100" when Opcode(5 downto 4) = "01" -- LDD and STD
    else "1001"; -- Rest are dont cares so just treat them as MOV;

    AluSrc <= '0' when IsInstructionIn = '0' else
    '1' when Opcode(5 downto 4) = "10" or Opcode(5 downto 4) = "01" or -- ALU src is equal 1 if ADDI, SUBI, LDM, LDD, STD else it is zero
        Opcode = "001100" or Opcode = "001101" 
    else '0';

    MemWrite <= '0' when IsInstructionIn = '0' else
    '1' when Opcode = "010100" or Opcode = "010110" --MemWrite is equal 1 only if STD and Push
    else '0';

    MemRead <= '0' when IsInstructionIn = '0' else
    '1' when Opcode = "010011" or Opcode = "010101" --MemRead is equal 1 only if LDD and Pop
    else '0';

    MemToReg <= "01" when Opcode = "010011" or Opcode = "010101" -- MemToReg is equal 01 if LDD and Pop
    else "00" when Opcode = "110010" -- MemToReg is equal 00 if IN
    else "10"; -- MemToReg is equal 10 if ALU operation

    RegWrite <= '0' when IsInstructionIn = '0' else
    '0' when Opcode = "001011" or Opcode = "010100" or Opcode = "010110" or Opcode = "110000" or Opcode = "110001" -- Don't Write to register if CMP, STD, Push, NOP, Out
    else '1';

    RegWrite2 <= '0' when IsInstructionIn = '0' else
    '1' when Opcode = "001010" -- we will only need multiple writes if instruction is swap
    else '0';

    SpPointers <= "01" when Opcode = "010110" or Opcode = "100010" -- Push or Call
    else "10" when Opcode = "010101" or Opcode = "100011" or Opcode = "100100" -- Pop, RET, RTI
    else "00"; -- SP is not changed

    ProtectWrite <= '1' when Opcode = "010111" or Opcode = "011000" -- ProtectWrite is equal 1 if Protect or free
    else '0';

    Branching <= '1' when Opcode(5 downto 4) = "10"
    else '0';

end Behavioral;
