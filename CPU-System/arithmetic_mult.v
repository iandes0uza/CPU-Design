`timescale 1ns/10ps
module bitpair_mult(input wire[31:0] a, b, output wire[63:0] result);

	//bitpair_mult bpm(b, a, result);

endmodule
/*
module booth_algo(input wire[31:0] q, output wire[31:0] sign, value);

	wire[31:0] q_shifted = q << 1;
	assign value = q ^ q_shifted;
	assign sign = value & q;
	
endmodule*/


module arithmetic_mult(input signed [31:0] m, q, output[63:0] out);

    reg [2:0] bit_pair [15:0]; 				
    reg signed [32:0] hold [15:0];  		
    reg signed [63:0] shifted_hold [15:0];
	 reg signed [63:0] sum = 0;
	 wire signed[32:0] negativeM;
	 assign negativeM = -m;
	 integer i;
	 always @ (m or q or negativeM)
    begin
        bit_pair[0] = {q[1], q[0], 1'b0};
        for(i=1;i<16;i=i+1) begin
             bit_pair[i] = {q[2*i+1],q[2*i],q[2*i-1]};
        end
        for(i=0;i<16;i=i+1)begin
            case(bit_pair[i])
                3'b001 , 3'b010 : hold[i] = {m[31],m};
                3'b011 : hold[i] = {m,1'b0};
                3'b100 : hold[i] = {negativeM[31:0],1'b0};
                3'b101 , 3'b110 : hold[i] = negativeM;
                default : hold[i] = 0;
            endcase
            shifted_hold[i] = hold[i] << (2*i);
        end
        sum = shifted_hold[0];
        for(i=1;i<16;i=i+1) begin
          sum = sum + shifted_hold[i];
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