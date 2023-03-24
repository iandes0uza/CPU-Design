library verilog;
use verilog.vl_types.all;
entity arithmetic_sub is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        c_out           : out    vl_logic;
        result          : out    vl_logic_vector(31 downto 0)
    );
end arithmetic_sub;
