library ieee;
use ieee.std_logic_1164.all;

entity PC_MUX is 
port(
    clk : in std_logic;
    PCsrc : in std_logic;
    Sequential: in std_logic_vector(31 downto 0);
    Branch: in std_logic_vector(31 downto 0);
    PC: out std_logic_vector(31 downto 0)
);
end PC_MUX;

architecture Behavioral of PC_MUX is
    signal internal_PC: std_logic_vector(31 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if PCsrc = '1' then
                PC <= Branch;
            else
                PC <= Sequential;
            end if;
        end if;
    end process;
end Behavioral;