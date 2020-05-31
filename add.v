module Adder8(

input[3:0]  addend_i,
output [3:0] result_o);

reg i=4'b1;

assign result_o=addend_i+i;

endmodule

