module Register4(

input clk_i,rst_i,en_i,
input[3:0] ri_i,
output[3:0] ro_o);

reg[3:0] d=4'b0;
always@(posedge clk_i or posedge rst_i)
begin
	if (rst_i) begin
		d<=4'b0; end
	else if (en_i) begin
		d<=ri_i;end
end

assign ro_o=d;
endmodule	