			module Mux1(

			input [7:0] A_i,B_i,C_i,D_i,Buffer0_i,
			input [4:0] ctl_i,
			output [7:0] result_o);

			reg [7:0]temp;
			always@(ctl_i)
			begin
				case(ctl_i)
					5'b10000:temp=A_i;
					5'b01000:temp=B_i;
					5'b00100:temp=C_i;
					5'b00010:temp=D_i;
					5'b00001:temp=Buffer0_i;
					default: temp=8'bz;                                                    
				endcase
			end
				
			assign result_o=temp;
			endmodule