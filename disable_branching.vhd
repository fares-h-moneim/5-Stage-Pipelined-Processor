LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity DisableBranching is 
    port(
        rst : in std_logic;
        decode_instruction : in std_logic_vector(15 downto 0);
        execute_opcode : in std_logic_vector(5 downto 0);
        disable_branching : out std_logic
        );
end entity DisableBranching;

architecture DisableBranching_arch of DisableBranching is
    signal decode_instruction_opcode : std_logic_vector(5 downto 0);
begin
    decode_instruction_opcode <= decode_instruction(15 downto 10);

    disable_branching <= '1' when ((decode_instruction_opcode = "100000" or decode_instruction_opcode = "100010" or decode_instruction_opcode = "100001") and (execute_opcode = "110010" or execute_opcode = "010101")) else '0';
end architecture DisableBranching_arch;