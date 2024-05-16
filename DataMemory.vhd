LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY DataMemory IS
    PORT (clk : IN std_logic;
            address : IN std_logic_vector(11 DOWNTO 0);
            data_in : IN std_logic_vector(31 DOWNTO 0);
            mem_write : IN std_logic;
            mem_read : IN std_logic;
            read_data : OUT std_logic_vector(31 DOWNTO 0);
            memory_rti : IN std_logic;
            flags : OUT std_logic_vector(31 DOWNTO 0);
            interrupt_signal : IN std_logic;
            data_in2 : IN std_logic_vector(31 DOWNTO 0)
        );
END ENTITY DataMemory;

ARCHITECTURE sync_ram_a OF DataMemory IS  
    TYPE ram_type IS ARRAY(0 TO 4095) of std_logic_vector(15 DOWNTO 0);
        SIGNAL ram : ram_type ;
    BEGIN

    read_data <= ram(to_integer(unsigned(address)) + 1) & ram(to_integer(unsigned(address))) when mem_read = '1' else data_in;
    flags <= ram(to_integer(unsigned(address)) + 3) & ram(to_integer(unsigned(address)) + 2) when memory_rti = '1';
    PROCESS(clk, mem_write, mem_read) IS  
        BEGIN
        IF rising_edge(clk) THEN   
            IF mem_write = '1' THEN        
                ram(to_integer(unsigned((address)))) <= data_in(15 downto 0);
                ram(to_integer(unsigned((address))) + 1) <= data_in(31 downto 16);
            END IF;
            if(interrupt_signal = '1') then
                ram(to_integer(unsigned((address))) + 2) <= data_in2(15 downto 0);
                ram(to_integer(unsigned((address))) + 3) <= data_in2(31 downto 16);
            end if;
        END IF;
    END PROCESS;
END sync_ram_a;