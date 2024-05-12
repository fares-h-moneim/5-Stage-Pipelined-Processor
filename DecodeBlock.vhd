library ieee;
use ieee.std_logic_1164.all;


ENTITY DecodeBlock IS
    PORT(
        clk : IN std_logic;
        reset : IN std_logic;
        we : IN std_logic;
        we2 : IN std_logic;
        w_address : IN std_logic_vector(2 DOWNTO 0);
        w_address2 : IN std_logic_vector(2 DOWNTO 0);
        r_address1 : IN std_logic_vector(2 DOWNTO 0);
        r_address2 : IN std_logic_vector(2 DOWNTO 0);
        data_in   : IN std_logic_vector(31 DOWNTO 0);
        data_in2   : IN std_logic_vector(31 DOWNTO 0);
        dataout_1 : OUT std_logic_vector(31 DOWNTO 0);
        dataout_2 : OUT std_logic_vector(31 DOWNTO 0);
        Opcode : in std_logic_vector(5 downto 0);
        IsInstructionIn : in std_logic;
        AluSelector : out std_logic_vector(3 downto 0);
        AluSrc : out std_logic;
        MemWrite : out std_logic;
        MemRead : out std_logic;
        MemToReg : out std_logic_vector(1 downto 0);
        RegWrite : out std_logic;
        RegWrite2 : out std_logic;
        SpPointers : out std_logic_vector(1 downto 0);
        ProtectWrite : out std_logic;
        FreeWrite : out std_logic;
        Branching : out std_logic;
        IsInstructionOut : out std_logic;
        OutEnable : out std_logic;
        RegRead1 : out std_logic;
        RegRead2 : out std_logic;
        InPortInstruction : out std_logic
    );
END DecodeBlock;

architecture Behavioral of DecodeBlock IS
    component RegisterFile is
        PORT(
            clk : IN std_logic;
            reset : IN std_logic;
            we : IN std_logic;
            we2 : IN std_logic;
            w_address : IN std_logic_vector(2 DOWNTO 0);
            w_address2 : IN std_logic_vector(2 DOWNTO 0);
            r_address1 : IN std_logic_vector(2 DOWNTO 0);
            r_address2 : IN std_logic_vector(2 DOWNTO 0);
            data_in   : IN std_logic_vector(31 DOWNTO 0);
            data_in2   : IN std_logic_vector(31 DOWNTO 0);
            dataout_1 : OUT std_logic_vector(31 DOWNTO 0);
            dataout_2 : OUT std_logic_vector(31 DOWNTO 0)
        );
    END component;

    component Control is
        port(
            reset : in std_logic;
            Opcode : in std_logic_vector(5 downto 0);
            IsInstructionIn : in std_logic;

            AluSelector : out std_logic_vector(3 downto 0);
            AluSrc : out std_logic;
            MemWrite : out std_logic;
            MemRead : out std_logic;
            MemToReg : out std_logic_vector(1 downto 0); -- 10 writes from ALU to register, 01 writes from Memory to register, 00 writes from inport to register;
            RegWrite : out std_logic;
            RegWrite2 : out std_logic;
            SpPointers : out std_logic_vector(1 downto 0);
            ProtectWrite : out std_logic;
            FreeWrite : out std_logic;
            Branching : out std_logic;
            IsInstructionOut : out std_logic; -- Corrected syntax error here, no semicolon needed before this declaration
            OutEnable : out std_logic;
            RegRead1 : out std_logic;
            RegRead2 : out std_logic;
            InPortInstruction : out std_logic
        );
    END component;


    begin
        RegisterFile1: RegisterFile PORT MAP(
            clk => clk,
            reset => reset,
            we => we,
            we2 => we2,
            w_address => w_address,
            w_address2 => w_address2,
            r_address1 => r_address1,
            r_address2 => r_address2,
            data_in => data_in,
            data_in2 => data_in2,
            dataout_1 => dataout_1,
            dataout_2 => dataout_2
        );

        Control1: Control PORT MAP(
            reset => reset,
            Opcode => Opcode,
            IsInstructionIn => IsInstructionIn,
            AluSelector => AluSelector,
            AluSrc => AluSrc,
            MemWrite => MemWrite,
            MemRead => MemRead,
            MemToReg => MemToReg,
            RegWrite => RegWrite,
            RegWrite2 => RegWrite2,
            SpPointers => SpPointers,
            ProtectWrite => ProtectWrite,
            FreeWrite => FreeWrite,
            Branching => Branching,
            IsInstructionOut => IsInstructionOut,
            OutEnable => OutEnable,
            RegRead1 => RegRead1,
            RegRead2 => RegRead2,
            InPortInstruction => InPortInstruction
        );
end Behavioral;
