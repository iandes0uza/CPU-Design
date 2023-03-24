library verilog;
use verilog.vl_types.all;
entity conff is
    port(
        con_out         : out    vl_logic;
        c2_field        : in     vl_logic_vector(1 downto 0);
        \bus\           : in     vl_logic_vector(31 downto 0);
        con_in          : in     vl_logic
    );
end conff;
