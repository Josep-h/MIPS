`timescale 1ns / 1ps

module DATAPATH(
    input clk,
    //mux
    input IorD,reg_dist,mem_to_reg,alu_srca,pc_src,
    input [1:0] alu_srcb,
    //enable
    input mem_write,ir_write,reg_write,
    input branch,
    input pc_write,

    input [2:0] alu_control,
);

//basic wires
wire [31:0] w3_45,w8_10,w10_11,w6_8,w12_13,w10_13,w17_18;
wire [31:0] instr; //4 -> 6,7,8,9
wire [31:0] write_data_mem; //10 -> 3
wire [31:0] read_data; //3 -> 4
wire [31:0] data;  //5 -> 7
wire [31:0] write_data_reg; //7 -> 8
wire [31:0] sign_extend; //9 -> 12,13
wire [31:0] srcA,srcB;
wire [31:0] pc_out; //1 -> 2,11
wire [31:0] pc_in; //18 -> 1
wire [31:0] alu_out; //14 -> 17,18
wire [31:0] addr;
wire zero;
wire pc_en; //16 -> 1

PC PC_1(pc_out,pc_in,pc_en,clk,reset);
MUX2_1 MUX_2(pc_out,w17_18,IorD,addr);
DATA_INSTR_MEMORY DATA_INSTR_MEMORY_3();
REGISTER REGISTER_4();
REGISTER REGISTER_5();
MUX2_1 MUX_6();
MUX2_1 MUX_7();
REGISTER_FILE REGISTER_FILE_8();
EXTEND EXTEND_9();
REGISTER REGISTER_10_A();
REGISTER REGISTER_10_B();
MUX2_1 MUX_11();
SL2 SL2_12();
MUX4_1 MUX_13();
ALU ALU_14();
AND AND_15();
OR OR_16();
REGISTER REGISTER_17();
MUX2_1 MUX_18();
endmodule // 