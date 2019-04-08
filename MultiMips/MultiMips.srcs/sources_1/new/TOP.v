`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 09:43:04
// Design Name: 
// Module Name: TOP
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


module TOP(
    input clk,
    input reset,
    input load,
    input clear,
    input [11:0] num
    );
    wire [31:0] read_data;
    wire [31:0] instr;
    wire [31:0] pc;
    wire [31:0] alu_out;
    wire [31:0] write_data;
    wire write_mem;
    
    MIPS MIPS_1(clk,reset,read_data,instr,write_mem,pc,alu_out,write_data);
    DATA_INSTR_MEMORY DATA_INSTR_MEMORY_2(clk,pc,write_mem,write_data,read_data,load,clear,reset,num);
endmodule
