library verilog;
use verilog.vl_types.all;
entity pc_reg is
    port(
        pc_out          : out    vl_logic_vector(31 downto 0);
        pc_in           : in     vl_logic_vector(31 downto 0);
        pc_inc          : in     vl_logic;
        enable          : in     vl_logic;
        clk             : in     vl_logic
    );
end pc_reg;
