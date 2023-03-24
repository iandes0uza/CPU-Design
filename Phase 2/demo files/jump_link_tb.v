`timescale 1ns / 10ps
module datapath_tb; 	//LOAD IMM TESTBENCH
	reg PCout, ZHighout, ZLowout, ZHighIn, ZLowIn, MDRout;
	reg MARin, PCin, MDRin, IRin, Yin, Yout;
	reg IncPC, Read;
	wire [4:0] opcode; 
	reg Clock, Clear;
	reg CONin, RAMin;
	reg Rin, Rout;
	reg [15:0] REGin, REGout;
	reg GRA, GRB, GRC, BAout;
	reg HIin, LOin, HIout, LOout, Cout;
	reg InPortOut, InPortIn, OutPortIn;
	reg [31:0] Mdatain, InPort_data, OutPort_data;
	wire [31:0] bus;


parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
					Reg_load2a= 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
					Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100, T6= 4'b1101;
reg	[3:0] Present_state= Default;


datapath DUT(PCout, ZLowout, ZHighout, MDRout, MDRin, MARin, ZLowIn, ZHighIn, HIin, LOin, HIout, LOout, Cout, RAMin, 
				 PCin, IRin, IncPC, CONin, Yin, Read, GRA, GRB, GRC, BAout, Rin, Rout, OutPortIn, InPortIn, InPortOut,
				 REGin, REGout,
				 opcode,
				 Mdatain, InPort_data, OutPort_data, bus,
				 Clear, Clock);

				
initial  
    begin 
       Clock = 0; 
       forever #5 Clock = ~ Clock; 
end 
 
always @(posedge Clock) 
   begin 
      case (Present_state) 
       Default			:	#40  Present_state = T0;
		T0					:	#40  Present_state = T1;
		T1					:	#40 Present_state = T2;
		T2					:	#40  Present_state = T3;
		T3					:	#40  Present_state = T4;
       endcase 
   end   
                                                          
always @(Present_state) 
begin 
    case (Present_state) 
        Default: begin 
            PCout <= 0; ZLowout <= 0; MDRout <= 0; MARin <= 0; 
				ZHighIn <= 0; ZLowIn <= 0; CONin <= 0; InPortIn <= 0; 
				OutPortIn <= 0; InPort_data <= 32'd0; PCin <=0; 
				MDRin <= 0; IRin <= 0; Yin <= 0;	IncPC <= 0; RAMin <= 0;
				Mdatain <= 32'h00000000; GRA <= 0; GRB <= 0; GRC <= 0;
				BAout <= 0; Cout <= 0; InPortOut <= 0; ZHighout <= 0; 
				LOout <= 0; HIout <=0; HIin <= 0; LOin <= 0; Rout <= 0;
				Rin <= 0; Read <= 0; REGin <= 16'd0; REGout <=16'd0;
        end 

         T0: begin                                           
						PCout <= 1; MARin <= 1; IncPC <= 1; ZLowIn <= 1;
				 end 
			T1: begin
						PCout <= 0; MARin <= 0; IncPC <= 0; ZLowIn <= 0;
						ZLowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1; Mdatain = 32'd5;
             end
         T2: begin 
						ZLowout<= 0; PCin <= 0; Read <= 0; MDRin <= 0; Mdatain = 32'd0;
						MDRout <= 1; IRin <= 1;
             end
         T3: begin 	
						MDRout<= 0; IRin <= 0;
						PCout <= 1; REGin <= 16'h8000; PCin <= 1, Rin <= 1;
             end
         T4: begin	
						PCout <= 0; REGin <= 16'h0; 
						GRA <= 1; Rout <=1 ;
						#40 PCin<= 0;
             end
    endcase 
end 
endmodule  