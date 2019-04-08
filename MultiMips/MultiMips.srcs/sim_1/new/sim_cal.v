`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 14:52:19
// Design Name: 
// Module Name: sim1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
    /////////////////////////////////////////////////////////////////
module Top_cal();
        reg clk;
        reg clear;
        reg reset;
        reg load;
        reg [11:0] num;
        // reg [11:0] num_in;
        TOP TOP_1(clk,reset,load,clear,num);
        // reg [31:0] reg0,reg_s0,reg_s1,
        reg [31:0] reg_1, alu_result;
        reg [31:0] reg_r31;
        reg [5:0] funct;
        reg jal,less;
        // reg [31:0] reg_s3,reg_s4,reg_s5;
        reg [31:0] pc;
        reg [31:0] src_B_sw;
        reg [31:0] src_A;

        // reg [31:0] instr,branch_pc;
        // reg pc_src,t_nbranch,t_branch,t_zero;
        always@(*)
            begin
                reg_1=TOP_1.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[1];
                reg_r31=TOP_1.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[31];
                alu_result=TOP_1.MIPS_1.DATAPATH_3.alu_out;
                less=TOP_1.MIPS_1.less;
                src_B_sw=TOP_1.MIPS_1.DATAPATH_3.src_B_sw;
                src_A=TOP_1.MIPS_1.DATAPATH_3.src_A;
                // pc_src=TOP_1.MIPS_1.pc_src;
                jal=TOP_1.MIPS_1.DATAPATH_3.jal;
                funct=TOP_1.MIPS_1.ALU_DECODER_1.funct;
                pc=TOP_1.INSTR_MEMORY_2.a;
            end
        initial
        begin
           reset=0;clk=0;
           repeat (150) #20 clk=~clk;
        end
endmodule