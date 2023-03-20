library verilog;
use verilog.vl_types.all;
entity encoder_32_5 is
    port(
        \in\            : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(4 downto 0)
    );
end encoder_32_5;
