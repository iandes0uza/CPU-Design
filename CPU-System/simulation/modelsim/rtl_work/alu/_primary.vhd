library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        in_A            : in     vl_logic_vector(31 downto 0);
        in_B            : in     vl_logic_vector(31 downto 0);
        op_code         : in     vl_logic_vector(4 downto 0);
        \out\           : out    vl_logic_vector(63 downto 0);
        bf              : in     vl_logic;
        clk             : in     vl_logic
    );
end alu;
