module select_encoder(input [11:0] ir_reg, input rIN, rOUT, baOUT, gra, grb, grc
					 output [31:0] data_sign, output [15:0] reg_in, reg_out, 
					 output [4:0] op, output [3:0] decode);

					 
	wire [15:0] decoder_logic;
	
	

	
endmodule

module selectencodelogic(input [31:0] instruction,
			   input Gra, Grb,Grc,Rin,Rout,BAout,
			   output [31:0] C_sign_extended,
			   output [15:0] RegInSel, 
			   output [15:0] RegOutSel, 
				output [4:0] opcode, 
			   output wire [3:0] decoderInput);
	wire [15:0] decoderOutput;
	
	assign decoderInput = (instruction[26:23]&{4{Gra}}) | (instruction[22:19]&{4{Grb}}) | (instruction[18:15]&{4{Grc}});
	encoder_4_to_16 encoder(decoderInput, decoderOutput);
	
	assign opcode = instruction[31:27];
	assign C_sign_extended = {{14{instruction[17]}},instruction[17:0]};
	assign RegInSel = {16{Rin}} & decoderOutput;
	assign RegOutSel = ({16{Rout}} | {16{BAout}}) & decoderOutput;
endmodule