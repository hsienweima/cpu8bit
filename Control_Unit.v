module Control_Unit(

input alu_sign_i,rst_i,clk_i,
input [7:0] instr_i,
output	reg PC_en, IM_read,IR_en, MUX0_ctl, OU_read, OU_write, ALU_add, ALU_sub, DM_read, DM_write,
output	reg [5:0] register_en ,
output	reg [4:0] MUX1_ctl,
output 	reg [3:0] Jump_addr, DM_addr);
 
reg clear, halt;
wire [2:0] counter;

counter3 CU_COUNT(.rst_i(rst_i),.clear_i(clear),.halt_i(halt),.clk_i(clk_i),.counter_o(counter),);

parameter t0=3'b000,t1=3'b001,t2=3'b010,t3=3'b011,t4=3'b100,t5=3'b101,t6=3'b110;
parameter LOAD_A=4'b0010, LOAD_B=4'b0001, STORE_A=4'b0100,ADD=4'b1000, 
			SUB=4'b1001, JUMP=4'b1100, JUMP_NEG=4'b1101, HALT=4'b1111,NOP=4'b0000;
parameter ra=2'b00,rb=2'b01,rc=2'b10,rd=2'b11;

//clear将计数器置零， halt信号使计数器保持在3‘111，进入halt状态
always@(negedge clk_i)
begin	
		PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
		ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
		register_en=6'b000000; MUX1_ctl=5'b00000; Jump_addr=4'b0000; DM_addr=4'b0000;
		
	case (counter)	
	t0:;
	
	t1:begin
		PC_en=1'b1; IM_read=1'b1; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
		ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
		register_en=6'b000000; MUX1_ctl=5'b00000; Jump_addr=4'b0000; DM_addr=4'b0000;end
	
	t2: begin
		PC_en=1'b0; IM_read=1'b0; IR_en=1'b1; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
		ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
		register_en=6'b000000; MUX1_ctl=5'b00000; Jump_addr=4'b0000; DM_addr=4'b0000;end
	
	t3:begin
		case(instr_i[7:4]) 
		LOAD_A: begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b1; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b1; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b000000; MUX1_ctl=5'b00000; Jump_addr=4'b0000; DM_addr=instr_i[3:0];end
		LOAD_B: begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b1; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b1; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b000000; MUX1_ctl=5'b00000; Jump_addr=4'b0000; DM_addr=instr_i[3:0];end
		STORE_A:begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b000000; MUX1_ctl=5'b10000; Jump_addr=4'b0000; DM_addr=4'b0000;end
		ADD:	begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b000010; Jump_addr=4'b0000; DM_addr=4'b0000;
				case(instr_i[3:2]) 
					ra:MUX1_ctl=5'b10000;
					rb:MUX1_ctl=5'b01000;
					rc:MUX1_ctl=5'b00100;
					rd:MUX1_ctl=5'b00010;
				endcase
				end
		SUB:	begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b000010; Jump_addr=4'b0000; DM_addr=4'b0000;
				case(instr_i[3:2]) 
					ra:MUX1_ctl=5'b10000;
					rb:MUX1_ctl=5'b01000;
					rc:MUX1_ctl=5'b00100;
					rd:MUX1_ctl=5'b00010;
				endcase
				end
		JUMP:	begin
				PC_en=1'b1; IM_read=1'b1; IR_en=1'b0; MUX0_ctl=1'b1; OU_read=1'b0; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b000000; MUX1_ctl=5'b00000; Jump_addr=instr_i[3:0]; DM_addr=4'b0000;end
		JUMP_NEG:begin
				if(alu_sign_i) begin
					PC_en=1'b1; IM_read=1'b1; IR_en=1'b0; MUX0_ctl=1'b1; OU_read=1'b0; OU_write=1'b0;
					ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
					register_en=6'b000000; MUX1_ctl=5'b00000; Jump_addr=instr_i[3:0]; DM_addr=4'b0000;end
				else begin
					PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
					ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b1; halt=1'b0;
					register_en=6'b000000; MUX1_ctl=5'b00000; Jump_addr=4'b0000; DM_addr=4'b0000;end
				end
		HALT:	begin 
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b1;
				register_en=6'b000000; MUX1_ctl=5'b00000; Jump_addr=4'b0000; DM_addr=4'b0000;end
		NOP: clear=1'b1;
		default:clear=1'b1;
		endcase
		end
	t4:begin
		case(instr_i[7:4]) 
		LOAD_A:	begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b1; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b1; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b100000; MUX1_ctl=5'b00000; Jump_addr=4'b0000; DM_addr=instr_i[3:0];end
		LOAD_B:	begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b1; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b1; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b010000; MUX1_ctl=5'b00000; Jump_addr=4'b0000; DM_addr=instr_i[3:0];end
		STORE_A:	begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b1;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b1; clear=1'b0; halt=1'b0;
				register_en=6'b000000; MUX1_ctl=5'b00000; Jump_addr=4'b0000; DM_addr=instr_i[3:0];end
		ADD:	begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
				ALU_add=1'b1; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b000001; Jump_addr=4'b0000; DM_addr=4'b0000;
				case(instr_i[1:0]) 
					ra:MUX1_ctl=5'b10000;
					rb:MUX1_ctl=5'b01000;
					rc:MUX1_ctl=5'b00100;
					rd:MUX1_ctl=5'b00010;
				endcase
				end
		SUB:	begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b1; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b000001; Jump_addr=4'b0000; DM_addr=4'b0000;
				case(instr_i[1:0]) 
					ra:MUX1_ctl=5'b10000;
					rb:MUX1_ctl=5'b01000;
					rc:MUX1_ctl=5'b00100;
					rd:MUX1_ctl=5'b00010;
				endcase
				end
		JUMP:	clear=1'b1;
		JUMP_NEG:clear=1'b1;
		HALT:halt=1'b1;
		NOP:clear=1'b0;
		default: halt=1'b1;
		endcase
		end
	t5:begin
		case(instr_i[7:4]) 
		LOAD_A:	clear=1'b1;
		LOAD_B:	clear=1'b1;
		STORE_A:	clear=1'b1;
		ADD:	begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b100000; MUX1_ctl=5'b00001; Jump_addr=4'b0000; DM_addr=4'b0000;end
		SUB:	begin
				PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
				ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b0;
				register_en=6'b100000; MUX1_ctl=5'b00001; Jump_addr=4'b0000; DM_addr=4'b0000;end
		JUMP:;
		JUMP_NEG:;
		HALT:halt=1'b1;
		NOP:clear=1'b0;
		default:halt=1'b1;
		endcase
		end
	t6:begin
		case(instr_i[7:4]) 
		LOAD_A:;
		LOAD_B:;
		STORE_A:;
		ADD:	clear=1'b1;	
		SUB:	clear=1'b1;	
		JUMP:;
		JUMP_NEG:;
		HALT:halt=1'b1;
		NOP:clear=1'b0;
		default:halt=1'b1;
		endcase
		end
	default:begin
			PC_en=1'b0; IM_read=1'b0; IR_en=1'b0; MUX0_ctl=1'b0; OU_read=1'b0; OU_write=1'b0;
			ALU_add=1'b0; ALU_sub=1'b0; DM_read=1'b0; DM_write=1'b0; clear=1'b0; halt=1'b1;
			register_en=6'b000000; MUX1_ctl=5'b00000; Jump_addr=4'b0000; DM_addr=4'b0000;end
	endcase
end

endmodule
	
		