library ieee;
use ieee.std_logic_1164.all;

ENTITY DFF IS
 GENERIC ( n : integer := 16);
 PORT( Clk,Rst, En : IN std_logic;
   d : IN std_logic_vector(n-1 DOWNTO 0);
   q : OUT std_logic_vector(n-1 DOWNTO 0));
 END DFF;

ARCHITECTURE a_my_nDFF OF DFF 
IS
 BEGIN
 PROCESS (Clk,Rst,En)
 BEGIN
    IF Rst = '1' THEN
    q <= (OTHERS=>'0');
    ELSIF rising_edge(Clk) THEN
        IF En = '1' THEN
            q <= d;
        END IF;
 END IF;
 END PROCESS;
 END a_my_nDFF;

