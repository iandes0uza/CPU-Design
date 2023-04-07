`timescale 1ns/10ps
module alu(input wire [31:0] in_A, in_B, input wire [4:0] op_code, output reg [63:0] out, input bf, clk);

	//ALU wires (32-bit)
	wire [31:0] OR, AND, NEG, NOT, SHL, SHR, SHRA, ADD, SUB, RTR, RTL;
	
	//C_OUT Wires
	wire ADD_cout, SUB_cout;
	
	//ALU wires (64-bit)
	wire [63:0] DIV, MULT;
	
	always @(*) begin
		case(op_code)
		
			5'b00110,			//OR
			5'b01110 : begin	//OR IMM
								out[31:0] <= OR;
								out[63:32] <= 0;
						  end
			
			5'b00101,			//AND
			5'b01101 : begin	//ANDIMM
								out[31:0] <= AND;
								out[63:32] <= 0;
						  end
			
			5'b10001 : begin	//NEGATE
								out[31:0] <= ~in_B + 1;
								out[63:32] <= 0;
						  end
			
			5'b10010 : begin	//NOT
								out[31:0] <= ~in_B;
								out[63:32] <= 0;
						  end
						  
			5'b01001 : begin	//SHIFT LEFT
								out[31:0] <= SHL;
								out[63:32] <= 0;
						  end
			
			5'b00111 : begin	//SHIFT RIGHT
								out[31:0] <= SHR;
								out[63:32] <= 0;
						  end
			
			5'b01000 : begin	//ARITHMETIC SHIFT RIGHT
								out[31:0] <= in_A >>> in_B;
								out[63:32] <= 0;
						  end
						  
			5'b01011 : begin	//ROTATE LEFT
								out[31:0] <= RTL;
								out[63:32] <= 0;
						  end
			
			5'b01010 : begin	//ROTATE RIGHT
								out[31:0] <= RTR;
								out[63:32] <= 0;
						  end
			
			5'b00011,			//ADD
			5'b01100 : begin	//ADD IMM
								out[31:0] <= ADD;
								out[63:32] <= 0;
						  end
			
			5'b00100 : begin	//SUB
								out[31:0] <= SUB;
								out[63:32] <= 0;
						  end
			
			5'b01111 : begin	//MULTIPLY
								out[31:0] <= MULT[31:0];
								out[63:32] <= MULT[63:32];
						  end
			
			5'b10000 : begin	//DIVIDE
								out[31:0] <= DIV[31:0];
								out[63:32] <= DIV[63:32];
						  end
						  
			5'b00000, 			//LOAD
			5'b00001,			//LOADI
			5'b00010 : begin	//STORE
								out[31:0] <= ADD[31:0];
								out[63:32] <= 0;
						  end
			5'b10011 : begin	//BRANCH
								if(bf) begin
									out[31:0] <= ADD[31:0];
									out[63:32] <= 32'd0;
								end
								else begin
									out[31:0] <= in_A;
									out[63:32] <= 32'd0;
								end
						  end
			 default : out = 0;
		endcase
	end
	
	//ALU Logical Operations
	logical_or l_or(in_A, in_B, OR);				
	logical_and l_and(in_A, in_B, AND);
	logical_negate l_neg(in_A, NEG);
	logical_not l_not(in_A, NOT);
	
	//ALU Movement Operations
	shift_left s_left(in_A, in_B, SHL);
	shift_right s_right(in_A, in_B, SHR);
	ar_shift_right a_s_right(in_A, in_B, SHRA);
	rotate_left rot_left(in_A, in_B[4:0], RTL);
	rotate_right rot_right(in_A, in_B[4:0], RTR);
	
	//ALU Arithmetic Operations
	arithmetic_add a_add(in_A, in_B, ADD_cout, ADD);
	arithmetic_sub a_sub(in_A, in_B, SUB_cout, SUB);
	arithmetic_mult a_mult(in_A, in_B, MULT);
	arithmetic_div a_div(in_A, in_B, DIV);

endmodule