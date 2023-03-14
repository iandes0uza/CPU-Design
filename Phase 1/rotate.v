module shift_left(input wire[31:0] a, input wire[31:0] b, output wire[31:0] result);

	assign result = a << b;

endmodule


module shift_right(input wire[31:0] a, input wire[31:0] b, output wire[31:0] result);

	assign result = a >> b;

endmodule

module ar_shift_right(input wire[31:0] a, input wire[31:0] b, output wire[31:0] result);

	assign result = a >>> b;

endmodule


module rotate_left(input wire[31:0] a, input wire[4:0] b, output reg[31:0] result);

	integer rol_bits;
	always@(*)
	begin
		rol_bits = b;
		result = (a << rol_bits) | (a >> 32-rol_bits);
	end

endmodule


module rotate_right(input wire[31:0] a, input wire[4:0] b, output reg[31:0] result);

	integer ror_bits;
	always@(*)
	begin
		ror_bits = b;
		result = (a >> ror_bits) | (a << 32-ror_bits);
	end

endmodule
