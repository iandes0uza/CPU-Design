module select_encoder(input [31:0] ir, input rIN, rOUT, baOUT, gra, grb, grc,
					 output [31:0] data_sign, output [15:0] reg_in, reg_out, 
					 output [4:0] op, output reg [3:0] decode);

					 
	wire [15:0] decoder_logic;
	
	initial begin
		if(gra)
			decode <= ir[26:23];
		if(grb)
			decode <= ir[22:19];
		if(grc) 
			decode <= ir[18:15];
		else
			decode <= 4'b0;
	end
	
	assign decoder_logic = 15'b0000000000000001 << decode;
	
	assign op = ir[31:27];
	assign data_sign = {{14{ir[17]}}, ir[17:0]};
	
	assign reg_in = rIN ? decoder_logic : 15'b0;
	assign reg_out = (rOUT | baOUT) ? decoder_logic : 15'b0;
		
endmodule