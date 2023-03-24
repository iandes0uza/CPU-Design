library verilog;
use verilog.vl_types.all;
entity decoder_4_16 is
    port(
        decoder         : out    vl_logic_vector(3 downto 0);
        \in\            : in     vl_logic_vector(1 downto 0)
    );
end decoder_4_16;
