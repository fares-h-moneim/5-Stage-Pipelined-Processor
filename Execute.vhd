library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ExecuteBlock is
    port (
        clk : in std_logic;
        reset : in std_logic;
        AluSrc : in std_logic;
        Sel1: in std_logic_vector(3 downto 0);
        Sel2: in std_logic_vector(3 downto 0);
        ReadData1 : in std_logic_vector(31 downto 0);
        ReadData2 : in std_logic_vector(31 downto 0);
        Immediate : in std_logic_vector(31 downto 0);
        AluSelector : in std_logic_vector(3 downto 0);
        AluResExecuteMemory : in std_logic_vector(31 downto 0);
        AluResMemoryWriteBack : in std_logic_vector(31 downto 0);
        ReadData1ExecuteMemory : in std_logic_vector(31 downto 0);
        ReadData1MemoryWriteBack : in std_logic_vector(31 downto 0);
        MemOutMemoryWriteBack : in std_logic_vector(31 downto 0);
        InPortExecuteMemory : in std_logic_vector(31 downto 0);
        InPortMemoryWriteBack : in std_logic_vector(31 downto 0);
        
        ZeroFlag : out std_logic;
        NegativeFlag : out std_logic;
        CarryFlag : out std_logic;
        OverflowFlag : out std_logic;
        AluOut : out std_logic_vector(31 downto 0);
        ReadDataOut : out std_logic_vector(31 downto 0);
        ReadDataOut2 : out std_logic_vector(31 downto 0);
        call_signal_in : in std_logic;
        call_signal_out : out std_logic;
        flags_out : out std_logic_vector(31 downto 0);
        update_flags : in std_logic;
        updated_flags : in std_logic_vector(31 downto 0);
        ExecuteMemoryWriteBack : in std_logic_vector(31 downto 0)
    );
end entity ExecuteBlock; 

architecture Behavioral of ExecuteBlock is
    component ALU is
        generic (n: integer := 32);
        port (
            A, B: in std_logic_vector(n-1 downto 0); -- Two operands
            Sel: in std_logic_vector(3 downto 0); -- Select lines

            FlagsIn: in std_logic_vector(3 downto 0); -- Flags input (Zero, Negative, Carry)
            FlagsOut: out std_logic_vector(3 downto 0); -- Flags output (Zero, Negative, Carry)
            Res: out std_logic_vector(n-1 downto 0) -- Result
        );
    end component;

    component FlagReg is
        generic (n: integer := 4);
        port (
            clk: in std_logic;
            rst: in std_logic;
            en: in std_logic;
            flag: in std_logic_vector(n-1 downto 0);
            flag_out: out std_logic_vector(n-1 downto 0);
            update_flags: in std_logic;
            updated_flags: in std_logic_vector(31 downto 0)
        );
    end component;

    signal Flags: std_logic_vector(3 downto 0);
    signal FlagsOut: std_logic_vector(3 downto 0);
    signal AluIn1: std_logic_vector(31 downto 0);
    signal AluIn2: std_logic_vector(31 downto 0);
    signal OutMux1: std_logic_vector(31 downto 0);
    signal TempFlags: std_logic_vector(3 downto 0);
    signal TempAluOut: std_logic_vector(31 downto 0);

begin
    call_signal_out <= call_signal_in;

    TempFlags <= FlagsOut;
    flags_out <= FlagsOut & "0000000000000000000000000000";

    OutMux1 <= immediate when AluSrc = '1' else ReadData2;
    
    AluIn1 <= AluResExecuteMemory when Sel1 = "0001" else
            AluResMemoryWriteBack when Sel1 = "0010" else
            ReadData1ExecuteMemory when Sel1 = "0011" else
            ReadData1MemoryWriteBack when Sel1 = "0100" else
            MemOutMemoryWriteBack when Sel1 = "0101" else
            InPortExecuteMemory when Sel1 = "0110" else
            InPortMemoryWriteBack when Sel1 = "0111" else
            ExecuteMemoryWriteBack when Sel1 = "1000" else
            ReadData1;

    AluIn2 <= AluResExecuteMemory when Sel2 = "0001" else
            AluResMemoryWriteBack when Sel2 = "0010" and AluSrc = '0' else
            ReadData1ExecuteMemory when Sel2 = "0011" else
            ReadData1MemoryWriteBack when Sel2 = "0100" else
            MemOutMemoryWriteBack when Sel2 = "0101" else
            InPortExecuteMemory when Sel2 = "0110" else
            InPortMemoryWriteBack when Sel2 = "0111" else
            ExecuteMemoryWriteBack when Sel2 = "1000" else
            OutMux1;

    ALU1: ALU generic map (32) port map (AluIn1, AluIn2, AluSelector, TempFlags, Flags, TempAluOut);

    ZeroFlag <= Flags(0);
    NegativeFlag <= Flags(1);
    OverflowFlag <= Flags(2);
    CarryFlag <= Flags(3);

    FlagsReg1: FlagReg generic map (4) port map (clk, reset, '1', Flags, FlagsOut, update_flags, updated_flags);

    AluOut <= TempAluOut;
    ReadDataOut <= AluResExecuteMemory when Sel1 = "0001" else
            AluResMemoryWriteBack when Sel1 = "0010" else
            ReadData1ExecuteMemory when Sel1 = "0011" else
            ReadData1MemoryWriteBack when Sel1 = "0100" else
            MemOutMemoryWriteBack when Sel1 = "0101" else
            InPortExecuteMemory when Sel1 = "0110" else
            InPortMemoryWriteBack when Sel1 = "0111" else
            ExecuteMemoryWriteBack when Sel1 = "1000" else
            ReadData1;

    ReadDataOut2 <= AluResExecuteMemory when Sel2 = "0001" else
            AluResMemoryWriteBack when Sel2 = "0010" else
            ReadData1ExecuteMemory when Sel2 = "0011" else
            ReadData1MemoryWriteBack when Sel2 = "0100" else
            MemOutMemoryWriteBack when Sel2 = "0101" else
            InPortExecuteMemory when Sel2 = "0110" else
            InPortMemoryWriteBack when Sel2 = "0111" else
            ExecuteMemoryWriteBack when Sel2 = "1000" else
            ReadData2;


end architecture Behavioral;