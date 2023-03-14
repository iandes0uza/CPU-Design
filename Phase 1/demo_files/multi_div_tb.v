`timescale 1ns/10ps
module multi_div_tb; 	
	reg PCout, Zhighout, Zlowout, MDRout, R6out, R7out;
	reg MARin, PCin, MDRin, IRin, Yin;
	reg IncPC, Read;
	reg [4:0] op_code; 
	reg R6in, R7in;
	reg HIin, LOin, ZHighIn, Cin, ZLowIn;
	reg Clock, Clear;		// US clear
	reg [31:0] Mdatain;
	wire [31:0] lo_contents;
	wire [31:0] hi_contents;

	parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
					Reg_load2a= 4'b0011, Reg_load2b = 4'b0100,
					T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100, T6= 4'b1101,
					MULTI = 5'b01100, DIV = 5'b01101;
					
	reg [3:0] Present_state= Default;

initial Clear = 0;

	multi_div_datapath DUT(PCout, Zlowout, Zhighout, MDRout, MARin, ZLowIn, ZHighIn, PCin, MDRin, Read, IRin, Yin, IncPC,
					 LOin,
					 HIin,
					 op_code,
					 Mdatain,
					 R6in,
					 R7in,
					 R6out,
					 R7out,
					 Clear, Clock,
					 lo_contents,
					 hi_contents);

initial 
	begin
		Clock = 0;
		forever #3 Clock = ~ Clock;
end

always @(posedge Clock)//finite state machine; if clock rising-edge
begin
	case (Present_state)
		Default			:	#40 Present_state = Reg_load1a;
		Reg_load1a		:	#40 Present_state = Reg_load1b;
		Reg_load1b		:	#40 Present_state = Reg_load2a;
		Reg_load2a		:	#40 Present_state = Reg_load2b;
		Reg_load2b		:	#40 Present_state = T0;
		T0					:	#40 Present_state = T1;
		T1					:	#40 Present_state = T2;
		T2					:	#40 Present_state = T3;
		T3					:	#40 Present_state = T4;
		T4					:	#40 Present_state = T5;
		T5					:	#40 Present_state = T6;
		endcase
	end

always @(Present_state)// do the required job ineach state
begin
	case (Present_state)              //assert the required signals in each clock cycle
		Default: begin
				PCout <= 0; Zlowout <= 0; Zhighout <= 0;  MDRout<= 0;
				R6out <= 0;   R7out <= 0;   MARin <= 0;   ZLowIn <= 0;  ZHighIn <= 0;  
				PCin <=0;   MDRin <= 0;   IRin  <= 0;   Yin <= 0;  
				IncPC <= 0;   Read <= 0;   op_code <= 0; LOin <= 0; HIin <= 0;
				R6in <= 0; R7in <= 0; Mdatain <= 32'h00000000;
		end
		Reg_load1a: begin 
				Mdatain<= 32'd25;//32'hFFFFFFF8
				Read = 0; MDRin = 0;	
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load1b: begin
				#10 MDRout<= 1; R6in <= 1;  
				#15 MDRout<= 0; R6in <= 0;     
		end
		Reg_load2a: begin 
				Mdatain <= 32'h00000006;
				#10 Read <= 1; MDRin <= 1;  
				#15 Read <= 0; MDRin <= 0;
		end
		Reg_load2b: begin
				#10 MDRout<= 1; R7in <= 1;  
				#15 MDRout<= 0; R7in <= 0;
		end
	
		T0: begin
				PCout<= 1; MARin <= 1; IncPC <= 1; //ZLowIn <= 1; ZHighIn <= 1;
				#10 PCin <= 0; MDRout <=0; PCout<= 0; MARin <= 0; IncPC <= 0; //ZLowIn <= 0; ZHighIn <= 0;
		end
		T1: begin
				Mdatain <= 32'h28918000; Read <= 1; MDRin <= 1; PCin <= 1; //Zlowout<= 1; 
				#10 Read <= 0; MDRin <= 0; PCin <= 0; //Zlowout<= 0; 
				
		end
		T2: begin
				#10 MDRout<= 1; IRin <= 1; 
				#10 MDRout<= 0; IRin <= 0; 
		end
		T3: begin
				R6out<= 1; Yin <= 1;  
				#10 R6out<= 0; Yin <= 0;
		end
		T4: begin
				R7out<= 1; op_code<= MULTI; ZLowIn<= 1; ZHighIn<= 1; 
				#10 R7out<= 0; ZLowIn<= 0; ZHighIn<= 0;
		end
		T5: begin
				Zlowout <= 1; LOin <= 1; 
				#10 Zlowout <= 0; LOin <= 0;
		end
		T6: begin
				Zhighout <= 1; HIin <= 1; 
				#10 Zhighout <= 0; HIin <= 0;
		end
	endcase
end
endmodule
