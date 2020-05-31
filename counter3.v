module counter3(

input rst_i,clear_i,halt_i,clk_i,
output [2:0] counter_o);

reg [2:0] count=3'b0;

always@(posedge clk_i )
begin
	if(rst_i)
		count<=3'b000;
	else if(clear_i)
		count<=3'b000;
	else if(count==3'b110)
		count<=3'b000;
	else count<=count+1;
end

//Rrst_i置位后可从halt状态脱离。
assign counter_o=((~halt_i)|rst_i)? count:3'b111;

endmodule