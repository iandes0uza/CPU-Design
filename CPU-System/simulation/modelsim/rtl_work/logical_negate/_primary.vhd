library verilog;
use verilog.vl_types.all;
entity logical_negate is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end logical_negate;
