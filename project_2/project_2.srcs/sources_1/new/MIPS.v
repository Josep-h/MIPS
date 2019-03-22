`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 09:42:46
// Design Name: 
// Module Name: MIPS
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


module MIPS(
    input clk,
    input reset,
    input [31:0] read_data,
    input [31:0] instr,
    output mem_write,
    output [31:0] pc,
    output [31:0] alu_out,
    output [31:0] write_data
    );
    wire [2:0] alu_control; 
    wire [1:0] alu_op;
    wire pc_src,mem_to_reg,alu_src,reg_dist,reg_write,zero,branch,nbranch;
    wire jump;
    wire zero_out;// for bne
    xor XOR16(zero_out,nbranch,zero);
    ALU_DECODER ALU_DECODER_1(instr[31:26],alu_op, instr[5:0], alu_control);
    MAIN_DECODER MAIN_DECODER_2(instr[31:26],mem_to_reg,mem_write,branch,nbranch,alu_src,reg_dist,reg_write,alu_op,jump);
    DATAPATH DATAPATH_3(clk,read_data,instr,reset,alu_control,pc_src,mem_to_reg,alu_src,reg_write,reg_dist,jump,pc,alu_out,write_data,zero);
    and AND15(pc_src,branch,zero_out);
endmodule
