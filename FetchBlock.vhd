library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FetchBlock is
    port (
        clk : in std_logic;
        rst : in std_logic;
        instruction : OUT std_logic_vector(15 DOWNTO 0);
        immediate : OUT std_logic_vector(15 DOWNTO 0)
    );
end entity FetchBlock;

architecture behavioral of FetchBlock is
    component instruction_memory is
        port (
            clk, reset : IN std_logic;
            address : IN std_logic_vector(31 DOWNTO 0);
            instruction : OUT std_logic_vector(15 DOWNTO 0);
            immediate : OUT std_logic_vector(15 DOWNTO 0)
        );
    end component instruction_memory;

    component PC is
        port (
            clk: IN STD_LOGIC;
            reset: IN STD_LOGIC;
            WEN: IN STD_LOGIC;
            PC_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            PC_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component PC;
    
    signal PC_OUT: std_logic_vector(31 DOWNTO 0) := (others => '0');
    signal PC_IN: std_logic_vector(31 DOWNTO 0);
    signal internal_instruction: std_logic_vector(15 DOWNTO 0);
    signal IncrementTwo: std_logic; --will i increment by 1 or 2
    signal internal_PC : std_logic_vector(31 DOWNTO 0);
    begin
        PC1: PC port map(clk, rst, '1', internal_PC, PC_OUT);
        IM1: instruction_memory port map(clk, rst, PC_OUT, internal_instruction, immediate);
        instruction <= internal_instruction;
        PC_IN <= PC_OUT;
        IncrementTwo <= '1' when (internal_instruction(13 downto 10) = "1100" or internal_instruction(13 downto 10)= "1101") else '0';

        process(clk)
        begin
            if falling_edge(clk) then
                if rst = '1' then
                    internal_PC <= (others => '0');
                else
                    if IncrementTwo = '1' then
                        internal_PC <= std_logic_vector(unsigned(internal_PC) + 2);
                    else
                    internal_PC <= std_logic_vector(unsigned(internal_PC) + 1);
                    end if;
                end if;
            end if;
        end process;
end architecture behavioral;