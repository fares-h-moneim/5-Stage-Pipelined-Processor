library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FlagReg is
    generic (n: integer := 4);
    port (
        clk: in std_logic;
        rst: in std_logic;
        en: in std_logic;
        flag: in std_logic_vector(n-1 downto 0);
        flag_out: out std_logic_vector(n-1 downto 0);
        update_flags: in std_logic;
        updated_flags: in std_logic_vector(31 downto 0);
        conditional_branch: in std_logic
    );
end FlagReg;

architecture nDff of FlagReg is
    begin
        process(clk, rst)
        begin
            if rst = '1' then
                flag_out <= (others => '0');
            elsif update_flags = '1' then
                flag_out <= updated_flags(31 downto 28);
            elsif falling_edge(clk) and en = '1' then
                flag_out <= flag;
            elsif rising_edge(clk) and conditional_branch = '1' then
                flag_out(0) <= '0';
            end if;
        end process;
end nDff;