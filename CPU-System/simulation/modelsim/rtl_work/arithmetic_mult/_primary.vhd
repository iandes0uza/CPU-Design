library verilog;
use verilog.vl_types.all;
entity arithmetic_mult is
    port(
        m               : in     vl_logic_vector(31 downto 0);
        q               : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(63 downto 0)
    );
end arithmetic_mult;
