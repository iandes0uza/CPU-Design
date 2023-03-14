module bitpair_mult(input wire[31:0] a, b, output wire[63:0] result);

	//bitpair_mult bpm(b, a, result);

endmodule
/*
module booth_algo(input wire[31:0] q, output wire[31:0] sign, value);

	wire[31:0] q_shifted = q << 1;
	assign value = q ^ q_shifted;
	assign sign = value & q;
	
endmodule*/

module arithmetic_mult(input wire[31:0] m, q, output wire[63:0] out);
	
	wire signed [63:0] q_shifted = q << 1;
	reg signed [63:0] sum = 64'b0, temp = 64'b0;
	reg signed [31:0] hold = 32'b0;
	wire signed [31:0] negativeM = -m;
	integer i;
	
	always@(*) begin
		for(i=0;i<16;i=i+1)begin
			case({q[2*i+1],q[2*i],q_shifted[2*i]})
				3'b000 , 3'b111 : hold = 32'b0;
				default : begin
								case({q[2*i+1],q[2*i],q_shifted[2*i]})
									3'b001 , 3'b010 : hold = {m[31], m};
									3'b011 : hold = {m, 1'b0};
									3'b100 : hold = {negativeM, 1'b0};
									3'b101 , 3'b110 : hold = negativeM;
								endcase
								temp[63:0] = hold << (2*i);
								sum = sum + (temp);
							 end
			endcase
		end
	end 
   assign out = sum;
endmodule

/*
module bitpair_recoding(input wire[1:0] sign, value, output integer val);

	integer temp;
	
	initial begin
		case(value)
			2'b00 : temp = 0;
			2'b01 : begin
							temp = 1;
							if (sign[0])
								temp = -1;
					  end
			2'b10 : begin
							temp = 2;
							if (sign[1])
								temp = -2;
					  end
			2'b11 : begin
							temp = -1;
							if (sign[0])
								temp = 1;
					  end
			default: temp = -9999;
		endcase
	val = temp;
	end
endmodule
*/