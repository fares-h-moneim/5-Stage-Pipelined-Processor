library ieee;
use ieee.std_logic_1164.all;

ENTITY DecodeExecute IS
    PORT(
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        AluSelector : IN std_logic_vector(3 downto 0);
        AluSrc : IN std_logic;
        MemWrite : IN std_logic;
        MemRead : IN std_logic;
        MemToReg : IN std_logic_vector(1 downto 0);
        RegWrite : IN std_logic;
        SpPointers : IN std_logic_vector(1 downto 0);
        ProtectWrite : IN std_logic;
        Branching : IN std_logic;
        ReadData1 : IN std_logic_vector(31 downto 0); -- Register src 1
        ReadData2 : IN std_logic_vector(31 downto 0); -- Register src 2
        Destination : IN std_logic_vector(2 downto 0); -- Register destination address
        Imm : IN std_logic_vector(15 downto 0);

        AluSelectorOut : OUT std_logic_vector(3 downto 0);
        AluSrcOut : OUT std_logic;
        MemWriteOut : OUT std_logic;
        MemReadOut : OUT std_logic;
        MemToRegOut : OUT std_logic_vector(1 downto 0);
        RegWriteOut : OUT std_logic;
        SpPointersOut : OUT std_logic_vector(1 downto 0);
        ProtectWriteOut : OUT std_logic;
        BranchingOut : OUT std_logic;
        ReadData1Out : OUT std_logic_vector(31 downto 0);
        ReadData2Out : OUT std_logic_vector(31 downto 0);
        DestinationOut : OUT std_logic_vector(2 downto 0);
        ImmOut : OUT std_logic_vector(31 downto 0)
    );
END DecodeExecute;

ARCHITECTURE DecodeExecute OF DecodeExecute IS
    
BEGIN
    PROCESS (clk, reset, enable)
    BEGIN
        IF reset = '1' THEN
            AluSelectorOut <= (OTHERS=>'0');
            AluSrcOut <= '0';
            MemWriteOut <= '0';
            MemReadOut <= '0';
            MemToRegOut <= (OTHERS=>'0');
            RegWriteOut <= '0';
            SpPointersOut <= (OTHERS=>'0');
            ProtectWriteOut <= '0';
            BranchingOut <= '0';
            ReadData1Out <= (OTHERS=>'0');
            ReadData2Out <= (OTHERS=>'0');
            DestinationOut <= (OTHERS=>'0');
            ImmOut <= (OTHERS=>'0');
        ELSIF rising_edge(clk) THEN
            IF enable = '1' THEN
                AluSelectorOut <= AluSelector;
                AluSrcOut <= AluSrc;
                MemWriteOut <= MemWrite;
                MemReadOut <= MemRead;
                MemToRegOut <= MemToReg;
                RegWriteOut <= RegWrite;
                SpPointersOut <= SpPointers;
                ProtectWriteOut <= ProtectWrite;
                BranchingOut <= Branching;
                ReadData1Out <= ReadData1;
                ReadData2Out <= ReadData2;
                DestinationOut <= Destination;
                ImmOut <= Imm;
            END IF;
        END IF;
    END PROCESS;
    
END DecodeExecute;
