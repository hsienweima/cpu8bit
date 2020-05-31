module  Instruction_Mermory(

input [3:0] addr_i,
output[7:0] data_o,
input read_i);

reg[7:0] im[15:0];
// 指令初始化
initial
begin
	im[0]=8'b00000000;
	im[1]=8'b00100000;
	im[2]=8'b00010001;
	im[3]=8'b00000000;
	im[4]=8'b10000001;
	im[5]=8'b11010011;
	im[6]=8'b11001000;
	im[8]=8'b00000000;
	im[9]=8'b10010001;
	im[10]=8'b01001000;
	im[11]=8'b00101000;
	im[12]=8'b11111111;
		
end
assign data_o=read_i? im[addr_i]: 8'bz ;

endmodule
	
		