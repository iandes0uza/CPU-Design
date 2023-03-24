library verilog;
use verilog.vl_types.all;
entity gen_regs is
    generic(
        qInitial        : integer := 0
    );
    port(
        q               : out    vl_logic_vector(31 downto 0);
        d               : in     vl_logic_vector(31 downto 0);
        en              : in     vl_logic;
        clr             : in     vl_logic;
        clk             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of qInitial : constant is 1;
end gen_regs;
