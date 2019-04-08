`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/08 20:36:41
// Design Name: 
// Module Name: instra_mempry
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


module DATA_INSTR_MEMORY 
    (
        input clk,
        input [31:0] a, 
        input write_enable,
        input  [31:0] write_data,
        output [31:0] read_data,

        input load,
        input clear,
        input reset,
        input [11:0] num
    );
    reg [31:0] RAM[255:0]; //memory of the instruction
    reg [7:0] ct;
    initial 
        begin 
        //R-type: nor, sltu, xor, sll, slv, sra, srav, srl, srlv
        //branch: bgtz, blez
        //imm: addiu, ori, slti, sltiu, andi, xori
            RAM[0]= 32'b000000_10000_10001_00001_00000_100111; //nor   
            RAM[4]= 32'b000000_10000_10001_00001_00000_101011; //sltu  
            RAM[8]= 32'b000000_10000_10001_00001_00000_100110; //xor   

            RAM[12]=32'b000000_10001_10001_00001_00010_000000; //sll
            RAM[16]=32'b000000_10010_10001_00001_00000_000100; //sllv
            RAM[20]=32'b000000_10010_10001_00001_00010_000011; //sra
            RAM[24]=32'b000000_10010_10001_00001_00000_000111; //srav
            RAM[28]=32'b000000_10010_10001_00001_00010_000010; //srl
            RAM[32]=32'b000000_10010_10001_00001_00000_000110; //srlv

            RAM[36]=32'b001001_10000_00001_00000_00000_001011; //addiu
            RAM[40]=32'b001101_10000_00001_00000_00000_001011; //ori
            RAM[44]=32'b001010_10000_00001_00000_00000_001011; //slti
            RAM[48]=32'b001011_10000_00001_00000_00000_001011; //sltiu
            RAM[52]=32'b001100_10000_00001_00000_00000_001011; //andi
            RAM[56]=32'b001110_10000_00001_00000_00000_111111; //xori

            RAM[60]=32'b000111_10000_00000_00000_00000_000001; //bgtz
            RAM[64]=32'b111111_11111_11111_11111_11111_111111; //nop
            RAM[68]=32'b000011_00000_00000_00000_00000_010010; //jal

            RAM[72]=32'b000110_10011_00000_00000_00000_000001; //blez
            RAM[76]=32'b111111_11111_11111_11111_11111_111111; //nop 
            RAM[80]=32'b000001_10000_00001_00000_00000_000010; //bgez
            RAM[84]=32'b000001_10000_10001_11111_11111_111110; //bgezal
            RAM[88]=32'b000001_10011_00000_11111_11111_111110; //bltz
            RAM[92]=32'b000001_10011_10000_11111_11111_111110; //bltzal
        end 
    assign read_data=RAM[a];
    
    // assign rd =RAM[a[31:2]]; 

    always@(posedge clk) //write into RAM?
    begin
        if(write_enable)
            RAM[a[31:2]]<=write_data;
    end
endmodule