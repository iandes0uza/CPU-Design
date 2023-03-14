module bus_mux(output reg [31:0] out,
					input wire [4:0] in,
					input wire [31:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9,
											r10, r11, r12, r13, r14, r15, 
											high, low,
											zhigh, zlow, pc, mdr, port, sign
											);

	always@(*)
	begin
		case(in)
			5'b00000 : out = r0;
			5'b00001 : out = r1;
			5'b00010 : out = r2;
			5'b00011 : out = r3;
			5'b00100 : out = r4;
			5'b00101 : out = r5;
			5'b00110 : out = r6;
			5'b00111 : out = r7;
			5'b01000 : out = r8;
			5'b01001 : out = r9;
			5'b01010 : out = r10;
			5'b01011 : out = r11;
			5'b01100 : out = r12;
			5'b01101 : out = r13;
			5'b01110 : out = r14;
			5'b01111 : out = r15;
			5'b10000 : out = high;
			5'b10001 : out = low;
			5'b10010 : out = zhigh;
			5'b10011 : out = zlow;
			5'b10100 : out = pc;
			5'b10101 : out = mdr;
			5'b10110 : out = port;
			5'b10111 : out = sign;
			default  : out = 0;
			
		endcase
	end					  
endmodule