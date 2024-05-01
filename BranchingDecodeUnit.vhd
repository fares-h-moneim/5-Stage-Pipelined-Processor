library ieee;
use ieee.std_logic_1164.all;


entity BranchingDecodeUnit is
    port (
        Clk : in std_logic;
        reset : in std_logic;
        DisableBranching : in std_logic;
        Branching : in std_logic;
        BranchingAddressIn : in std_logic_vector(31 downto 0);
        FlushDecode : out std_logic;
        BranchingAddressOut : out std_logic_vector(31 downto 0)
    );
end BranchingDecodeUnit;

architecture Behavioral of BranchingDecodeUnit is
begin
    process(Clk)
    begin
        if reset = '1' then
            FlushDecode <= '0';
            BranchingAddressOut <= (others => '0');
        elsif rising_edge(Clk) then
            if Branching = '1' then
                BranchingAddressOut <= BranchingAddressIn;
            end if;
        end if;
    end process;
end Behavioral;
