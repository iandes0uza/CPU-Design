library verilog;
use verilog.vl_types.all;
entity encoder_4_16 is
    port(
        \out\           : out    vl_logic_vector(15 downto 0);
        \in\            : in     vl_logic_vector(3 downto 0)
    );
end encoder_4_16;
