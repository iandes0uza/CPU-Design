`timescale 1ns/10ps
module arithmetic_div(input [31:0] in_a, in_b, output reg[63:0] result);
	reg [31:0] M, Q;
   reg [32:0] A;
   integer i;
	reg [32:0] abs_a;

   always @(*)
   begin
		begin
			if (in_a[31] == 1)
				abs_a = -in_a;
			else
				abs_a = in_a;
			Q = abs_a;
			M = in_b;
			A = 0;
			for(i = 0; i < 32; i = i+1)
			begin
				A = {A[30:0], Q[31]};
            Q[31:1] = Q[30:0];
            if(A[31] == 0)
					A = A - M;
				else
					A = A + M;
            if(A[31] == 0)
					Q[0] = 1;
				else
					Q[0] = 0;
			end
      if(A[31] == 1)
			A = A + M;
		if(in_a[31] == 1)
			Q = -Q;
      result[31:0] = Q[31:0];
		result[63:32] = A[31:0];
		end
	end

endmodule