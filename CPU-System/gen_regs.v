`timescale 1ns/10ps
module gen_regs #(parameter qInitial = 0)(output reg [31:0] q, input [31:0] d, input en, clr, clk);

	initial q = qInitial;
	always @(posedge clk)
	begin
		if(clr)
			q = 0;
		else if (en)
			q = d;
	end
	
endmodule

module pc_reg(output reg [31:0] pc_out, input [31:0] pc_in, input pc_inc, enable, clk);
	
	initial pc_out = 0;
	always @(posedge clk)
	begin
		if(enable && pc_inc)
			pc_out <= pc_out + 1;
		else if (enable)
			pc_out <= pc_in;
	end
				
endmodule

module mar_reg(output [8:0] q, input wire [31:0] d, input wire en, clr, clk);
	
	wire [31:0] mar_data;
	gen_regs mar_internal(mar_data, d, en, clr, clk);
	assign q = mar_data[8:0];
	
endmodule