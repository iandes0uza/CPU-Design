`timescale 1ns/10ps
module conff(output reg con_out, input [1:0] c2_field, input [31:0] bus, input con_in);

	wire [3:0] decoder_line;
	wire zero, nonzero, pos, neg, busNor;
	
	decoder_4_16 yup(decoder_line, c2_field);
	
	assign busNor = ~|bus;
	
	assign zero = busNor & decoder_line[0];
	assign nonzero = !busNor & decoder_line[1];
	assign pos = !bus[31] & decoder_line[2];
	assign neg = bus[31] & decoder_line[3];
	
	assign flag = zero | nonzero | pos | neg;
	
	always@(con_in)
	begin
		con_out <= flag;
	end
	

endmodule

module decoder_4_16(output reg [3:0] decoder, input [1:0]in);

	always@(in)
	begin
		case(in)
		2'b00: decoder = 4'b0001;
		2'b01: decoder = 4'b0010;
		2'b10: decoder = 4'b0100;
		2'b11: decoder = 4'b1000;
		default: decoder = 4'b0000;
		endcase
		
	end
	
endmodule