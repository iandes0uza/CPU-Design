`timescale 1ns/10ps
module datapath(input pc_out, zlo_out, zhi_out, mdr_out, mdr_enable, mar_enable, zlo_enable, zhi_enable, 
							 hi_enable, lo_enable, hi_out, lo_out, c_out, ram_enable, pc_enable, ir_enable, pc_increment, 
							 y_enable, mdr_read, gra, grb, grc, ba_out, r_in, r_out, outport_enable, inport_enable,
					 input [15:0] reg_enable_in, reg_enable_out,
					 output [4:0] opcode,
					 input [31:0] data_in, inport_data, outport_data, 
					 output [31:0] bus,
					 input clr, clk);

	//General Purpose Connections - BUS CONNECTION
	wire [31:0] data_r0, data_r1, data_r2, data_r3, data_r4, data_r5, data_r6, data_r7, 
					data_r8, data_r9, data_r10, data_r11, data_r12, data_r13, data_r14, 
					data_r15, data_pc, data_y, data_hi, data_lo, data_zlo, data_zhi, data_ir,
					data_inport, data_sign, data_mdr, data_ram;
   
	//Required RAM Connections	
	wire [15:0] reg_in_IR, reg_out_IR;
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
			reg_out <= reg_enable_out;
	end 
	
	//Bus Selection Module
	wire [4:0] select;
	encoder_32_5 output_mux({{8'b0}, c_out, inport_out, mdr_out, pc_out, zlo_out, zhi_out, lo_out, hi_out, reg_out[15:0]}, select);							

	//MDR Connection
	wire [31:0] mdr_connection;
	mux_2_1 mdrMUX(mdr_connection, mdr_read, bus, data_in);
	gen_regs mdr(data_mdr, mdr_connection, mdr_enable, clr, clk);
	
	//MAR Connection
	wire [8:0] data_mar;
	mar_reg mar(data_mar, bus, mar_enable, clr, clk);
	
	//Physical RAM
	ram physical_ram(data_ram, data_mdr, data_mar, ram_enable, clk);
	
	//Select & Encode Logical Unit
	wire [3:0] decoder_in;
	select_encoder s_e(data_ir, r_in, r_out, ba_out, gra, grb, grc, data_sign, reg_in_IR, reg_out_IR, opcode, decoder_in);
	
	//Control FF Module
	wire con_out;
	conff control(con_out, data_ir[22:19], bus, con_enable);
	
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
	
	//R0 Special Purpose
	wire [31:0] r0_connection;
	gen_regs r0(r0_connection, bus, reg_in[0], clr, clk);
	assign data_r0 = -ba_out & r0_connection;
	
	//Registers 1-15
	gen_regs r1(data_r1, bus, reg_in[1], clr, clk);
	gen_regs r2(data_r2, bus, reg_in[2], clr, clk);
	gen_regs r3(data_r3, bus, reg_in[3], clr, clk);
	gen_regs r4(data_r4, bus, reg_in[4], clr, clk);
	gen_regs r5(data_r5, bus, reg_in[5], clr, clk);
	gen_regs r6(data_r6, bus, reg_in[6], clr, clk);
	gen_regs r7(data_r7, bus, reg_in[7], clr, clk);
	gen_regs r8(data_r8, bus, reg_in[8], clr, clk);
	gen_regs r9(data_r9, bus, reg_in[9], clr, clk);
	gen_regs r10(data_r10, bus, reg_in[10], clr, clk);
	gen_regs r11(data_r11, bus, reg_in[11], clr, clk);
	gen_regs r12(data_r12, bus, reg_in[12], clr, clk);
	gen_regs r13(data_r13, bus, reg_in[13], clr, clk);
	gen_regs r14(data_r14, bus, reg_in[14], clr, clk);
	gen_regs r15(data_r15, bus, reg_in[15], clr, clk);

	//ALU Module
	alu alu_module(data_y, bus, opcode, c[63:0], con_out, clk);
	
	//Bus Multiplexer
	bus_mux BusMux(bus, select,
						data_r0, data_r1, data_r2, data_r3, data_r4, data_r5, data_r6, data_r7, 
						data_r8, data_r9, data_r10, data_r11, data_r12, data_r13, data_r14, data_r15,
						data_hi, data_lo, data_zhi, data_zlo, data_pc, data_mdr, data_inport, data_sign);


endmodule
/*
`timescale 1ns/10ps

module CPUDesignProject(
	input PCout, 
	input ZLowout, 
	input ZHighout,
	input MDRout, MDRin, MARin,
	input ZLowIn,ZHighIn, HIin, HIout, LOin, LOout, Cout, ramWE,PCin, IRin, IncPC, Yin, Read,
	input Gra, Grb, Grc, R_in, R_out, BAout, CONin,InPortout,
	input [15:0] R_enableIn, Rout_in,
	input OutPortIn, InPortIn,
   output [4:0] operation,
	input clk,clr,
	input [31:0] MDatain, 
	input wire [31:0] inport_data_in,
	output wire [31:0] outport_data_out,
	output [31:0] bus_contents
);

	wire [15:0] enableR_IR; 
	wire [15:0] Rout_IR;
	reg  [15:0]  regIn; 
	reg  [15:0]  Rout;
	wire [3:0]  decoder_in;
	 
	always@(*)begin		
		if (enableR_IR)regIn<=enableR_IR; 
		else regIn<=R_enableIn;
		if (Rout_IR)Rout<=Rout_IR; 
		else Rout<=Rout_in;
	end 

	//wire [31:0] bus_contents;

    //These are the inputs to the bus multiplexer
	wire [31:0] R0_data_out, R1_data_out,R2_data_out,R3_data_out, R4_data_out, R5_data_out, R6_data_out, R7_data_out, R8_data_out, R9_data_out;
	wire [31:0] R10_data_out, R11_data_out, R12_data_out, R13_data_out, R14_data_out, R15_data_out, HI_data_out, LO_data_out;
	wire [31:0] ZHigh_data_out, ZLow_data_out, IR_data_out;
	wire [31:0] PC_data_out, MDR_data_out, RAM_data_out, MAR_data_out_32, C_Sign_extend, Y_data_out ,pcData;
	wire [63:0] C_data_out;
	wire [8:0] MAR_data_out;

	// Encoder input and output wires]
	wire [31:0]	encoder_in;
	wire [4:0] encoder_out;
	
	// Connecting the register output signals to the encoder's input wire
	assign encoder_in = {{8{1'b0}},Cout,InPortout,MDRout,PCout,ZLowout,ZHighout,LOout,HIout,Rout};

    // Instatiating 32-to-5 encoder
    encoder_32_to_5 encoder(encoder_in, encoder_out);

    //Creating all 32-bit registers
	wire [31:0] r0_AND_input;
	assign R0_data_out = {32{!BAout}} & r0_AND_input; //revision to R0
	reg_32_bit R0(clk, clr, regIn[0] , bus_contents, r0_AND_input); 
	reg_32_bit #(32'h22) R1(clk, clr, regIn[1], bus_contents, R1_data_out);
	reg_32_bit #(55) R2(clk, clr, regIn[2], bus_contents, R2_data_out);
	reg_32_bit #(32'b110000) R3(clk, clr, regIn[3], bus_contents, R3_data_out);
	reg_32_bit #(32'h67) R4(clk, clr, regIn[4], bus_contents, R4_data_out);
	reg_32_bit R5(clk, clr, regIn[5], bus_contents, R5_data_out);
	reg_32_bit #(0) R6(clk, clr, regIn[6], bus_contents, R6_data_out);
	reg_32_bit R7(clk, clr, regIn[7], bus_contents, R7_data_out);
	reg_32_bit R8(clk, clr, regIn[8], bus_contents, R8_data_out);
	reg_32_bit R9(clk, clr, regIn[9], bus_contents, R9_data_out);
	reg_32_bit R10(clk, clr, regIn[10], bus_contents, R10_data_out);
	reg_32_bit R11(clk, clr, regIn[11], bus_contents, R11_data_out);
	reg_32_bit R12(clk, clr, regIn[12], bus_contents, R12_data_out);
	reg_32_bit R13(clk, clr, regIn[13], bus_contents, R13_data_out);
	reg_32_bit R14(clk, clr, regIn[14], bus_contents, R14_data_out);
	reg_32_bit R15(clk, clr, regIn[15], bus_contents, R15_data_out);
	reg_32_bit Y(clk, clr, Yin, bus_contents, Y_data_out);
	reg_32_bit #(53292) HI_reg(clk, clr, HIin, bus_contents, HI_data_out);
	reg_32_bit #(55555555) LO_reg(clk, clr, LOin, bus_contents, LO_data_out);
	reg_32_bit ZHigh_reg(clk, clr, ZHighIn, C_data_out[63:32], ZHigh_data_out);	
	reg_32_bit ZLow_reg(clk, clr, ZLowIn, C_data_out[31:0], ZLow_data_out);

	reg_32_bit IR(clk, rst, IRin, bus_contents, IR_data_out);

	//reg_32_bit PC_reg(clk, clr,PCin, bus_contents, PC_data_out);
   IncPC_32_bit #(17) PC_reg(clk, IncPC, PCin, bus_contents, PC_data_out);
	
	reg_32_bit OutPort(clk, clr, OutPortIn, bus_contents, outport_data_out);
	reg_32_bit #(-42010) InPort(clk, clr, InPortIn, Inport_data_out, BusMuxIn_In_Port);

	//Select and encode Logic and CON FF
	selectencodelogic selEn(IR_data_out, Gra, Grb, Grc, R_in, R_out, BAout, C_Sign_extend, enableR_IR, Rout_IR, operation,decoder_in);
	CONFF_logic conff(IR_data_out[20:19],bus_contents, CONin, CONout);
	
	//MDR
	wire [31:0] MDR_mux_out;
	//First create the 2-1 mux that selects either the RAM or the bus contents
	mux_2_to_1 MDMux(bus_contents,RAM_data_out, Read,MDR_mux_out);
	//Create the actual MDR itself by instantiating a regular 32 bit reg
	reg_32_bit MDR(clk,rst,MDRin,MDR_mux_out,MDR_data_out);

	//This is done to avoid having to make an MDR unit module
	reg_32_bit MAR(clk,rst,MARin, bus_contents, MAR_data_out_32);
	assign MAR_data_out = MAR_data_out_32[8:0];

	//memRAM ramModule(MAR_data_out,clk,MDR_data_out,ramWE,RAM_data_out);
	
	ram ramModule(MDR_data_out,MAR_data_out,clk,ramWE,RAM_data_out);

	// Multiplexer to select which data to send out on the bus
	mux_32_to_1 BusMux(
		.BusMuxIn_R0(R0_data_out),.BusMuxIn_R1(R1_data_out), .BusMuxIn_R2(R2_data_out),.BusMuxIn_R3(R3_data_out),
		.BusMuxIn_R4(R4_data_out),.BusMuxIn_R5(R5_data_out), .BusMuxIn_R6(R6_data_out),.BusMuxIn_R7(R7_data_out),
		.BusMuxIn_R8(R8_data_out),.BusMuxIn_R9(R9_data_out),.BusMuxIn_R10(R10_data_out),.BusMuxIn_R11(R11_data_out),
		.BusMuxIn_R12(R12_data_out),.BusMuxIn_R13(R13_data_out),.BusMuxIn_R14(R14_data_out),.BusMuxIn_R15(R15_data_out),
		.BusMuxIn_HI(HI_data_out),.BusMuxIn_LO(LO_data_out),.BusMuxIn_Z_HI(ZHigh_data_out),.BusMuxIn_Z_LO(ZLow_data_out),
		.BusMuxIn_PC(PC_data_out),.BusMuxIn_MDR(MDR_data_out),.BusMuxIn_In_Port(Inport_data_out),.C_Sign_Extended(C_Sign_extend),
		.BusMuxOut(bus_contents),.select(encoder_out)
		);

	//instantiate the alu
	alu the_alu(
	.clk(clk),
	.clr(clr), 
	.branch_flag(CONout),
	.A(Y_data_out),
	.B(bus_contents),
	//.RPC(PC_data_out),
	.opcode(operation),
	.C(C_data_out)
	//.IncPC(IncPC),
	//.aluPCout(pcData)
	);

endmodule
*/