`timescale 1ns / 1ps

module TOP(
    input clk,
    input reset,
    input load,
    input clear,
    input [11:0] num
    );

    wire write_data_en;
    wire [31:0] addr,write_data_mem,read_data_mem;
    MIPS MIPS_1(clk,reset,read_data_mem,write_data_en,addr,write_data_mem);
    DATA_INSTR_MEMORY DATA_INSTR_MEMORY_3(clk,addr,write_data_en,write_data_mem,read_data_mem,load,clear,reset,num);
endmodule
