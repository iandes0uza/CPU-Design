library verilog;
use verilog.vl_types.all;
entity RCA64 is
    port(
        c_out           : out    vl_logic;
        sum             : out    vl_logic_vector(63 downto 0);
        a               : in     vl_logic_vector(63 downto 0);
        b               : in     vl_logic_vector(63 downto 0);
        c_in            : in     vl_logic
    );
end RCA64;
