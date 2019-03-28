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
    wire mem_write;
    
    MIPS MIPS_1(clk,reset,read_data,instr,mem_write,pc,alu_out,write_data);
    INSTR_MEMORY INSTR_MEMORY_2(pc,instr,load,clear,reset,clk,num);
    DATA_MEMORY DATA_MEMORY_3(clk,alu_out,write_data,read_data,mem_write);
endmodule
