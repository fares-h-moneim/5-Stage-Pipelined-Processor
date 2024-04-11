LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE IEEE.numeric_std.all;
 ENTITY RegisterFile IS
    PORT (clk : IN std_logic;
            we : IN std_logic;
            w_address : IN std_logic_vector(2 DOWNTO 0);
            r_address1 : IN std_logic_vector(2 DOWNTO 0);
            r_address2 : IN std_logic_vector(2 DOWNTO 0);
            data_in   : IN std_logic_vector(31 DOWNTO 0);
            dataout_1 : OUT std_logic_vector(31 DOWNTO 0);
            dataout_2 : OUT std_logic_vector(31 DOWNTO 0)
        );
 END ENTITY RegisterFile;

ARCHITECTURE sync_ram_a OF RegisterFile IS  
    TYPE ram_type IS ARRAY(0 TO 7) of std_logic_vector(31 DOWNTO 0);
        SIGNAL ram : ram_type ;
    BEGIN
    PROCESS(clk) IS  
        BEGIN
        IF falling_edge(clk) THEN   
            IF we = '1' THEN        
                ram(to_integer(unsigned((w_address)))) <= data_in;  
            END IF;
        END IF;
    END PROCESS;
            dataout_1 <= ram(to_integer(unsigned((r_address1))));
            dataout_2 <= ram(to_integer(unsigned((r_address2))));
 END sync_ram_a;

