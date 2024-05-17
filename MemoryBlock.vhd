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
    reg2_value : IN std_logic_vector(31 DOWNTO 0);
    protect_signal : IN std_logic;
    free_signal : IN std_logic;
    read_data_protected : OUT std_logic;
    read_data_protected_after : OUT std_logic;
    call_signal : IN std_logic;
    RETIN : IN STD_LOGIC;
    changePCRET : OUT STD_LOGIC;
    memory_rti : IN STD_LOGIC;
    interrupt_signal : IN STD_LOGIC;
    flags : OUT std_logic_vector(31 DOWNTO 0);
    data_in2 : IN std_logic_vector(31 DOWNTO 0); -- FLAGS HTGY HNA
    changePC : OUT STD_LOGIC
    );
END ENTITY MemoryBlock;

architecture Behavioral of MemoryBlock is
    signal sppIn : std_logic_vector(11 DOWNTO 0);
    signal sppOut : std_logic_vector(11 DOWNTO 0);
    signal memAddress : std_logic_vector(11 DOWNTO 0);
    signal memDataIn : std_logic_vector(31 DOWNTO 0);
    signal actual_mem_write : std_logic;
    signal read_data_protected_temp : std_logic;
    signal read_data_protected_after_temp : std_logic;

    COMPONENT DataMemory IS
    PORT (
            clk : IN std_logic;
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
    END COMPONENT DataMemory;

    component stackReg IS
        GENERIC(n : integer :=12);
        PORT( d : IN std_logic_vector (n-1 downto 0);
        q : OUT std_logic_vector (n-1 downto 0);
        clk,rst,en : IN std_logic );
    END component;

    COMPONENT ProtectedMemory IS
    PORT (
            clk : IN std_logic;
            alu_address : IN std_logic_vector(11 downto 0);
            protect_signal : IN std_logic;
            free_signal : IN std_logic;
            read_data_protected : OUT std_logic;
            read_data_protected_after : OUT std_logic
        );
    END COMPONENT ProtectedMemory;

    begin
        sppIn <= sppOut when sp_signal = "00" 
        else std_logic_vector(unsigned(sppOut) - 4) when (sp_signal = "01" and interrupt_signal = '1')
        else std_logic_vector(unsigned(sppOut) - 2) when sp_signal = "01"
        else std_logic_vector(unsigned(sppOut) + 2) when sp_signal = "10"
        else sppOut;

        memAddress <= address when sp_signal = "00"
        else std_logic_vector(unsigned(sppOut) + 2) when sp_signal = "10"
        else std_logic_vector(unsigned(sppOut) - 2) when (sp_signal = "01" and interrupt_signal = '1')
        else sppOut;

        memDataIn <= std_logic_vector(to_unsigned(to_integer(unsigned((pc_value))) + 1, 32)) when (sp_signal = "01" and call_signal = '1') 
        else std_logic_vector(to_unsigned(to_integer(unsigned((pc_value))), 32)) when (sp_signal = "01" and interrupt_signal = '1')
        else reg2_value when sp_signal = "00"
        else reg2_value when sp_signal = "01"
        else reg2_value;

        --data_in2 <= flags when (sp_signal = "10" and interrupt_signal = '1');

        actual_mem_write <= mem_write when read_data_protected_temp = '0' and read_data_protected_after_temp = '0'
        else '0';

        read_data_protected <= read_data_protected_temp when mem_write = '1'
        else '0';
        read_data_protected_after <= read_data_protected_after_temp when mem_write = '1'
        else '0';

        changePC <= memory_rti;
        changePCRET <= RETIN;


    DataMemory1: DataMemory PORT MAP (clk, memAddress, memDataIn, actual_mem_write, mem_read, read_data, memory_rti, flags, interrupt_signal, data_in2);
    spp: stackReg generic map(12) port map ( sppIn,sppOut,clk,reset,'1' );
    ProtectedMemory1: ProtectedMemory PORT MAP (clk, address, protect_signal, free_signal, read_data_protected_temp, read_data_protected_after_temp);
end Behavioral;