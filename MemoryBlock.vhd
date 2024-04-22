LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity MemoryBlock is 
    PORT (clk : IN std_logic;
        address : IN std_logic_vector(11 DOWNTO 0);
        data_in : IN std_logic_vector(31 DOWNTO 0);
        mem_write : IN std_logic;
        mem_read : IN std_logic;
        read_data : OUT std_logic_vector(31 DOWNTO 0)
    );
END ENTITY MemoryBlock;

architecture Behavioral of MemoryBlock is
    COMPONENT DataMemory IS
    PORT (
            clk : IN std_logic;
            address : IN std_logic_vector(11 DOWNTO 0);
            data_in : IN std_logic_vector(31 DOWNTO 0);
            mem_write : IN std_logic;
            mem_read : IN std_logic;
            read_data : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT DataMemory;

    begin
    DataMemory1: DataMemory PORT MAP (clk, address, data_in, mem_write, mem_read, read_data);
end Behavioral;