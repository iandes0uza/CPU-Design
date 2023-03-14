module gen_regs(output reg [31:0] q, input [31:0] d, input en, clr, clk);

	initial q = 0;
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
			
		//This is for jumping instructions (later issue)
		else if (enable)
			pc_out <= pc_in;
	end
				
endmodule