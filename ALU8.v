module ALU8(
	input [7:0] a1_i,a0_i,
	input add_i,sub_i,
	output  [7:0] r_o,
	output  sign_o);

reg signed [7:0]temp_r=8'b0;

always@(add_i,sub_i)
begin
	if (add_i)
		temp_r=a1_i+a0_i; 
	else if (sub_i)
		temp_r=a1_i-a0_i;
	//else
		//temp_r=8'b0;	//此处设置为8‘bz时，在仿真时标志位会出现错误。
						//原因是输出高阻态时，其值会随着与之相连的电路变化而变化，在后边无法进行比较。	
end

assign r_o=temp_r;
// 结果为非负数时，符号指示位为0，为负数时，指示位为1
assign sign_o=(temp_r<0)?1'b1:1'b0;

endmodule