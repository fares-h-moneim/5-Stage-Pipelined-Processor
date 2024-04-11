library ieee;
use ieee.std_logic_1164.all;

Entity SignExtend is
    Port ( 
        input : in std_logic_vector(15 downto 0);
        output : out std_logic_vector(31 downto 0)
    );
End SignExtend;

Architecture Behavioral of SignExtend is
Begin
    output(15 downto 0) <= input;
    output(31 downto 16) <= (others => input(15));
End Behavioral;