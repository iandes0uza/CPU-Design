`timescale 1ns / 10ps
module datapath_tb; 	
	reg clk, clr;
	reg IncPC, CONin; 
	reg [31:0] Mdatain;
	wire [31:0] bus;
	reg RAMin, MDRin, MDRout, MARin, IRin, Read;
	reg Rin, Rout;
	reg [15:0] REGin, REGout;
	reg GRA, GRB, GRC, BAout;
	reg HIin, LOin, ZHighIn, ZLowIn, Yin, PCin, InPortIn, OutPortIn;
	reg InPortOut, PCout, Yout, ZLowout, ZHighout, LOout, HIout, Cout;
	wire [4:0] opcode;
	reg [31:0] InPort_data;
	reg [31:0] OutPort_data;

parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
					Reg_load2a= 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
					Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
reg	[3:0] Present_state= Default;


datapath DUT(PCout, ZLowout, ZHighout, MDRout, MDRin, MARin, ZLowIn, ZHighIn, HIin, LOin, HIout, LOout, Cout, RAMin, 
				 PCin, IRin, IncPC, Yin, Read, GRA, GRB, GRC, BAout, Rin, Rout, OutPortIn, InPortIn,
				 REGin, REGout,
				 opcode,
				 Mdatain, InPort_data, OutPort_data, bus,
				 clr, clk);
				 

				
// add test logic here 
initial  
    begin 
	 
DUT.physical_memory.ram_contents[0] = 32'h00800075;
DUT.physical_memory.ram_contents[1] = 32'h00800075;
DUT.physical_memory.ram_contents[2] = 32'h00800075;
DUT.physical_memory.ram_contents[3] = 32'h00800075;
DUT.physical_memory.ram_contents[117] = 32'h00000004;

DUT.physical_memory.ram_contents[73] = 32'h00000004;
       clk = 0; 
       forever #10 clk = ~ clk; 
end 
 
always @(posedge clk)  // finite state machine; if clock rising-edge 
   begin 
      case (Present_state) 
       Default			:	#40  Present_state = T0;
		T0					:	#40  Present_state = T1;
		T1					:	 #40 Present_state = T2;
		T2					:	#40  Present_state = T3;
		T3					:	#40  Present_state = T4;
		T4					:	 #40 Present_state = T5;
		//T5					:	 #40 Present_state = T6;
		//T6					:	 #40 Present_state = T7;
       endcase 
   end   
                                                          
always @(Present_state)  // do the required job in each state 
begin 
    case (Present_state)               // assert the required signals in each clock cycle 
        Default: begin 
              PCout <= 0; ZLowout <= 0; MDRout <= 0; 
				MARin <= 0; ZHighIn <= 0; ZLowIn <= 0; CONin<=0; 
				InPortIn<=0; OutPortIn<=0;
				InPort_data<=32'd0;
				PCin <=0; MDRin <= 0; IRin <= 0; 
				Yin <= 0;
				IncPC <= 0; RAMin <=0;
				Mdatain <= 32'h00000000; GRA<=0; GRB<=0; GRC<=0;
				BAout<=0; Cout<=0;
				InPortOut<=0; ZHighout<=0; LOout<=0; HIout<=0; 
				HIin<=0; LOin<=0;
				Rout<=0;Rin<=0;Read<=0;
				REGin<= 16'd0; REGout<=16'd0;
						
        end 

 
         T0: begin                                                                                  // see if you need to de-assert these signals 
				 PCout <= 1; MARin <= 1; IncPC <= 1; ZLowIn <= 1;
				  //Deassert the signals before the next step
				end 
			T1: begin
                PCout <= 0; MARin <= 0; IncPC <= 0; ZLowIn <= 0;
                
                ZLowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1;
            end
            T2: begin
                ZLowout<= 0; PCin <= 0; Read <= 0; MDRin <= 0;

                MDRout<= 1; IRin <= 1;
				
            end
            T3: begin
                MDRout <= 0; IRin <= 0;
                
                GRB <= 1; BAout <= 1; Yin <= 1;
                
            end
            T4: begin
                GRB <= 0; BAout <= 0; Yin <= 0;

                Cout <= 1; ZHighIn <= 1; ZLowIn <= 1;
            end
            T5: begin
                Cout <= 0; ZHighIn <= 0; ZLowIn <= 0;
                
                ZLowout<= 1; GRA <= 1; Rin <= 1; 
					 #40 ZLowout <= 0; GRA <= 0; Rin <= 0; 
				end
    endcase 
end 
endmodule  