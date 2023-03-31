library verilog;
use verilog.vl_types.all;
entity cpu is
    port(
        opcode          : out    vl_logic_vector(4 downto 0);
        outport_data    : out    vl_logic_vector(31 downto 0);
        \bus\           : out    vl_logic_vector(31 downto 0);
        inport_data     : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        stp             : in     vl_logic
    );
end cpu;
