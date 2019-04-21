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
    input [31:0] instr_data,
    
    output write_data_en,
    output [31:0] addr,
    output [31:0] write_data_mem
    );
    wire [31:0] instr;
    wire [3:0] alu_control; 
    wire [2:0] alu_op;
    wire IorD,reg_dist,mem_to_reg,alu_srca,ir_write,reg_write,branch,pc_write;
    wire [1:0] alu_srcb,pc_src;
    // wire zero_out;// for bne
    ALU_DECODER ALU_DECODER_1(alu_op, instr[5:0],alu_control);
    MAIN_DECODER MAIN_DECODER_2(clk,reset,instr[31:26],pc_write,write_data_en,ir_write,reg_write,alu_srca,branch,IorD,mem_to_reg,reg_dist,alu_srcb,pc_src,alu_op);
    DATAPATH DATAPATH_3(clk,IorD,reg_dist,mem_to_reg,alu_srca,alu_srcb,pc_src,reg_write,branch,pc_write,alu_control,instr_data,instr,reset,addr,write_data_mem);
    REGISTER REGISTER_4(clk,instr_data,ir_write,instr);
endmodule
