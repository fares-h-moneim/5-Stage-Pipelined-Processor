library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InterruptLatch is
    port (
        clk, rst, interrupt: in std_logic;
        instruction: in std_logic_vector(15 downto 0);

        interruptOut: out std_logic
    );
end entity InterruptLatch;

architecture behavioral of InterruptLatch is
begin
    process(clk, rst)
    variable saveCounter: integer := 0;
    variable interruptReg: std_logic;
    begin
        if rst = '1' then
            interruptReg := '0';
        elsif rising_edge(clk) then
            if interrupt = '1' then
                interruptReg := '1';
            end if;

            if instruction(15 downto 10) = "100011" then
                saveCounter := 3;
            elsif instruction(15 downto 10) = "100000" then
                saveCounter := 4;
            elsif instruction(15 downto 14) = "10" then
                saveCounter := 2;
            end if;
        end if;

        if saveCounter = 0 then
            interruptOut <= interruptReg;
            interruptReg := '0';
        else
            saveCounter := saveCounter - 1;
            interruptOut <= '0';
        end if;
    end process;
end architecture behavioral;