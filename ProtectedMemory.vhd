LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ProtectedMemory IS
    PORT (clk : IN std_logic;
            alu_address : IN std_logic_vector(11 downto 0);
            protect_signal : IN std_logic;
            free_signal : IN std_logic;
            read_data_protected : OUT std_logic
        );
END ENTITY ProtectedMemory;

ARCHITECTURE sync_ram_a OF ProtectedMemory IS  
    TYPE ram_type IS ARRAY(0 TO 4095) of std_logic;
        SIGNAL ram : ram_type := (OTHERS => '0');
    BEGIN
    PROCESS(clk) IS  
        BEGIN
        IF rising_edge(clk) THEN   
            IF protect_signal = '1' THEN        
                ram(to_integer(unsigned((alu_address)))) <= '1';
            ELSIF free_signal = '1' THEN
                ram(to_integer(unsigned((alu_address)))) <= '0';
            END IF;
        END IF;
    END PROCESS;
    read_data_protected <= ram(to_integer(unsigned((alu_address))));
END sync_ram_a;
