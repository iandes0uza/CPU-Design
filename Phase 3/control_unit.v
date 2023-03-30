`timescale 1ns/10ps
module control_unit(output reg gra, grb, grc, r_in, r_out, y_enable, pc_enable,
							   mar_enable, mdr_enable, mdr_out, ir_enable, mdr_read,
							   hi_enable, lo_enable, zhi_enable, zlo_enable, inc_pc, con_enable,
							   ram_enable, inport_enable, outport_enable, inport_out, pc_out, y_out,
							   zlo_out, zhi_out, lo_out, hi_out, ba_out, c_out, run,
					output reg [15:0] reg_enable,
					input [31:0] ir,
					input clk, rst, stp);
					
	parameter r_s = 8'd255,
			  T0 = 8'd0, T1 = 8'd1, T2 = 8'd2, T3 = 8'd3,
			  load_T0 = 8'd4, load_T1 = 8'd5, load_T2 = 8'd6,  load_T3 = 8'd6,  load_T4 = 8'd6,
			  loadi_T0 = 8'd7, loadi_T1 = 8'd8, loadi_T2 = 8'd9, 
			  store_T0 = 8'd10, store_T1 = 8'd11, store_T2 = 8'd12, store_T3 = 8'd13, 
			  alu2_T0 = 8'd14, alu2_T1 = 8'd15, alu3_T0 = 8'd16, alu3_T1 = 8'd17, alu3_T2 = 8'd18,
			  imm_T0 = 8'd19, imm_T1 = 8'd20, imm_T2 = 8'd21,
			  md_T0 = 8'd22, md_T1 = 8'd23, md_T2 = 8'd24, md_T3 = 8'd25, md_T4 = 8'd26,
			  branch_T0 = 8'd27, branch_T1 = 8'd28, branch_T2 = 8'd29, branch_T3 = 8'd30,
			  jump_T0 = 8'd31, jal_T0 = 8'd32, jal_T1 = 8'd33, in_T0 = 8'd34, out_T0 = 8'd35,
			  mfhi_T0 = 8'd36, mflo_T0 = 8'd37;
			  
			  

	reg [7:0] state = T0;
	always@(posedge clk, posedge rst)
	begin
		alu_control = ir[31:27];
		if (rst)
			state = r_s;
		else 
		begin
			case(state)
				r_s 	: #40 state = T0;
				T0 		: #40 state = T1;
				T1 		: #40 state = T2;
				T2		: begin
							case(alu_control)
							
								//Simulating ALU Control Sequence
								5'b00000 : #40 state = load_T0; 	//LOAD
								5'b00001 : #40 state = loadi_T0; 	//LOAD IMMEDIATE
								5'b00010 : #40 state = store_T0; 	//STORE
								5'b00011 : #40 state = alu3_T0;		//ADD
								5'b00100 : #40 state = alu3_T0;		//SUB
								5'b00101 : #40 state = alu3_T0;		//AND
								5'b00110 : #40 state = alu3_T0;		//OR
								5'b00111 : #40 state = alu3_T0;		//SHIFT RIGHT
								5'b01000 : #40 state = alu3_T0;		//SHIFT RIGHT ARITHMETIC
								5'b01001 : #40 state = alu3_T0;		//SHIFT LEFT
								5'b01010 : #40 state = alu3_T0;		//ROTATE RIGHT
								5'b01011 : #40 state = alu3_T0;		//ROTATE LEFT
								5'b01100 : #40 state = imm_T0;		//ADD IMMEDIATE
								5'b01101 : #40 state = imm_T0;		//AND IMMEDIATE
								5'b01110 : #40 state = imm_T0;		//OR IMMEDIATE
								5'b01111 : #40 state = md_T0;		//MULTIPLY
								5'b10000 : #40 state = md_T0;		//DIVIDE
								5'b10001 : #40 state = alu2_T0;		//NEGATE
								5'b10010 : #40 state = alu2_T0;		//NOT
								5'b10011 : #40 state = branch_T0;	//BRANCH
								5'b10100 : #40 state = jump_T0;		//JUMP
								5'b10101 : #40 state = jal_T0;		//JUMP AND LINK
								5'b10110 : #40 state = in_T0;		//INPORT
								5'b10111 : #40 state = out_T0;		//OUTPORT
								5'b11000 : #40 state = mfhi_T0;		//MOVE HIGH
								5'b11001 : #40 state = mflo_T0;		//MOVE LOW
								5'b11010 : #40 state = nop_T0;		//NO OPERATION
								5'b11011 : #40 state = halt_T0;		//HALT
							endcase
						end
		
				//Creating Testbench Control Simulations
				load_T0		: #40 state = load_T1;
				load_T1		: #40 state = load_T2;
				load_T2		: #40 state = load_T3;
				load_T3		: #40 state = load_T4;
				load_T4		: #40 state = T0;
				
				loadi_T0	: #40 state = loadi_T1;
				loadi_T1	: #40 state = loadi_T2;
				loadi_T2	: #40 state = T0;
				
				store_T0	: #40 state = store_T1;
				store_T1	: #40 state = store_T2;
				store_T2	: #40 state = store_T3;
				store_T3	: #40 state = T0;
				
				alu2_T0		: #40 state = alu2_T1;	//Same instruction set for all 2 register operations
				alu2_T1		: #40 state = T0;
				
				alu3_T0		: #40 state = alu3_T1;	//Same instruction set for all 3 register operations
				alu3_T1		: #40 state = alu3_T2;
				alu3_T2		: #40 state = T0;
				
				imm_T0		: #40 state = imm_T1;	//Same instruction set for all immediate operations
				imm_T1		: #40 state = imm_T2;
				imm_T2		: #40 state = T0;
				
				md_T0		: #40 state = md_T1;
				md_T1		: #40 state = md_T2;
				md_T3		: #40 state = md_T4;
				md_T4		: #40 state = T0;
				
				branch_T0 	: #40 state = branch_T1;
				branch_T1	: #40 state = branch_T2;
				branch_T2	: #40 state = branch_T3;
				branch_T3	: #40 state = T0;
				
				jump_T0		: #40 state = T0;
				
				jal_T0		: #40 state = jal_T1;
				jal_T1		: #40 state = T0;
				
				in_T0		: #40 state = T0;
				
				out_T0		: #40 state = T0;
				
				mfhi_T0		: #40 state = T0;
				
				mflo_T0		: #40 state = T0;
				
			endcase
		end
	end

	always@(state)
	begin
		case(state)
			
			//Creating Common Testbench Control Signals
			r_s			: begin
							run <= 1; reg_enable <= 0;
							pc_out <= 0; zlo_out <= 0; mdr_out <= 0; mar_enable <= 0; zhi_enable <= 0;
							zlo_enable <= 0; con_enable <= 0; inport_enable <= 0; outport_enable <= 0;
							pc_enable <= 0; mdr_enable <= 0; ir_enable <= 0; y_enable <= 0; inc_pc <= 0;
							ram_enable <= 0; gra <= 0; grb <= 0; grc <= 0; ba_out <= 0; c_out <= 0;
							inport_out <= 0; zhi_out <= 0; lo_out <= 0; hi_out <= 0; hi_enable <= 0;
							lo_enable <= 0; r_out <= 0; r_in <= 0; mdr_read <= 0;
						end
					
			T0			: begin
							pc_out <= 1; mar_enable <= 1; inc_pc <= 1; zlo_enable <= 1;
						end
					
			T1			: begin
							pc_out <= 0; mar_enable <= 0; inc_pc <= 0; zlo_enable <= 0;
							zlo_out <= 1; pc_enable <= 1; mdr_read <= 1; mdr_enable <= 1;
						end	
					
			T2			: begin
							zlo_out <= 0; pc_enable <= 0; mdr_read <= 0; mdr_enable <= 0;
							mdr_out <= 1; ir_enable <= 1;
						end	
			
			//Creating Specific Testbench Control Signals
			load_T0,
			loadi_T0,
			store_T0	: begin
							mdr_out <= 0; ir_enable <= 0;
							grb <= 1; ba_out <= 1; y_enable <= 1;
						end	
			load_T1,
			loadi_T1	: begin
							grb <= 0; ba_out <= 0; y_enable <= 0;
							c_out <= 1; zlo_enable <= 1;
						end	
			load_T2		: begin
							c_out <= 0; zlo_enable <= 0;
							zlo_out <= 1; mar_enable <= 1;
						end	
			load_T3		: begin
							zlo_out <= 0; mar_enable <= 0;
							mdr_read <= 1; mdr_enable <= 1;
							#10 mdr_read <= 0; mdr_enable <= 0;
						end	
			load_T4		: begin
							mdr_read <= 0; mdr_enable <= 0;
							mdr_out <= 1; gra <= 1; r_in <= 1;
							#40 mdr_out <= 0; gra <= 0; r_in <= 0;
						end	
			loadi_T2	: begin
							c_out <= 0; zlo_enable <= 0;
							zlo_out <= 1; gra <= 1; r_in = 1;
							#40 zlo_out <= 0; gra <= 0; r_in = 0;
						end
			store_T1	: begin
							grb <= 0; ba_out <= 0; y_enable <= 0;
							c_out <= 1; zhi_enable <= 1; zlo_enable <= 1;
						end
			store_T2	: begin
							c_out <= 0; zhi_enable <= 0; zlo_enable <= 0;
							zlo_out <= 1; mar_enable <= 1;
						end
			store_T3	: begin
							zlo_out <= 0; mar_enable <= 0;
							gra <= 1; r_out <= 1; mdr_enable <= 1;
							#40 gra <= 0; r_out <= 0; mdr_enable <= 0;
							mdr_out <= 1; ram_enable <= 1;
						end
			alu2_T0		: begin
							mdr_out <= 0; ir_enable <= 0;
							grb <= 1; r_out <= 1; zlo_enable <= 1;
						end
			alu2_T1		: begin
							grb <= 0; r_out <= 0; zlo_enable <= 0;
							zlo_out <= 1; gra <= 1; r_in <= 1;
						end
			alu3_T0		: begin
							mdr_out <= 0; ir_enable <= 0;
							grb <= 1; r_out <= 1; y_enable <= 1;
						end
			alu3_T1		: begin
							grb <= 0; r_out <= 0; y_enable <= 0;
							grc <= 1; r_out <= 1; zlo_enable <= 1; zhi_enable <= 1; 
						end
			alu3_T2		: begin
							grc <= 0; r_out <= 0; zlo_enable <= 0; zhi_enable <= 0;
							zlo_out <= 1; gra <= 1; r_in <= 1;
						end
			imm_T0		: begin
							mdr_out <= 0; ir_enable <= 0;
							grb <= 1; r_out <= 1; y_enable <= 1;
						end
			imm_T1		: begin
							grb <= 0; r_out <= 0; y_enable <= 0;
							c_out <= 1; zlo_enable <= 1; zhi_enable <= 1;
						end
			imm_T2		: begin
							c_out <= 0; zhi_enable <= 0; zlo_enable <= 0;
							zlo_out <= 1; gra <= 1; r_in = 1;
							#40 zlo_out <= 0; gra <= 0; r_in = 0;
						end
			//DO MULT AND DIVIDE
			branch_T0	: begin 	
							mdr_out <= 0; ir_enable <= 0;
							gra <= 1; r_out <= 1; con_enable <= 1;
						end
			branch_T1	: begin	
							gra <= 0; r_out <= 0; con_enable <= 0;
							#20 pc_out <= 1; y_enable <= 1;
						end
			branch_T2	: begin
							pc_out <= 0; y_enable <= 0;
							c_out <= 1; zlo_enable <= 1;
						end
			branch_T3	: begin
							c_out <= 0; zlo_enable <= 0;
							zlo_enable <= 1; pc_enable <= 1;
							#40 zlo_enable <= 0; pc_enable <= 0;
						end
			jump_T0		: begin 	
							mdr_out <= 0; ir_enable <= 0;
							gra <= 1; r_out <= 1; pc_enable <= 1;
							#40 gra <= 0; r_out <= 0; pc_enable <= 0;
						end
			jal_T0		: begin 	
							mdr_out <= 0; ir_enable <= 0;
							pc_out <= 1; reg_enable <= 16'h8000; 
						end
			jal_T1		: begin 	
							pc_out <= 0; reg_enable <= 16'h0;
							gra <= 1; r_out <= 1; pc_enable <= 1;
							#40 pc_enable <= 0;
						end
			in_T0		: begin 	
							mdr_out <= 0; ir_enable <= 0;
							gra <= 1; r_in <= 1; inport_enable <= 1;
							#40 gra <= 0; r_in <= 0; inport_enable <= 0;
						end
			out_T0		: begin 	
							mdr_out <= 0; ir_enable <= 0;
							gra <= 1; r_out <= 1; outport_enable <= 1;
							#40 gra <= 0; r_out <= 0; outport_enable <= 0;
						end
			mfhi_T0		: begin 	
							mdr_out <= 0; ir_enable <= 0;
							gra <= 1; r_in <= 1; hi_enable <= 1;
							#40 gra <= 0; r_in <= 0; hi_enable <= 0;
						end
			mflo_T0		: begin 	
							mdr_out <= 0; ir_enable <= 0;
							gra <= 1; r_in <= 1; lo_enable <= 1;
							#40 gra <= 0; r_in <= 0; lo_enable <= 0;
						end
		endcase
	end
endmodule		
