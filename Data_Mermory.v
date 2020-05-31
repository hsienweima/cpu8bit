module Data_Mermory ( 

 inout [7:0] data_io,
 input [3:0] add_i,
 input r_i,w_i,clk_i,rst_i);
  
 reg[7:0] membyte [15:0];
 reg[7:0] data;
 integer i;
 
 initial
 begin
	membyte[0]=8'b11110100;
	membyte[1]=8'b00000011;
 end
 
 always@(posedge clk_i or posedge rst_i)
 begin 
	if(rst_i) begin
		membyte[0]=8'b11110100;
		membyte[1]=8'b00000011;
		for(i=2;i<15;i=i+1)
			membyte[i]=8'b0; end
	else if(w_i) begin
		membyte[add_i] <=data_io; end
	else if(r_i) begin
		data<=membyte[add_i]; end
	else begin
		data<=8'bz; end
end

assign data_io= r_i? data:8'bz;
endmodule
