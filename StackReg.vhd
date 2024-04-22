
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY StackReg IS
GENERIC(n : integer :=16);
 PORT( d : IN std_logic_vector (n-1 downto 0);
 q : OUT std_logic_vector (n-1 downto 0);
clk,rst,en : IN std_logic );
END StackReg;
ARCHITECTURE a_my_DFF OF StackReg IS
BEGIN
PROCESS(clk,rst)
BEGIN
IF(rst = '1') THEN
 q <= "0000001111111111";
ELSIF clk'event and clk = '1' THEN
if en = '1' then 
 q <= d;
END IF;
END IF;
END PROCESS;
END a_my_DFF;
