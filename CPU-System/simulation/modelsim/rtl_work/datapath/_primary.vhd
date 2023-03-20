library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        pc_out          : in     vl_logic;
        zlo_out         : in     vl_logic;
        zhi_out         : in     vl_logic;
        mdr_out         : in     vl_logic;
        mar_in          : in     vl_logic;
        zlo_enable      : in     vl_logic;
        zhi_enable      : in     vl_logic;
        pc_enable       : in     vl_logic;
        mdr_enable      : in     vl_logic;
        mdr_read        : in     vl_logic;
        ir_enable       : in     vl_logic;
        y_enable        : in     vl_logic;
        pc_increment    : in     vl_logic;
        lo_enable       : in     vl_logic;
        hi_enable       : in     vl_logic;
        op_code         : in     vl_logic_vector(4 downto 0);
        data_in         : in     vl_logic_vector(31 downto 0);
        r6_enable       : in     vl_logic;
        r7_enable       : in     vl_logic;
        r6_out          : in     vl_logic;
        r7_out          : in     vl_logic;
        clr             : in     vl_logic;
        clk             : in     vl_logic;
        data_lo         : out    vl_logic_vector(31 downto 0);
        data_hi         : out    vl_logic_vector(31 downto 0)
    );
end datapath;
