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
	input jal,
	input cmp_0,
	input sign,
	input [4:0] shamt,
	output [31:0] pc,
	output [31:0] alu_out,
	output [31:0] write_data, //4&10
	output zero,less
);

wire [31:0] pc_in;  //2, 6
wire [31:0] mux1_2; //1, 2
wire [31:0] pc_branch; //1, 14
wire [31:0] mem_to_reg_result; //10, 5
wire [3 :0] alu_control_sw; //make the function to add
wire [31:0] mux5_mux6;
wire [27:0] pc_jump; //2, 8
wire [31:0] src_B; //4, 12
wire [31:0] src_B_sw; //4, 12
wire [31:0] src_A; //10, 12
wire [4:0] write_reg; //3, 10
wire [4:0] mux3_mux7; //
wire [31:0] extend; //4, 9, 13
wire [31:0] lf_13; //13, 14 
wire [31:0] pc_plus_4; //1, 7, 14

MUX2_1 #(32) MUX_1(pc_plus_4   ,pc_branch                 ,pc_src    ,mux1_2);//1
MUX2_1 #(32) MUX_2(mux1_2      ,{pc_plus_4[31:28],pc_jump},jump      ,pc_in);//2
MUX2_1 #( 5) MUX_3(instr[20:16],instr[15:11]              ,reg_dist  ,mux3_mux7);//3
MUX2_1 #(32) MUX_4(write_data  ,extend               ,alu_src   ,src_B);//4
MUX2_1 #(32) MUX_5(alu_out     ,read_data                 ,mem_to_reg,mux5_mux6);//5

MUX2_1 #(32) MUX_6(mux5_mux6,pc,jal,mem_to_reg_result);
MUX2_1 #( 5) MUX_7(mux3_mux7,31,jal,write_reg);

MUX2_1 #(32) MUX_8(src_B,0,cmp_0,src_B_sw); //make the srcB to 0
MUX2_1 #( 4) MUX_9(alu_control,2,cmp_0,alu_control_sw); //make alu_control=0

//PC
PC PC_6(pc,pc_in,clk,reset);

//PC plus 4
ADDER ADDER_7(pc,4,pc_plus_4);

//SL2
SL2 SL_8(instr,pc_jump); 

//SIGN EXTEND
EXTEND EXTEND_9(instr[15:0],extend,sign);

//REGISTER FILE
REGISTER_FILE REGISTER_FILE_10(reg_write,clk,instr[25:21],instr[20:16],write_reg,mem_to_reg_result,src_A,write_data);

//ALU
ALU ALU_12(src_A,src_B_sw,alu_control_sw,shamt,zero,less,alu_out);

//SL2 13
SL2 SL_13(extend,lf_13);

//PC BRANCH
ADDER ADDER_14(lf_13,pc_plus_4,pc_branch);

endmodule // 