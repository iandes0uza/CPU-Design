library verilog;
use verilog.vl_types.all;
entity select_encoder is
    port(
        ir              : in     vl_logic_vector(31 downto 0);
        rIN             : in     vl_logic;
        rOUT            : in     vl_logic;
        baOUT           : in     vl_logic;
        gra             : in     vl_logic;
        grb             : in     vl_logic;
        grc             : in     vl_logic;
        data_sign       : out    vl_logic_vector(31 downto 0);
        reg_in          : out    vl_logic_vector(15 downto 0);
        reg_out         : out    vl_logic_vector(15 downto 0);
        op              : out    vl_logic_vector(4 downto 0);
        decode          : out    vl_logic_vector(3 downto 0)
    );
end select_encoder;
