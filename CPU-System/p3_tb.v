`timescale 1ns/10ps

module p3_tb;

	wire[31:0] data_in, data_out, bus;
	wire [4:0] opcode;
	reg clk, rst, stp;

cpu DUT(opcode, data_out, bus, data_in, clk, rst, stp);

initial
	begin
		clk = 0;
		rst = 0;
end

always
		#10 clk <= ~clk;
endmodule