library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ForwardingUnit is
    port(
        DecodeExecuteSrc1 : in std_logic_vector(2 downto 0);
        DecodeExecuteSrc2 : in std_logic_vector(2 downto 0);
        DecodeExecuteRegDst1 : in std_logic_vector(2 downto 0);
        DecodeExecuteRegRead1 : in std_logic;
        DecodeExecuteRegRead2 : in std_logic;
        DecodeExecuteSPSignal : in std_logic_vector(1 downto 0);

        ExecuteMemoryRegWrite1 : in std_logic;
        ExecuteMemoryRegWrite2 : in std_logic;
        ExecuteMemoryRegDst1 : in std_logic_vector(2 downto 0);
        ExecuteMemoryRegDst2 : in std_logic_vector(2 downto 0);
        ExecuteMemoryMemToReg : in std_logic_vector(1 downto 0);
        ExecuteMemorySPSignal : in std_logic_vector(1 downto 0);

        MemoryWriteBackRegWrite1 : in std_logic;
        MemoryWriteBackRegWrite2 : in std_logic;
        MemoryWriteBackRegDst1 : in std_logic_vector(2 downto 0);
        MemoryWriteBackRegDst2 : in std_logic_vector(2 downto 0);
        MemoryWriteBackMemToReg : in std_logic_vector(1 downto 0);

        ExecuteMemoryInPort : in std_logic;
        MemoryWriteBackInPort : in std_logic;

        AluMuxSel1 : out std_logic_vector(3 downto 0); -- First Operand (ALU A)
        AluMuxSel2 : out std_logic_vector(3 downto 0) -- Second Operand (ALU B)
    );
end ForwardingUnit;

-- 0000 Read Data 1 from RegisterFile (NO FORWARDING) (000 MS)

-- 0001 AluRes from ExecuteMemory buffer (001 MS)
-- 0010 AluRes from MemoryWriteBack buffer

-- 0011 Read Data 1 from ExecuteMemory buffer (010 MS)
-- 0100 Read Data 1 from MemoryWriteBack buffer (111 MS)

-- 0101 Memory Out from MemoryWriteback buffer
-- 0110 In port in previous (110 MS)
-- 0111 In port in before previous (100 MS)
-- 1000 Memory Out from ExecuteMemory buffer

architecture Behavioral of ForwardingUnit is
begin
    AluMuxSel1 <= "0000" when DecodeExecuteRegRead1 = '0' and DecodeExecuteSPSignal /= "01" else -- DONE
    "1000" when ExecuteMemorySPSignal = "10" and DecodeExecuteSrc1 = ExecuteMemoryRegDst1 else
    "0110" when DecodeExecuteSrc1 = ExecuteMemoryRegDst1 and ExecuteMemoryInPort = '1' and ExecuteMemoryMemToReg = "00" else
    "0001" when DecodeExecuteSrc1 = ExecuteMemoryRegDst1 and ExecuteMemoryRegWrite1 = '1' and ExecuteMemoryMemToReg = "10" else -- DONE
    "0011" when DecodeExecuteSrc1 = ExecuteMemoryRegDst2 and ExecuteMemoryRegWrite2 = '1' else
    "0111" when DecodeExecuteSrc1 = MemoryWriteBackRegDst1 and MemoryWriteBackInPort = '1' and MemoryWriteBackMemToReg = "00" else
    "0010" when DecodeExecuteSrc1 = MemoryWriteBackRegDst1 and MemoryWriteBackRegWrite1 = '1' and MemoryWriteBackMemToReg = "10" else -- DONE
    "0101" when DecodeExecuteSrc1 = MemoryWriteBackRegDst1 and MemoryWriteBackRegWrite1 = '1' and MemoryWriteBackMemToReg = "01" else
    "0100" when DecodeExecuteSrc1 = MemoryWriteBackRegDst2 and MemoryWriteBackRegWrite2 = '1' else
    "0000";
    
    AluMuxSel2 <= "0000" when DecodeExecuteRegRead2 = '0' and DecodeExecuteSPSignal /= "01" else -- DONE
    "1000" when ExecuteMemorySPSignal = "10" and DecodeExecuteSrc2 = ExecuteMemoryRegDst2 else
    "0110" when DecodeExecuteSrc2 = ExecuteMemoryRegDst1 and ExecuteMemoryInPort = '1' and ExecuteMemoryMemToReg = "00" else
    "0011" when DecodeExecuteSrc2 = ExecuteMemoryRegDst2 and ExecuteMemoryRegWrite2 = '1' else
    "0001" when DecodeExecuteSrc2 = ExecuteMemoryRegDst1 and ExecuteMemoryRegWrite1 = '1' and ExecuteMemoryMemToReg = "10" else
    "0111" when DecodeExecuteSrc2 = MemoryWriteBackRegDst1 and MemoryWriteBackInPort = '1' and MemoryWriteBackMemToReg = "00" else
    "0010" when DecodeExecuteSrc2 = MemoryWriteBackRegDst1 and MemoryWriteBackRegWrite1 = '1' and MemoryWriteBackMemToReg = "10" else -- DONE
    "0101" when DecodeExecuteSrc2 = MemoryWriteBackRegDst1 and MemoryWriteBackRegWrite1 = '1' and MemoryWriteBackMemToReg = "01" else
    "0100" when DecodeExecuteSrc2 = MemoryWriteBackRegDst2 and MemoryWriteBackRegWrite2 = '1' else
    "0000";
end Behavioral;