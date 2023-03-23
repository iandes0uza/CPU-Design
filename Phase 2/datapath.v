`timescale 1ns/10ps
module datapath(input pc_out, zlo_out, zhi_out, mdr_out, mar_in, zlo_enable, zhi_enable, pc_enable, mdr_enable, mdr_read, ir_enable, y_enable, pc_increment, 
					 lo_enable, hi_enable,
					 input [4:0] op_code,
					 input [31:0] data_in,
					 input clr, clk);
					 
	
	//General Purpose Connections - ENABLE
	wire r0_enable, 
	     r1_enable,
		  r2_enable,
		  r3_enable,
		  r4_enable,
		  r5_enable,
		  r6_enable,
		  r7_enable,
		  r8_enable,
		  r9_enable,
		  r10_enable,
		  r11_enable,
		  r12_enable,
		  r13_enable,
		  r14_enable,
		  r15_enable,
		  con_enable,
		  mar_enable
		  //y_enable,
		  //hi_enable,
		  //lo_enable,
		  //zlo_enable,
		  //zhi_enable
		  //pc_enable,
		  //mdr_enable,
		  //ir_enable
		  ;
	
	//General Purpose Connections - BUS CONNECTION
	wire [31:0] data_r0, 
					data_r1, 
					data_r2, 
					data_r3, 
					data_r4, 
					data_r5, 
					data_r6, 
					data_r7, 
					data_r8,
					data_r9, 
					data_r10, 
					data_r11, 
					data_r12, 
					data_r13, 
					data_r14, 
					data_r15,
					data_pc,
					data_y,
					data_hi,
					data_lo,
					data_zlo,
					data_zhi,
					data_ir,
					data_inport,
					data_sign,
					data_mdr;
					
	//General Purpose Connections - OUT FLAG
	wire r0_out = 0,
	     r1_out = 0,
	     r2_out = 0,
	     r3_out = 0,
	     r4_out = 0,
	     r5_out = 0,
	     r6_out = 0,
	     r7_out = 0,
	     r8_out = 0,
	     r9_out = 0,
	     r10_out = 0,
	     r11_out = 0,
	     r12_out = 0,
	     r13_out = 0,
	     r14_out = 0,
	     r15_out = 0,
		  //pc_out = 0,
	     hi_out = 0,
	     lo_out = 0,
		  //zhi_out = 0,
		  //mdr_out = 0,
		  //zlo_out = 0,
	     inport_out = 0,
	     c_out = 0,
	     con_out = 0;
		  
	
		  
	//Bus Selection Module
	wire [4:0] select;
	encoder_32_5 output_mux({{8'b0}, c_out, inport_out, mdr_out, pc_out, zlo_out, zhi_out, lo_out, hi_out,
													r15_out, r14_out, r13_out, r12_out, r11_out, r10_out, r9_out, r8_out,
													r7_out, r6_out, r5_out, r4_out, r3_out, r2_out, r1_out, r0_out}, select);
												
	//Select & Encode Logical Unit
	wire r_in, r_out, ba_out, gra, grb, grc;
	reg_file sel_enc(data_ir[27:14], r_in, r_out, ba_out, gra, grb, grc,
						  r15_out, r14_out, r13_out, r12_out, r11_out, r10_out,
									r9_out, r8_out, r7_out, r6_out, r5_out, r4_out, r3_out,
									r2_out, r1_out, r0_out,
									r15_enable, r14_enable, r13_enable, r12_enable, r11_enable, r10_enable, 
									r9_enable, r8_enable, r7_enable, r6_enable, r5_enable, r4_enable, r3_enable, 
									r2_enable, r1_enable, r0_enable);
	
	//BUS Wire
	wire [31:0] bus;
	
	//ALU output
	wire [63:0] c;
				
	//(SPECIAL PURPOSE) Program Counter Register
	pc_reg pc(data_pc, bus, pc_enable, pc_increment, clk);
	gen_regs y(data_y, bus, y_enable, clr, clk);
	gen_regs hi(data_hi, bus, hi_enable, clr, clk);
	gen_regs lo(data_lo, bus, lo_enable, clr, clk);
	gen_regs zlo(data_zlo, c[31:0], zlo_enable, clr, clk);
	gen_regs zhi(data_zhi, c[63:32], zhi_enable, clr, clk);
	gen_regs ir(data_ir, bus, ir_enable, clr, clk);

	//MDR Connection
	wire [31:0] mdr_connection;
	mux_2_1 mdrMUX(mdr_connection, mdr_read, bus, data_in);
	gen_regs mdr(data_mdr, mdr_connection, mdr_enable, clr, clk);
	
	//MAR Connection
	wire [8:0] data_mar;
	mar_reg mar(data_mar, bus, mar_enable, clr, clk);
	
	//R0 Special Purpose
	wire [31:0] r0_connection;
	gen_regs r0(r0_connection, bus, r0_enable, clr, clk);
	assign data_r0 = -ba_out & r0_connection;
	
	//Registers 1-15
	gen_regs r1(data_r1, bus, r1_enable, clr, clk);
	gen_regs r2(data_r2, bus, r2_enable, clr, clk);
	gen_regs r3(data_r3, bus, r3_enable, clr, clk);
	gen_regs r4(data_r4, bus, r4_enable, clr, clk);
	gen_regs r5(data_r5, bus, r5_enable, clr, clk);
	gen_regs r6(data_r6, bus, r6_enable, clr, clk);
	gen_regs r7(data_r7, bus, r7_enable, clr, clk);
	gen_regs r8(data_r8, bus, r8_enable, clr, clk);
	gen_regs r9(data_r9, bus, r9_enable, clr, clk);
	gen_regs r10(data_r10, bus, r10_enable, clr, clk);
	gen_regs r11(data_r11, bus, r11_enable, clr, clk);
	gen_regs r12(data_r12, bus, r12_enable, clr, clk);
	gen_regs r13(data_r13, bus, r13_enable, clr, clk);
	gen_regs r14(data_r14, bus, r14_enable, clr, clk);
	gen_regs r15(data_r15, bus, r15_enable, clr, clk);

	//ALU Module
	alu alu_module(data_y, bus, op_code, c[63:0], clk);
	
	//Control FF Module
	conff control(con_data, data_ir[22:19], bus, con_enable);
	
	//Bus Multiplexer
	bus_mux BusMux(bus, select,
						data_r0, data_r1, data_r2, data_r3, data_r4, data_r5, data_r6, data_r7, 
						data_r8, data_r9, data_r10, data_r11, data_r12, data_r13, data_r14, data_r15,
						data_hi, data_lo, data_zhi, data_zlo, data_pc, data_mdr, data_inport, data_sign);


endmodule