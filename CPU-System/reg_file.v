module reg_file(input [11:0] ir_reg, input rIN, rOUT, baOUT, gra, grb, grc,
					 output r15_out, r14_out, r13_out, r12_out, r11_out, r10_out,
							  r9_out, r8_out, r7_out, r6_out, r5_out, r4_out, r3_out,
							  r2_out, r1_out, r0_out,
							  r15_in, r14_in, r13_in, r12_in, r11_in, r10_in, r9_in,
							  r8_in, r7_in, r6_in, r5_in, r4_in, r3_in, r2_in, r1_in,
							  r0_in);

	wire [3:0] ra_wire, rb_wire, rc_wire, decode_in;
	wire [15:0] select;
	wire rabOUT,
		 r15_select, r14_select, r13_select, r12_select, r11_select, r10_select,
		 r9_select, r8_select, r7_select, r6_select, r5_select, r4_select, r3_select,
		 r2_select, r1_select, r0_select;
	
	or(rabOUT, baOUT, rOUT);
	
	and(ra_wire, ir_reg[11:8], {gra, gra, gra, gra});
	and(rb_wire, ir_reg[7:4], {grb, grb, grb, grb});
	and(rc_wire, ir_reg[3:0], {grc, grc, grc, grc});
	assign decode_in = ra_wire | rb_wire | rc_wire;
	
	assign select = 15'b000000000000001 << decode_in;
	
	reg_bus r0(r0_out, r0_in, select[0], rIN, rabOUT);
	reg_bus r1(r1_out, r1_in, select[1], rIN, rabOUT);
	reg_bus r2(r2_out, r2_in, select[2], rIN, rabOUT);
	reg_bus r3(r3_out, r3_in, select[3], rIN, rabOUT);
	reg_bus r4(r4_out, r4_in, select[4], rIN, rabOUT);
	reg_bus r5(r5_out, r5_in, select[5], rIN, rabOUT);
	reg_bus r6(r6_out, r6_in, select[6], rIN, rabOUT);
	reg_bus r7(r7_out, r7_in, select[7], rIN, rabOUT);
	reg_bus r8(r8_out, r8_in, select[8], rIN, rabOUT);
	reg_bus r9(r9_out, r9_in, select[9], rIN, rabOUT);
	reg_bus r10(r10_out, r10_in, select[10], rIN, rabOUT);
	reg_bus r11(r11_out, r11_in, select[11], rIN, rabOUT);
	reg_bus r12(r12_out, r12_in, select[12], rIN, rabOUT);
	reg_bus r13(r13_out, r13_in, select[13], rIN, rabOUT);
	reg_bus r14(r14_out, r14_in, select[14], rIN, rabOUT);
	reg_bus r15(r15_out, r15_in, select[15], rIN, rabOUT);
	
endmodule


module reg_bus(output out, in, input reg_in, rIN, rabOUT);

	and(in, reg_in, rIN);
	and(out, reg_in, rabOUT);
	
endmodule