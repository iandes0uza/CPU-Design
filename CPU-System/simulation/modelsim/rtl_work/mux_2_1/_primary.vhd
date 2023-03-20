library verilog;
use verilog.vl_types.all;
entity mux_2_1 is
    port(
        \out\           : out    vl_logic_vector(31 downto 0);
        enable          : in     vl_logic;
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0)
    );
end mux_2_1;
