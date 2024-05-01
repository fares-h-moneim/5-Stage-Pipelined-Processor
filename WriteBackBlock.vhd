library ieee;
use ieee.std_logic_1164.all;

entity WriteBackBlock is
    port (
        clk : in std_logic;
        reset : in std_logic;
        MemToReg : in std_logic_vector(1 downto 0);
        MemoryOutput : in std_logic_vector(31 downto 0);
        ALUOutput : in std_logic_vector(31 downto 0);
        ReadData1 : in std_logic_vector(31 downto 0);
        InPort: in std_logic_vector(31 downto 0);
        WriteData: out std_logic_vector(31 downto 0);
        WriteData2: out std_logic_vector(31 downto 0)
    );
end WriteBackBlock;

architecture Behavioral of WriteBackBlock is
    signal TempWriteData: std_logic_vector(31 downto 0);
begin
    WriteData <= (others => '0') when reset = '1' else
                    InPort when MemToReg = "00" else
                    MemoryOutput when MEMTOREG = "01" else
                    ALUOutput when MemToReg = "10" else
                    (others => '0');

    WriteData2 <= (others => '0') when reset = '1' else ReadData1;
end Behavioral;