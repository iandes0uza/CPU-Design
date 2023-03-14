module ALU(input wire [31:0] in_A, in_B, input wire [4:0] op_code, output reg [63:0] out, input clk);

	//ALU wires (32-bit)
	wire [31:0] OR, AND, NEG, NOT, SHL, SHR, SHRA, ADD, SUB, RTR, RTL;
	
	//ALU wires (64-bit)
	wire [63:0] DIV, MULT;//, RTL, RTR;	
	
	always @(*) 
	begin
		case(op_code)
		
			5'b00001 : begin	//OR
								out[31:0] <= OR;
								out[63:32] <= 0;
						  end
			
			5'b00010 : begin	//AND
								out[31:0] <= AND;
								out[63:32] <= 0;
						  end
			
			5'b00011 : begin	//NEGATE
								out[31:0] <= ~in_B + 1;
								out[63:32] <= 0;
						  end
			
			5'b00100 : begin	//NOT
								out[31:0] <= ~in_B;
								out[63:32] <= 0;
						  end
						  
			5'b00101 : begin	//SHIFT LEFT
								out[31:0] <= SHL;
								out[63:32] <= 0;
						  end
			
			5'b00110 : begin	//SHIFT RIGHT
								out[31:0] <= SHR;
								out[63:32] <= 0;
						  end
			
			5'b00111 : begin	//ARITHMETIC SHIFT RIGHT
								out[31:0] <= in_A >>> in_B;
								out[63:32] <= 0;
						  end
						  
			5'b01000 : begin	//ROTATE LEFT
								out[31:0] <= RTL;
								out[63:32] <= 0;
						  end
			
			5'b01001 : begin	//ROTATE RIGHT
								out[31:0] <= RTR;
								out[63:32] <= 0;
						  end
			
			5'b01010 : begin	//ADD
								out[31:0] <= ADD;
								out[63:32] <= 0;
						  end
			
			5'b01011 : begin	//SUB
								out[31:0] <= SUB;
								out[63:32] <= 0;
						  end
			
			5'b01100 : begin	//MULTIPLY
								out[31:0] <= MULT[31:0];
								out[63:32] <= MULT[63:32];
						  end
			
			5'b01101 : begin	//DIVIDE
								out[31:0] <= DIV[31:0];
								out[63:32] <= DIV[63:32];
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
	arithmetic_add a_add(in_A, in_B, ADD);
	arithmetic_sub a_sub(in_A, in_B, SUB);
	arithmetic_mult a_mult(in_A, in_B, MULT);
	arithmetic_div a_div(in_A, in_B, DIV);

endmodule