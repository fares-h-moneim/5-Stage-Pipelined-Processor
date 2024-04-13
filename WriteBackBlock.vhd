library ieee;
use ieee.std_logic_1164.all;

entity WriteBackBlock is
    port (
        clk : in std_logic;
        reset : in std_logic;
        MemToReg : in std_logic_vector(1 downto 0);
        MemoryOutput : in std_logic_vector(31 downto 0);
        ALUOutput : in std_logic_vector(31 downto 0);
        WriteData: out std_logic_vector(31 downto 0)
    );
end WriteBackBlock;

architecture Behavioral of WriteBackBlock is
    signal TempWriteData: std_logic_vector(31 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            TempWriteData <= (others => '0');
        elsif falling_edge(clk) then
            if MemToReg = "01" then
                TempWriteData <= MemoryOutput;
            elsif MemToReg = "10" then
                TempWriteData <= ALUOutput;
            end if;
        end if;
    end process;
    WriteData <= TempWriteData;
end Behavioral;