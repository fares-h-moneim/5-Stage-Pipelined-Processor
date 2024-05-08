library ieee;
use ieee.std_logic_1164.all;

-- I am going to need the Clk and reset signals
-- I am going to if the prediction was disabled
-- I am going to need zero flag to check if the branch was taken
-- I am going to need the PCPlus1 signal to increment the PC to the original value
-- I am going to need the ConditionalJumpAddress signal to jump to the new address
-- I am going to need the prediction signal to check if the branch was taken
-- I am going to need the UnconditionalJump signal to check if the branch was taken
-- I am going to need the FlushDecode signal to flush the decode stage 
-- I am going to need the FlushExecute signal to flush the execute stage
-- I am going to need the JumpAddress signal to jump to the new address if the branch was taken 

entity BranchingExecuteUnit is 
    port (
        Clk : in std_logic;
        reset : in std_logic;
       -- WasPredictionDisabled : in std_logic; AZON MALHA4 LAZMA
        ZeroFlag : in std_logic;
        PCPlus1 : in std_logic_vector(31 downto 0);
        ConditionalJumpAddress : in std_logic_vector(31 downto 0);
        BranchPrediction : in std_logic;
        ConditionalJump : in std_logic;
        FlushDecode : out std_logic;
        FlushExecute : out std_logic;
        ChangePC : out std_logic;
        JumpAddress : out std_logic_vector(31 downto 0)
    );
end BranchingExecuteUnit;

architecture Behavioral of BranchingExecuteUnit is
begin
    process(Clk, reset)
    begin
        if reset = '0' then
            FlushDecode <= '1';
            FlushExecute <= '1';
            JumpAddress <= (others => '0');
        elsif rising_edge(Clk) then
            if(ConditionalJump = '1' and BranchPrediction = '0' and ZeroFlag = '1') then --i predicted to not jump but i should have
                FlushDecode <= '1';
                FlushExecute <= '1';
                ChangePC <= '1';
                JumpAddress <= ConditionalJumpAddress;
            elsif(ConditionalJump = '1' and BranchPrediction = '1' and ZeroFlag = '0') then --i predicted to jump but i should not have
                FlushDecode <= '1';
                FlushExecute <= '1';
                ChangePC <= '1';
                JumpAddress <= PCPlus1;
            elsif(ConditionalJump = '1' and BranchPrediction = '1' and ZeroFlag = '1') then --i predicted to jump and i should have
                FlushDecode <= '0';
                FlushExecute <= '0';
                ChangePC <= '0';
            elsif(ConditionalJump = '1' and BranchPrediction = '0' and ZeroFlag = '0') then --i predicted to not jump and i should not have
                FlushDecode <= '0';
                FlushExecute <= '0';
                ChangePC <= '0';
            else
                FlushDecode <= '0';
                FlushExecute <= '0';
                ChangePC <= '0';
                JumpAddress <= PCPlus1;
            end if;
        end if;
    end process;
end Behavioral;