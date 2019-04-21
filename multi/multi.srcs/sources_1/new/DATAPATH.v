`timescale 1ns / 1ps

module DATAPATH(
    input clk,
    //mux
    input IorD,alu_srca,
    input [1:0] alu_srcb,pc_src,reg_dist,mem_to_reg,
    //enable
    input reg_write,
    input [3:0] branch,
    input pc_write,

    input [3:0] alu_control,
    input [31:0] read_data, //3 -> 4
    input [31:0] instr,  //4 -> 6,7,8,9
    input reset,
    input sign,

    output [31:0] addr, //2 -> 3
    output [31:0] write_data_mem //10 -> 3,13
);

//basic wires
wire [31:0] w3_45,w10_11,w6_8,w12_13,w17_18;
wire [31:0] data;  //5 -> 7
wire [31:0] write_data_reg; //7 -> 8
wire [31:0] sign_extend; //9 -> 12,13
wire [31:0] srcA,srcB;
wire [31:0] pc_out; //1 -> 2,11
wire [31:0] pc_in; //18 -> 1
wire [31:0] alu_out; //14 -> 17,18
wire [31:0] w8_10_A,w8_10_B;
wire zero,less;
wire pc_en; //16 -> 1
wire w15_16;
wire [27:0] w19_18;
wire branch_sig;

PC PC_1(pc_out,pc_in,pc_en,clk,reset);
MUX2_1 MUX_2(pc_out,w17_18,IorD,addr);
REGISTER REGISTER_5(clk,read_data,1,data);
MUX4_1 #(5) MUX_6(instr[20:16],instr[15:11],31,0,reg_dist,w6_8);
MUX4_1 MUX_7(w17_18,data,pc_out,0,mem_to_reg,write_data_reg);
REGISTER_FILE REGISTER_FILE_8(reg_write,clk,instr[25:21],instr[20:16],w6_8,write_data_reg,w8_10_A,w8_10_B);
// SIGN_EXTEND EXTEND_9(instr[15:0],sign_extend);
EXTEND EXTEND_9(instr[15:0],sign_extend,sign);
REGISTER REGISTER_10_A(clk,w8_10_A,1,w10_11);
REGISTER REGISTER_10_B(clk,w8_10_B,1,write_data_mem);
MUX2_1 MUX_11(pc_out,w10_11,alu_srca,srcA);
SL2 SL2_12(sign_extend,w12_13);
MUX4_1 MUX_13(write_data_mem,4,sign_extend,w12_13,alu_srcb,srcB);
ALU ALU_14(srcA,srcB,alu_control,instr[10:6],zero,less,alu_out);
// and AND_15(w15_16,branch_sig,zero);
or OR_16(pc_en,w15_16,pc_write);
REGISTER REGISTER_17(clk,alu_out,1,w17_18);
MUX4_1 MUX_18(alu_out,w17_18,{pc_out[31:28],w19_18},0,pc_src,pc_in);
SL2 SL2_19(instr[25:0],w19_18);
BRANCH_SELECT BRANCH_19(zero,less,branch,w15_16);
endmodule