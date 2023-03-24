module conff(output con_out, input [3:0] c2_field, input [31:0] bus, input con_in);

	wire [3:0] decoder_line;
	wire zero, nonzero, pos, neg, not_bus31, neg_bus, not_neg_bus, con_input, q_bar;
	
	assign decoder_line = 4'b0001 << c2_field;
	
	assign neg_bus = ~|bus;
	
	and(zero, neg_bus, decoder_line[0]);
	not(not_neg_bus, neg_bus);
	and(nonzero, not_neg_bus, decoder_line[1]);	
	not(not_bus31, bus[31]);
	and(pos, not_bus31, decoder_line[2]);
	and(neg, bus[31], decoder_line[3]);
	
	assign con_input = zero | nonzero | pos | neg;
	
	flip_flop con_flop(con_out, q_bar, con_input, con_in);
	

endmodule

module flip_flop(output reg q, q_bar, input d, input clk);
	
	initial begin
		q <= 0;
		q_bar <= -1;
	end
	
	always@(clk) begin
		q <= d;
		q_bar <= !d;
	end

endmodule