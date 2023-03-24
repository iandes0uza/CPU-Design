module ram(output [31:0] ram_out, input [31:0] ram_in, input [8:0] addr, input en, clk);

	reg [31:0] ram_contents[0:511];
	reg [31:0] addr_reg;
	
	initial $readmemh("test.mif", ram_contents);

	
	always@(posedge clk)
	begin
		if(en)
			ram_contents[addr] <= ram_in;
		else 
			addr_reg <= addr;
	end
	
	assign ram_out = ram_contents[addr_reg];
	

endmodule