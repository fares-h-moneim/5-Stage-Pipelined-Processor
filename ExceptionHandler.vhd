LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY ExceptionHandler IS
    PORT(
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        overflow : IN STD_LOGIC;
        protect : IN STD_LOGIC;
        flush_exception_until_execute : OUT STD_LOGIC;
        flush_exception_until_write_back : OUT STD_LOGIC;
        exception_handler_address: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        change_pc_from_exception : OUT STD_LOGIC
    );
END ExceptionHandler;

ARCHITECTURE Behavioral OF ExceptionHandler IS
    SIGNAL exception_handler_address_reg : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
BEGIN
    flush_exception_until_execute <= '1' WHEN (overflow = '1' and protect = '0') ELSE '0';
    flush_exception_until_write_back <= '1' WHEN ((overflow = '1' and protect = '1') or (protect='1')) ELSE '0';
    change_pc_from_exception <= '1' WHEN (overflow = '1' or protect = '1') ELSE '0';
    exception_handler_address <= exception_handler_address_reg;
end Behavioral;
