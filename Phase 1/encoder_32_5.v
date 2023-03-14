module encoder_32_5(input wire [31:0] in, output reg [4:0] out);

	always @(*)
	begin
		case(in)
		
			//Based of Input, turn on respective bits
			//All HIGH == no select
			31'h00000001 : out = 5'b00000;
			31'h00000002 : out = 5'b00001;
			31'h00000004 : out = 5'b00010;
			31'h00000008 : out = 5'b00011;
			31'h00000010 : out = 5'b00100;
			31'h00000020 : out = 5'b00101;
			31'h00000040 : out = 5'b00110;
			31'h00000080 : out = 5'b00111;
			31'h00000100 : out = 5'b01000;
			31'h00000200 : out = 5'b01001;
			31'h00000400 : out = 5'b01010;
			31'h00000800 : out = 5'b01011;
			31'h00001000 : out = 5'b01100;
			31'h00002000 : out = 5'b01101;
			31'h00004000 : out = 5'b01110;
			31'h00008000 : out = 5'b01111;
			31'h00010000 : out = 5'b10000;
			31'h00020000 : out = 5'b10001;
			31'h00040000 : out = 5'b10010;
			31'h00080000 : out = 5'b10011;
			31'h00100000 : out = 5'b10100;
			31'h00200000 : out = 5'b10101;
			31'h00400000 : out = 5'b10110;
			31'h00800000 : out = 5'b10111;
			default 		 : out = 5'b11111;
			
		endcase
	
	end

endmodule
