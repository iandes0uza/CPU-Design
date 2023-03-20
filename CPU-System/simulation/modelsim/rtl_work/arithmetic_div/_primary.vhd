library verilog;
use verilog.vl_types.all;
entity arithmetic_div is
    port(
        in_a            : in     vl_logic_vector(31 downto 0);
        in_b            : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(63 downto 0)
    );
end arithmetic_div;
