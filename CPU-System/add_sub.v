module arithmetic_sub(input wire[31:0] a, b, output wire[31:0] result);

	wire c_out;
	RCA32 sum(c_out, result[31:0], a[31:0], (b[31:0])*(-1), 1'b0);
	//RCA64 sum(c_out, result[31:0], a[31:0], b[31:0], c_in);
	
	//IF C_OUT == 1, there is overflow
		
endmodule


module arithmetic_add(input wire [31:0] a, b, output wire [31:0] result);

	wire c_out;
	RCA32 sum(c_out, result[31:0], a[31:0], b[31:0], 1'b0);
	//RCA64 sum(c_out, result[31:0], a[31:0], b[31:0], c_in);
	
	//IF C_OUT == 1, there is overflow
		
endmodule




//In these functions we will use a 32-bit RCA
//We will start with a half-adder and build up to 32-bit

//Half-Adder
module HA(output c_out, sum, input a, b);
	
	xor (sum, a, b);
	and (c_out, a, b);
		
endmodule


//Full-Adder
module FA(output c_out, sum, input a, b, c_in);

	wire wire_1, wire_2, wire_3;

	HA HA_1(wire_2, wire_1, a, b);
	HA HA_2(wire_3, sum, c_in, wire_1);
	or (c_out, wire_3, wire_2);

endmodule


//4-bit Ripple Carry Adder
module RCA4(output c_out, output wire[3:0] sum, input wire[3:0] a, b, input c_in);

	wire wire_1, wire_2, wire_3;

	FA FA_1(wire_1, sum[0], a[0], b[0], c_in);
	FA FA_2(wire_2, sum[1], a[1], b[1], wire_1);
	FA FA_3(wire_3, sum[2], a[2], b[2], wire_2);
	FA FA_4(c_out, sum[3], a[3], b[3], wire_3);
	
endmodule


//16-bit Ripple Carry Adder
module RCA16(output c_out, output wire[15:0] sum, input wire[15:0] a, b, input c_in); 

	wire wire_1, wire_2, wire_3;
	
	RCA4 RCA4_1(wire_1, sum[3:0], a[3:0], b[3:0], c_in);
	RCA4 RCA4_2(wire_2, sum[7:4], a[7:4], b[7:4], wire_1);
	RCA4 RCA4_3(wire_3, sum[11:8], a[11:8], b[11:8], wire_2);
	RCA4 RCA4_4(c_out, sum[15:12], a[15:12], b[15:12], wire_3);
	
endmodule


//32-bit Ripple Carry Adder
module RCA32(output c_out, output wire[31:0] sum, input wire[31:0] a, b, input c_in);

	wire wire_1;
	
	RCA16 RCA16_1(wire_1, sum[15:0], a[15:0], b[15:0], c_in);
	RCA16 RCA16_2(c_out, sum[31:16], a[31:16], b[31:16], wire_1);
	
endmodule

//64-bit Ripple Carry Adder (UNUSED)
module RCA64(output c_out, output wire[63:0] sum, input wire[63:0] a, b, input c_in);

	wire wire_1, wire_2, wire_3;
	
	RCA16 RCA16_1(wire_1, sum[15:0], a[15:0], b[15:0], c_in);
	RCA16 RCA16_2(wire_2, sum[31:16], a[31:16], b[31:16], wire_1);
	RCA16 RCA16_3(wire_3, sum[47:32], a[47:32], b[47:32], wire_2);
	RCA16 RCA16_4(c_out, sum[63:48], a[63:48], b[63:48], wire_3);
	
endmodule


