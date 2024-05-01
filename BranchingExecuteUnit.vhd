library ieee;
use ieee.std_logic_1164.all;

entity BranchingExecuteUnit is 
    port (
        Clk : in std_logic;
        reset : in std_logic;
        WasPredictionDisabled : in std_logic;
        PCPlus1 : in std_logic_vector(31 downto 0);
        ConditionalJumpAddress : in std_logic_vector(31 downto 0);
        BranchPrediction : in std_logic;
        ZeroFlag : in std_logic;
        UnconditionalJump : in std_logic;
        FlushDecode : out std_logic;
        FlushExecute : out std_logic;
        JumpAddress : out std_logic_vector(31 downto 0)
    );
end BranchingExecuteUnit;

architecture Behavioral of BranchingExecuteUnit is
begin
    process(Clk, reset)
    begin
        if reset = '1' then
            FlushDecode <= '1';
            FlushExecute <= '1';
            JumpAddress <= (others => '0');
        elsif rising_edge(Clk) then
            if UnconditionalJump = '1' then
                FlushDecode <= '1';
                FlushExecute <= '1';
                JumpAddress <= ConditionalJumpAddress;
            elsif BranchPrediction = '1' and ZeroFlag = '1' then
                FlushDecode <= '1';
                FlushExecute <= '1';
                JumpAddress <= ConditionalJumpAddress;
            elsif BranchPrediction = '0' and ZeroFlag = '0' then
                FlushDecode <= '1';
                FlushExecute <= '1';
                JumpAddress <= ConditionalJumpAddress;
            else
                FlushDecode <= '0';
                FlushExecute <= '0';
                JumpAddress <= PCPlus1;
            end if;
        end if;
    end process;
end Behavioral;