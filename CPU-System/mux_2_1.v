`timescale 1ns/10ps
module mux_2_1(output reg[31:0] out, input enable, input wire[31:0] a, b);

	always@(*)
	begin
		if (enable)
			out <= b;
		else
			out <= a;
	end

endmodule