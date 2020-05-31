module Instruction_Read_Unit(

input mod_i,pcen_i,imen_i,iren_i,clk_i,rst_i,
input [3:0] addr_i,
output[7:0] instr_o);

wire [3:0]wir1,wir2,wir3;
wire [7:0]wir4;
//wir1********pc输入
//wir2********PC输出
//wir3********adder输出
//wir4********IR输入

Register4 IRU_PC(.clk_i(clk_i),.rst_i(rst_i),.en_i(pcen_i),.ri_i(wir1),.ro_o(wir2),);
Instruction_Mermory IRU_IM(.read_i(imen_i),.data_o(wir4),.addr_i(wir2),);
MUX0	IRU_MUX(.a_i(wir3),.b_i(addr_i),.ctl_i(mod_i),.result_o(wir1),);
Adder8 IRU_ADD(.addend_i(wir2),.result_o(wir3),);
Register8 IRU_IR(.clk_i(clk_i),.rst_i(rst_i),.en_i(iren_i),.ri_i(wir4),.ro_o(instr_o),);

endmodule
