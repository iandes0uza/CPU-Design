module select_encoder(input [31:0] ir, input rIN, rOUT, baOUT, gra, grb, grc,
					 output [31:0] data_sign, output [15:0] reg_in, reg_out, 
					 output [4:0] op, output reg [3:0] decode);

					 
	wire [15:0] decoder_logic;
	
	always@(*) begin
		if(gra)
			decode <= ir[26:23];
		if(grb)
			decode <= ir[22:19];
		if(grc) 
			decode <= ir[18:15];
	end
	
	encoder_4_16 s_enc(decoder_logic, decode);
	
	assign op = ir[31:27];
	assign data_sign = {{14{ir[17]}}, ir[17:0]};
	
	assign reg_in = {16{rIN}} & decoder_logic;
	assign reg_out = ({16{rOUT}} | {16{baOUT}})& decoder_logic;
		
endmodule

module encoder_4_16(output reg [15:0] out, input [3:0] in);
	
	always@(*) begin
		out = 15'b1 << in;
	end
	
endmodule