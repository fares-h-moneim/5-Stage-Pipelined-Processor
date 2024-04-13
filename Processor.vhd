library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processor is
    port (
        Clk, Rst : in std_logic
    );
end entity Processor;

architecture Behavioral of Processor is
    ------------- Fetch ------------
    component FetchBlock is
        port (
            clk : in std_logic;
            rst : in std_logic;
            instruction : OUT std_logic_vector(15 DOWNTO 0);
            immediate : OUT std_logic_vector(15 DOWNTO 0)
        );
    end component FetchBlock;

    component FetchDecode is
        port(
            clk: in std_logic;
            reset: in std_logic;
            instructionIn: in std_logic_vector(15 downto 0);
            instructionOut: out std_logic_vector(15 downto 0);
            immediatein: in std_logic_vector(15 downto 0);
            immediateout: out std_logic_vector(15 downto 0)
        );
    end component FetchDecode;

    ------------- Decode ------------
    component RegisterFile is
        port(
            clk : IN std_logic;
            we : IN std_logic;
            w_address : IN std_logic_vector(2 DOWNTO 0);
            r_address1 : IN std_logic_vector(2 DOWNTO 0);
            r_address2 : IN std_logic_vector(2 DOWNTO 0);
            data_in   : IN std_logic_vector(31 DOWNTO 0);
            dataout_1 : OUT std_logic_vector(31 DOWNTO 0);
            dataout_2 : OUT std_logic_vector(31 DOWNTO 0)
        );
    end component RegisterFile;

    component Control is
        port(
            Opcode : in std_logic_vector(5 downto 0);
            AluSelector : out std_logic_vector(3 downto 0);
            AluSrc : out std_logic;
            MemWrite : out std_logic;
            MemRead : out std_logic;
            MemToReg : out std_logic_vector(1 downto 0);
            RegWrite : out std_logic;
            RegWrite2 : out std_logic;
            SpPointers : out std_logic_vector(1 downto 0);
            ProtectWrite : out std_logic;
            Branching : out std_logic
        );
    end component Control;

    component SignExtend is 
        port(
            input : in std_logic_vector(15 downto 0);
            output : out std_logic_vector(31 downto 0)
        );
    end component SignExtend;

    component DecodeExecute is
        port(
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
            ReadData1 : IN std_logic_vector(31 downto 0);
            ReadData2 : IN std_logic_vector(31 downto 0);
            Destination : IN std_logic_vector(2 downto 0);
            Imm : IN std_logic_vector(31 downto 0);

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
    end component DecodeExecute;

    

    ------------- Execute ------------

    component ExecuteBlock is
        port (
            clk : in std_logic;
            reset : in std_logic;
            AluSrc : in std_logic;
            ReadData1 : in std_logic_vector(31 downto 0);
            ReadData2 : in std_logic_vector(31 downto 0);
            Immediate : in std_logic_vector(31 downto 0);
            AluSelector : in std_logic_vector(3 downto 0);
            
            ZeroFlag : out std_logic;
            AluOut : out std_logic_vector(31 downto 0)
        );
    end component ExecuteBlock;

    component ExecuteMemory is
        port (
            clk : in std_logic;
            reset : in std_logic;
            ZeroFlagIn : in std_logic;
            RegDst : in std_logic_vector(2 downto 0);
            AluResultIn : in std_logic_vector(31 downto 0);
            ReadData2 : out std_logic_vector(31 downto 0);
            MemWrite : in std_logic;
            MemRead : in std_logic;
            MemToReg : in std_logic_vector (1 downto 0);
            RegWrite : in std_logic;
            SpPointers : in std_logic_vector(1 downto 0);
            ProtectWrite : in std_logic;
            Branching : in std_logic;
    
            ZeroFlagOut : out std_logic;
            RegDstOut : out std_logic_vector(2 downto 0);
            AluResultOut : out std_logic_vector(31 downto 0);
            ReadData2Out : out std_logic_vector(31 downto 0);
            MemWriteOut : out std_logic;
            MemReadOut : out std_logic;
            MemToRegOut : out std_logic_vector(1 downto 0);
            RegWriteOut : out std_logic;
            SpPointersOut : out std_logic_vector(1 downto 0);
            ProtectWriteOut : out std_logic;
            BranchingOut : out std_logic
        );
    end component ExecuteMemory;

    ------------- Memory -------------

    COMPONENT DataMemory IS
    PORT (
            clk : IN std_logic;
            address : IN std_logic_vector(11 DOWNTO 0);
            data_in : IN std_logic_vector(31 DOWNTO 0);
            mem_write : IN std_logic;
            mem_read : IN std_logic;
            read_data : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT DataMemory;

    COMPONENT MemoryWriteBack IS
        PORT(
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            MemToReg : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            RegWrite : IN STD_LOGIC;
            RegWrite2 : IN STD_LOGIC;
            MemoryData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            AluResult : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            RegDst : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

            MemToRegOut : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            RegWriteOut : OUT STD_LOGIC;
            RegWrite2Out : OUT STD_LOGIC;
            MemoryDataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            AluResultOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            RegDstOut : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT MemoryWriteBack;

    ------------- Write Back ------------
    component WriteBackBlock is 
    port (
        clk : in std_logic;
        reset : in std_logic;
        MemToReg : in std_logic_vector(1 downto 0);
        MemoryOutput : in std_logic_vector(31 downto 0);
        ALUOutput : in std_logic_vector(31 downto 0);
        WriteData: out std_logic_vector(31 downto 0)
    );
    end component WriteBackBlock;
    
    ----------- Signals Fetch ------------
    
    signal fetch_instruction_out, fetch_immediate_out : std_logic_vector(15 downto 0); -- WHAT COMES OUT OF FETCHDECODE
    signal internal_fetch_instruction, internal_fetch_immediate : std_logic_vector(15 downto 0); -- WHAT COMES OUT OF FETCH BLOCK

    ----------- Signals Decode ------------
    signal read_data1, read_data2 : std_logic_vector(31 downto 0); -- WHAT COMES OUT OF REGISTER FILE
    signal reg_write : std_logic; -- write enable for register file
    signal decode_alu_selector : std_logic_vector(3 downto 0); -- WHAT COMES OUT OF CONTROL
    signal decode_alu_src : std_logic; -- WHAT COMES OUT OF CONTROL 
    signal decode_mem_write : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_mem_read : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_mem_to_reg : std_logic_vector(1 downto 0); -- WHAT COMES OUT OF CONTROL
    signal decode_reg_write : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_sp_pointers : std_logic_vector(1 downto 0); -- WHAT COMES OUT OF CONTROL
    signal decode_protect_write : std_logic; -- WHAT COMES OUT OF CONTROL
    signal decode_branching : std_logic; -- WHAT COMES OUT OF CONTROL
    
    ----------- Signals Execute -----------
    signal execute_zero_out : std_logic;
    signal execute_alu_out : std_logic_vector(31 downto 0);
    signal execute_alu_selector : std_logic_vector(3 downto 0);
    signal execute_alu_src : std_logic;
    signal execute_immediate : std_logic_vector(31 downto 0);
    signal execute_read_data1 : std_logic_vector(31 downto 0);
    signal execute_read_data2 : std_logic_vector(31 downto 0);
    signal execute_mem_write : std_logic;
    signal execute_mem_read : std_logic;
    signal execute_mem_to_reg : std_logic_vector(1 downto 0);
    signal execute_reg_write : std_logic;
    signal execute_reg_write2 : std_logic;
    signal execute_sp_pointers : std_logic_vector(1 downto 0);
    signal execute_protect_write : std_logic;
    signal execute_branching : std_logic;
    signal execute_reg_destination : std_logic_vector(2 downto 0);

    ----------- Signals Memory ------------
    signal memory_zero_out : std_logic;
    signal memory_alu_out : std_logic_vector(31 downto 0);
    signal memory_read_data_output : std_logic_vector(31 downto 0);
    signal memory_mem_write : std_logic;
    signal memory_mem_read : std_logic;
    signal memory_mem_to_reg : std_logic_vector(1 downto 0);
    signal memory_reg_write : std_logic;
    signal memory_sp_pointers : std_logic_vector(1 downto 0);
    signal memory_protect_write : std_logic;
    signal memory_branching : std_logic;
    signal memory_read_data2 : std_logic_vector(31 downto 0);
    signal memory_reg_destination : std_logic_vector(2 downto 0);
    signal memory_reg_write2 : std_logic;

    --------- Signals Write Back ----------
    signal WriteBackData : std_logic_vector(31 downto 0);
    signal write_back_mem_to_reg : std_logic_vector(1 downto 0);
    signal write_back_reg_write : std_logic;
    signal write_back_reg_write2 : std_logic;
    signal write_back_data_output : std_logic_vector(31 downto 0);
    signal write_back_alu_out : std_logic_vector(31 downto 0);
    signal write_back_reg_destination : std_logic_vector(2 downto 0);
    begin
        ----------- Fetch ------------
        FetchBlock1: FetchBlock port map (
                                            Clk, Rst, internal_fetch_instruction,
                                            internal_fetch_immediate
                                        );

        FetchDecode1: FetchDecode port map (
                                            Clk, Rst, internal_fetch_instruction,
                                            fetch_instruction_out, internal_fetch_immediate, fetch_immediate_out
                                        );
        
        ----------- Decode ------------
        Registers: RegisterFile port map (
                                            Clk, write_back_reg_write, write_back_reg_destination,
                                            fetch_instruction_out(9 downto 7), fetch_instruction_out(3 downto 1),
                                            WriteBackData, read_data1, read_data2
                                        );

        SignExtend1: SignExtend port map (
                                            fetch_immediate_out, execute_immediate
                                        );

        ControlUnit: Control port map (
                                        fetch_instruction_out(15 downto 10), execute_alu_selector, execute_alu_src,
                                        execute_mem_write, execute_mem_read, execute_mem_to_reg, execute_reg_write,
                                        execute_reg_write2, execute_sp_pointers, execute_protect_write, execute_branching
                                    );

        DecodeExecute1: DecodeExecute port map (
                                                Clk, Rst, '1', decode_alu_selector,
                                                decode_alu_src, decode_mem_write, decode_mem_read,
                                                decode_mem_to_reg, decode_reg_write, decode_sp_pointers, decode_protect_write,
                                                decode_branching, read_data1, read_data2,
                                                fetch_instruction_out(6 downto 4), execute_immediate, execute_alu_selector,
                                                execute_alu_src, execute_mem_write, execute_mem_read,
                                                execute_mem_to_reg, execute_reg_write, execute_sp_pointers,
                                                execute_protect_write, execute_branching, execute_read_data1,
                                                execute_read_data2, execute_reg_destination, execute_immediate
                                            );

        ----------- Execute ------------

        ExecuteBlock1: ExecuteBlock port map (
                                                Clk, Rst, execute_alu_src,
                                                execute_read_data1, execute_read_data2, execute_immediate,
                                                execute_alu_selector, execute_zero_out, execute_alu_out
                                            );

        ExecuteMemory1: ExecuteMemory port map (
                                                Clk, Rst, execute_zero_out,
                                                execute_reg_destination, execute_alu_out, read_data2, execute_mem_write,
                                                execute_mem_read, execute_mem_to_reg, execute_reg_write,
                                                execute_sp_pointers, execute_protect_write, execute_branching,
                                                memory_zero_out, memory_reg_destination, memory_alu_out, memory_read_data2,
                                                memory_mem_write, memory_mem_read, memory_mem_to_reg,
                                                memory_reg_write, memory_sp_pointers, memory_protect_write,
                                                memory_branching
                                            );

        ----------- Memory -------------

        DataMemory1: DataMemory port map (
                                            Clk, memory_alu_out(11 downto 0), memory_alu_out(31 downto 0),
                                            memory_mem_write, memory_mem_read,
                                            memory_read_data_output
                                        );

        MemoryWriteBack1: MemoryWriteBack port map (
                                                    Clk, Rst, '1', memory_mem_to_reg,
                                                    memory_reg_write, memory_reg_write2, memory_read_data_output,
                                                    memory_alu_out, memory_reg_destination, write_back_mem_to_reg, write_back_reg_write,
                                                    write_back_reg_write2, write_back_data_output, write_back_alu_out,
                                                    write_back_reg_destination
                                                );

        ----------- Write Back ------------
        WriteBackBlock1: WriteBackBlock port map(Clk, Rst, write_back_mem_to_reg, write_back_data_output, write_back_alu_out, WriteBackData);
end architecture Behavioral;