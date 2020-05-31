module Operation_Unit(

input clk_i,rst_i,alu_add_i,alu_sub_i,r_en_i,w_en_i,
input[3:0] ger_register_en_i,
input[1:0] alu_buffer_en_i,
input[4:0] mux1_ctl_i,
output alu_result_sign,
inout [7:0] data_io);

// data_i与data_o 分别设置为reg型和wire型，以避免reg类型不能作为端口输出以及wire类型不能作为左值的问题。
wire[7:0] ra_out,rb_out,rc_out,rd_out,buf1_out,buf0_out,alu_out,data_o;
reg [7:0] data_i;
Register8 OP_RA(.clk_i(clk_i),.rst_i(rst_i),.en_i(ger_register_en_i[3]),.ri_i(data_i),.ro_o(ra_out),);
Register8 OP_RB(.clk_i(clk_i),.rst_i(rst_i),.en_i(ger_register_en_i[2]),.ri_i(data_i),.ro_o(rb_out),);
Register8 OP_RC(.clk_i(clk_i),.rst_i(rst_i),.en_i(ger_register_en_i[1]),.ri_i(data_i),.ro_o(rc_out),);
Register8 OP_RD(.clk_i(clk_i),.rst_i(rst_i),.en_i(ger_register_en_i[0]),.ri_i(data_i),.ro_o(rd_out),);

Register8 OP_BUF1(.clk_i(clk_i),.rst_i(rst_i),.en_i(alu_buffer_en_i[1]),.ri_i(data_i),.ro_o(buf1_out),);
Register8 OP_BUF0(.clk_i(clk_i),.rst_i(rst_i),.en_i(alu_buffer_en_i[0]),.ri_i(alu_out),.ro_o(buf0_out),);

Mux1 OP_MUX(.A_i(ra_out),.B_i(rb_out),.C_i(rc_out),.D_i(rd_out),.Buffer0_i(buf0_out),.ctl_i(mux1_ctl_i),.result_o(data_o),);

ALU8 OP_ALU(.a1_i(buf1_out),.a0_i(data_i),.add_i(alu_add_i),.sub_i(alu_add_i),.r_o(alu_out),.sign_o(alu_result_sign),);

always@(*)
begin
	if(r_en_i)
		data_i=data_io;
	else data_i=data_o;
end
assign data_io=w_en_i?data_o:8'bz;

endmodule
