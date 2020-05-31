module cpu8bit(
input rst_i,clk_i,
output [7:0]data_io);

wire alu_sign_i,PC_en, IM_read,IR_en, MUX0_ctl, OU_read, OU_write, ALU_add, ALU_sub, DM_read, DM_write;
wire [7:0] instr_i,data_bus,ra_out;
wire [5:0] register_en ;
wire [4:0] MUX1_ctl;
wire [3:0] Jump_addr, DM_addr;

 Control_Unit	CPU_CU(
				.alu_sign_i(alu_sign_i),.PC_en(PC_en),.IR_en(IR_en),.rst_i(rst_i),.clk_i(clk_i),.IM_read(IM_read),.MUX0_ctl(MUX0_ctl),
				.OU_read(OU_read),.OU_write(OU_write),.ALU_add(ALU_add),.ALU_sub(ALU_sub),.DM_read(DM_read),
				.DM_write(DM_write),.instr_i(instr_i),.register_en(register_en),.MUX1_ctl(MUX1_ctl),
				.Jump_addr(Jump_addr),.DM_addr(DM_addr),);
				
Instruction_Read_Unit	CPU_IRU(
				.mod_i(MUX0_ctl),.pcen_i(PC_en),.imen_i(IM_read),.iren_i(IR_en),.clk_i(clk_i),
				.rst_i(rst_i),.addr_i(Jump_addr),.instr_o(instr_i),);
				
Operation_Unit	CPU_OU(
				.clk_i(clk_i),.rst_i(rst_i),.alu_add_i(ALU_add),.alu_sub_i(ALU_sub),.r_en_i(OU_read),
				.w_en_i(OU_write),.ger_register_en_i(register_en[5:2]),.alu_buffer_en_i(register_en[1:0]),
				. mux1_ctl_i(MUX1_ctl),.alu_result_sign(alu_sign_i),.data_io(data_bus),);
	
Data_Mermory	CPU_DM(
				.clk_i(clk_i),.rst_i(rst_i),.r_i(DM_read),.w_i(DM_write),.add_i(DM_addr),.data_io(data_bus),);

assign data_io=data_bus;
endmodule
				