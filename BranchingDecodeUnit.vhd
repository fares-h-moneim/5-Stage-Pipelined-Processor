library ieee;
use ieee.std_logic_1164.all;

-- I am going to need the clk and reset
-- I am also going to need the disable branching signal
-- I am going to need from the controller if i am an unconditonal branch or conditional branch and predict = T
-- So this means i also need the branch prediciton
-- if prediction = F then i need to do nothing and let PC not jump
-- If i am prediction = T then i need to flush the decode stage in next cycle
-- I am going to need the branch address to also give
-- I am going to need a signal coming from me to tell the PC to jump to the branch address

entity BranchingDecodeUnit is
    port (
        Clk : in std_logic;
        reset : in std_logic;
        DisableBranching : in std_logic;
        ConditionalBranch : in std_logic; -- 1 if conditional branch
        UnConditionalBranch : in std_logic; -- 1 if unconditional branch
        BranchingAddressIn : in std_logic_vector(31 downto 0); -- the address of the branch
        Branching : in std_logic; --The prediction if T or F
        FlushDecode : out std_logic;
        ChangePC : out std_logic; -- will be 1 if i need to jump to the branch address
        BranchingAddressOut : out std_logic_vector(31 downto 0)
    );
end BranchingDecodeUnit;

architecture Behavioral of BranchingDecodeUnit is
begin
    process(Clk)
    begin
        if reset = '1' then
            FlushDecode <= '0';
            changePC <= '0';
        elsif rising_edge(Clk) then
            if DisableBranching = '1' then
                FlushDecode <= '0';
                changePC <= '0';
            elsif ConditionalBranch = '1' and Branching = '1' then
                FlushDecode <= '1';
                changePC <= '1';
            elsif UnConditionalBranch = '1' then
                FlushDecode <= '1';
                changePC <= '1';
            else
                FlushDecode <= '0';
                changePC <= '0';
            end if;
            BranchingAddressOut <= BranchingAddressIn;
        end if;
    end process;
end Behavioral;