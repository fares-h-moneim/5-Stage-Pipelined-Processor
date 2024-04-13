library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FlagReg is
    generic (n: integer := 3);
    port (
        clk: in std_logic;
        rst: in std_logic;
        en: in std_logic;
        flag: in std_logic_vector(n-1 downto 0);
        flag_out: out std_logic_vector(n-1 downto 0)
    );
end FlagReg;

architecture nDff of FlagReg is
    begin
        process(clk, rst)
        begin
            if rst = '1' then
                flag_out <= (others => '0');
            elsif falling_edge(clk) and en = '1' then
                flag_out <= flag;
            end if;
        end process;
end nDff;