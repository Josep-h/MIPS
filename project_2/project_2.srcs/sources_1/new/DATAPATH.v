`timescale 1ns / 1ps

module DATAPATH(
  	input clk,
  	input [31:0] read_data,
  	input [31:0] instr,
	input reset,
	
	input [3:0] alu_control,
	input pc_src, mem_to_reg, alu_src,
	input reg_write, reg_dist,
	input jump,
	input sign,
	input [4:0] shamt,
	output [31:0] pc,
	output [31:0] alu_out,
	output [31:0] write_data,
	output zero
);
wire [31:0] pc_in;  //2, 6
wire [31:0] mux1_2; //1, 2
wire [31:0] pc_branch; //1, 14
wire [31:0] mem_to_reg_result; //10, 5
wire [27:0] pc_jump; //2, 8
wire [31:0] src_B; //4, 12
wire [31:0] src_A; //10, 12
wire [4:0] write_reg; //3, 10
wire [31:0] extend; //4, 9, 13
wire [31:0] lf_13; //13, 14 
wire [31:0] pc_plus_4; //1, 7, 14

MUX2_1 #(32) MUX_1(pc_plus_4   ,pc_branch                 ,pc_src    ,mux1_2);//1
MUX2_1 #(32) MUX_2(mux1_2      ,{pc_plus_4[31:28],pc_jump},jump      ,pc_in);//2
MUX2_1 #( 5) MUX_3(instr[20:16],instr[15:11]              ,reg_dist  ,write_reg);//3
MUX2_1 #(32) MUX_4(write_data  ,sign_extend               ,alu_src   ,src_B);//4
MUX2_1 #(32) MUX_5(alu_out     ,read_data                 ,mem_to_reg,mem_to_reg_result);//5

//PC
PC PC_6(pc,pc_in,clk,reset);

//PC plus 4
ADDER ADDER_7(pc,4,pc_plus_4);

//SL2
SL2 SL_8(instr,pc_jump); //TODO 

//SIGN EXTEND
EXTEND EXTEND_9(instr[15:0],extend,sign);

//REGISTER FILE
REGISTER_FILE REGISTER_FILE_10(reg_write,clk,instr[25:21],instr[20:16],write_reg,mem_to_reg_result,src_A,write_data);

//ALU
ALU ALU_12(src_A,src_B,alu_control,shamt,zero,alu_out);

//SL2 13
SL2 SL_13(extend,lf_13);

//PC BRANCH
ADDER ADDER_14(lf_13,pc_plus_4,pc_branch);

endmodule // 