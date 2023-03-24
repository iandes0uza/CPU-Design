library verilog;
use verilog.vl_types.all;
entity ram is
    port(
        ram_out         : out    vl_logic_vector(31 downto 0);
        ram_in          : in     vl_logic_vector(31 downto 0);
        addr            : in     vl_logic_vector(8 downto 0);
        en              : in     vl_logic;
        clk             : in     vl_logic
    );
end ram;
