
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

ENTITY instruction_memory is
    PORT(
        clk, reset : IN std_logic;
        address : IN std_logic_vector(31 DOWNTO 0);
        instruction : OUT std_logic_vector(15 DOWNTO 0);
        immediate : OUT std_logic_vector(15 DOWNTO 0)
    );
END instruction_memory;

ARCHITECTURE Behavioral OF instruction_memory IS
    TYPE memory IS ARRAY (0 TO 4095) OF std_logic_vector(15 DOWNTO 0); 
    SIGNAL mem : memory;
BEGIN
    PROCESS(clk, reset)
    BEGIN
        IF reset = '1' THEN
        instruction <= (OTHERS => '0');
        immediate <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            instruction <= mem(TO_INTEGER(unsigned(address)));
            immediate <= mem(TO_INTEGER(unsigned(address)) + 1);
        END IF;
    END PROCESS;
END Behavioral;