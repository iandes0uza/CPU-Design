module encoder_32_5(input wire [31:0] in, output reg [4:0] out);

	always @(*)
	begin
		case(in)
		
			//Based of Input, turn on respective bits
			//All HIGH == no select
			31'h00000001 : out = 5'b00000;	//r0
			31'h00000002 : out = 5'b00001;	//r1
			31'h00000004 : out = 5'b00010;	//r2
			31'h00000008 : out = 5'b00011;	//r3
			31'h00000010 : out = 5'b00100;	//r4
			31'h00000020 : out = 5'b00101;	//r5
			31'h00000040 : out = 5'b00110;	//r6
			31'h00000080 : out = 5'b00111;	//r7
			31'h00000100 : out = 5'b01000;	//r8
			31'h00000200 : out = 5'b01001;	//r9
			31'h00000400 : out = 5'b01010;	//r10
			31'h00000800 : out = 5'b01011;	//r11
			31'h00001000 : out = 5'b01100;	//r12
			31'h00002000 : out = 5'b01101;	//r13
			31'h00004000 : out = 5'b01110;	//r14
			31'h00008000 : out = 5'b01111;	//r15
			31'h00010000 : out = 5'b10000;	//high
			31'h00020000 : out = 5'b10001;	//low
			31'h00040000 : out = 5'b10010;	//zhigh
			31'h00080000 : out = 5'b10011;	//zlow
			31'h00100000 : out = 5'b10100;	//pc
			31'h00200000 : out = 5'b10101;	//mdr
			31'h00400000 : out = 5'b10110;	//port
			31'h00800000 : out = 5'b10111;	//sign
			default 		 : out = 5'b11111;	
			
		endcase
	
	end

endmodule
