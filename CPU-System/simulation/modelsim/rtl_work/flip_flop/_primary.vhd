library verilog;
use verilog.vl_types.all;
entity flip_flop is
    port(
        q               : out    vl_logic;
        q_bar           : out    vl_logic;
        d               : in     vl_logic;
        clk             : in     vl_logic
    );
end flip_flop;
