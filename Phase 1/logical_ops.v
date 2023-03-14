module logical_or(input wire [31:0] a, b, output wire [31:0] result);

	assign result = a | b;

endmodule


module logical_and(input wire [31:0] a, b, output wire [31:0] result);

	assign result = a & b;

endmodule


module logical_not(input wire [31:0] a, output wire [31:0] result);

	assign result = ~a;

endmodule


module logical_negate(input wire [31:0] a, output wire [31:0] result);

	assign result = ~a + 1;

endmodule
