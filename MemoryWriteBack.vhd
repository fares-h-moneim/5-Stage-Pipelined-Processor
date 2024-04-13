library ieee;
use ieee.std_logic_1164.all;

ENTITY MemoryWriteBack IS
    PORT(
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        MemToReg : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        RegWrite : IN STD_LOGIC;
        RegWrite2 : IN STD_LOGIC;
        MemoryData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        AluResult : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        MemToRegOut : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        RegWriteOut : OUT STD_LOGIC;
        RegWrite2Out : OUT STD_LOGIC;
        MemoryDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AluResultOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END MemoryWriteBack;

ARCHITECTURE MemoryWriteBack OF MemoryWriteBack IS
    
BEGIN
    PROCESS (clk, reset, enable)
    BEGIN
        IF reset = '1' THEN
            MemToRegOut <= (OTHERS => '0');
            RegWriteOut <= '0';
            RegWrite2Out <= '0';
            MemoryDataOut <= (OTHERS => '0');
            AluResultOut <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF enable = '1' THEN
                MemToRegOut <= MemToReg;
                RegWriteOut <= RegWrite;
                RegWrite2Out <= RegWrite2;
                MemoryDataOut <= MemoryData;
                AluResultOut <= AluResult;
            END IF;
    END IF;
    END PROCESS;
    
END MemoryWriteBack;
