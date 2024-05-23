library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY PC is
    PORT(
        clk: IN STD_LOGIC;
        reset: IN STD_LOGIC;
        WEN: IN STD_LOGIC;
        PC_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PC_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY PC;

ARCHITECTURE Behavioral OF PC IS
BEGIN 
    PROCESS(clk, reset)
    BEGIN
        IF reset = '1' THEN
            PC_OUT <= PC_IN;
        ELSIF rising_edge(clk) THEN
            IF WEN = '1' THEN
                PC_OUT <= PC_IN;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE Behavioral;
