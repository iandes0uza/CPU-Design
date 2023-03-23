module conff(output con_out, input [3:0] c2_field, input [31:0] bus, input con_in);

	wire [3:0] decoder_line;
	wire zero, nonzero, pos, neg, not_bus31, neg_bus, not_neg_bus;
	
	assign decoder_line = 4'b0001 << c2_field;
	
	assign neg_bus = ~|bus;
	
	and(zero, neg_bus, decoder_line[0]);
	not(not_neg_bus, neg_bus);
	and(nonzero, not_neg_bus, decoder_line[1]);	
	not(not_bus31, bus[31]);
	and(pos, not_bus31, decoder_line[2]);
	and(neg, bus[31], decoder_line[3]);

endmodule