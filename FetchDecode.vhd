library ieee;
use ieee.std_logic_1164.all;

entity FetchDecode is
    port(
        clk: in std_logic;
        reset: in std_logic;
        instructionIn: in std_logic_vector(15 downto 0);
        instructionOut: out std_logic_vector(15 downto 0)
        -- immediatein: in std_logic_vector(15 downto 0);
        -- immediateout: out std_logic_vector(15 downto 0)
    );
end FetchDecode;

ARCHITECTURE Behavior OF FetchDecode IS
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            instructionOut <= "1100000000000000";
            -- immediateOut   <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            instructionOut <= instructionIn;
            -- immediateOut   <= immediateIn;
        END IF;
    END PROCESS;

END Behavior;