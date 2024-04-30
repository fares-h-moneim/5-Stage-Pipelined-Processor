LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity MemoryBlock is 
    PORT (clk : IN std_logic;
    reset : IN std_logic; -- new stuff needed
    address : IN std_logic_vector(11 DOWNTO 0);
    data_in : IN std_logic_vector(31 DOWNTO 0); -- ALU Result
    mem_write : IN std_logic;
    mem_read : IN std_logic;
    read_data : OUT std_logic_vector(31 DOWNTO 0);

    -- new stuff needed
    sp_signal : IN std_logic_vector(1 DOWNTO 0);
    pc_value : IN std_logic_vector(31 DOWNTO 0);
    reg2_value : IN std_logic_vector(31 DOWNTO 0)
    );
END ENTITY MemoryBlock;

architecture Behavioral of MemoryBlock is
    signal sppIn : std_logic_vector(11 DOWNTO 0);
    signal sppOut : std_logic_vector(11 DOWNTO 0);
    signal memAddress : std_logic_vector(11 DOWNTO 0);
    signal memDataIn : std_logic_vector(31 DOWNTO 0);

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

    component stackReg IS
        GENERIC(n : integer :=12);
        PORT( d : IN std_logic_vector (n-1 downto 0);
        q : OUT std_logic_vector (n-1 downto 0);
        clk,rst,en : IN std_logic );
    END component;

    begin
        sppIn <= sppOut when sp_signal = "00" 
        else std_logic_vector(unsigned(sppOut) - 2) when sp_signal = "01"
        else std_logic_vector(unsigned(sppOut) + 2) when sp_signal = "10"
        else sppOut;

        memAddress <= address when sp_signal = "00"
        else std_logic_vector(unsigned(sppOut) + 2) when sp_signal = "10"
        else sppOut;

        memDataIn <= reg2_value when sp_signal = "00"
        else reg2_value when sp_signal = "01"
        else reg2_value;


    DataMemory1: DataMemory PORT MAP (clk, memAddress, memDataIn, mem_write, mem_read, read_data);
    spp: stackReg generic map(12) port map ( sppIn,sppOut,clk,reset,'1' );
end Behavioral;