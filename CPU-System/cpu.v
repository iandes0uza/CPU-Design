`timescale 1ns/10ps
module cpu(output [4:0] opcode,
					 output wire [31:0] outport_data, bus,
					 input wire [31:0] inport_data,
					 input clk, rst, stp);

	//General Purpose Connections - BUS CONNECTION
	wire [31:0] data_r0, data_r1, data_r2, data_r3, data_r4, data_r5, data_r6, data_r7, 
					data_r8, data_r9, data_r10, data_r11, data_r12, data_r13, data_r14, data_inport, 
					data_r15, data_pc, data_y, data_hi, data_lo, data_zlo, data_zhi, data_ir, data_sign, data_mdr, data_ram;
   
	//Required RAM Connections	
	wire [15:0] reg_in_IR, reg_out_IR, reg_enable_in;
	reg [15:0] reg_in, reg_out;
	
	always@(*)
	begin	
		if(reg_in_IR)
			reg_in <= reg_in_IR; 
		else 
			reg_in <= reg_enable_in;
		if(reg_out_IR)
			reg_out <= reg_out_IR; 
		else 
			reg_out <= 0;
	end 
	
	//Bus Selection Module
	wire [4:0] select;
	encoder_32_5 output_mux({{8'b0}, c_out, inport_out, mdr_out, pc_out, zlo_out, zhi_out, lo_out, hi_out, reg_out[15:0]}, select);							

	//MDR Connection
	wire [31:0] mdr_connection;
	mux_2_1 mdrMUX(mdr_connection, mdr_read, bus, data_ram);
	gen_regs mdr(data_mdr, mdr_connection, mdr_enable, clr, clk);
	
	//MAR Connection
	wire [8:0] data_mar;
	mar_reg mar(data_mar, bus, mar_enable, clr, clk);
	
	//RAM Subsystem Connection
	ram ram_connection(data_ram, data_mdr, data_mar, ram_enable, clk);
	
	//Select & Encode Logical Unit
	wire [3:0] decoder_in;
	select_encoder s_e(data_ir, r_in, r_out, ba_out, gra, grb, grc, data_sign, reg_in_IR, reg_out_IR, opcode, decoder_in);
	
	//Control FF Module
	wire con_out;
	conff control(con_out, data_ir[20:19], bus, con_enable);
	
	//ALU output
	wire [63:0] c;
				
	//(SPECIAL PURPOSE) Program Counter Register
	pc_reg pc(data_pc, bus, pc_increment, pc_enable, clk);
	gen_regs y(data_y, bus, y_enable, clr, clk);
	gen_regs #(1234)hi(data_hi, bus, hi_enable, clr, clk);
	gen_regs #(444)lo(data_lo, bus, lo_enable, clr, clk);
	gen_regs zlo(data_zlo, c[31:0], zlo_enable, clr, clk);
	gen_regs zhi(data_zhi, c[63:32], zhi_enable, clr, clk);
	gen_regs ir(data_ir, bus, ir_enable, clr, clk);
	
	//R0 Special Purpose
	wire [31:0] r0_connection;
	gen_regs r0(r0_connection, bus, reg_in[0], clr, clk);
	assign data_r0 = !ba_out & r0_connection;
	
	//Registers 1-15
	gen_regs r1(data_r1, bus, reg_in[1], clr, clk);
	gen_regs #(38)r2(data_r2, bus, reg_in[2], clr, clk);
	gen_regs #(1123)r3(data_r3, bus, reg_in[3], clr, clk);
	gen_regs #(103)r4(data_r4, bus, reg_in[4], clr, clk);
	gen_regs r5(data_r5, bus, reg_in[5], clr, clk);
	gen_regs #(-7)r6(data_r6, bus, reg_in[6], clr, clk);
	gen_regs r7(data_r7, bus, reg_in[7], clr, clk);
	gen_regs r8(data_r8, bus, reg_in[8], clr, clk);
	gen_regs r9(data_r9, bus, reg_in[9], clr, clk);
	gen_regs r10(data_r10, bus, reg_in[10], clr, clk);
	gen_regs r11(data_r11, bus, reg_in[11], clr, clk);
	gen_regs r12(data_r12, bus, reg_in[12], clr, clk);
	gen_regs r13(data_r13, bus, reg_in[13], clr, clk);
	gen_regs r14(data_r14, bus, reg_in[14], clr, clk);
	gen_regs r15(data_r15, bus, reg_in[15], clr, clk);
	
	//Port Registers
	gen_regs #(3286)inport(data_inport, inport_data, inport_enable, clr, clk);
	gen_regs outport(outport_data, bus, outport_enable, clr, clk);

	//CPU Control Unit Module
	control_unit controlUnit(gra, grb, grc, r_in, r_out, y_enable, pc_enable, mar_enable, mdr_enable, mdr_out,
									 ir_enable, mdr_read, hi_enable, lo_enable, zhi_enable, zlo_enable, pc_increment, con_enable,
									 ram_enable, inport_enable, outport_enable, inport_out, pc_out, y_out, zlo_out, zhi_out,
									 lo_out, hi_out, ba_out, c_out, run, reg_enable_in, data_ir, clk, rst, stp);
	//ALU Module
	alu alu_module(data_y, bus, opcode, c[63:0], con_out, clk);
	
	//Bus Multiplexer
	bus_mux BusMux(bus, select,
						data_r0, data_r1, data_r2, data_r3, data_r4, data_r5, data_r6, data_r7, 
						data_r8, data_r9, data_r10, data_r11, data_r12, data_r13, data_r14, data_r15,
						data_hi, data_lo, data_zhi, data_zlo, data_pc, data_mdr, data_inport, data_sign);


endmodule

