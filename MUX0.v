module MUX0(

input [3:0] a_i,b_i,
input ctl_i,
output[3:0] result_o);

//0选a通路，1选b通路
assign result_o=ctl_i?b_i:a_i;

endmodule