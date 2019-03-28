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


module INSTR_MEMORY 
    (input [31:0] a, 
    output [31:0] rd,
    input load,
    input clear,
    input reset,
    input clk,
    input [11:0] num
    );
    reg [31:0] RAM[255:0]; //memory of the instruction
    reg [7:0] ct;
    initial 
        begin 
            RAM[0]= 32'b00000000000000000000000000100010; //sub
            RAM[4]= 32'b00000000000000001000100000100000; //add s1=0
            RAM[8]= 32'b00000000000000001001000000100000; //add s2=0
            RAM[12]=32'b00000000000000001010100000100000; //add
            //L1:
            RAM[16]=32'b10001110001100110000000000000000; //lw
            RAM[20]=32'b11111111111111111111111111111111; //nop
            RAM[24]=32'b00000010010100111010000000101010; //slt......
            RAM[28]=32'b00010000000101000000000000000010; //beq......
            RAM[32]=32'b10001110001100100000000000000000; //lw
            RAM[36]=32'b11111111111111111111111111111111; //nop
            //L2:
            RAM[40]=32'b00100010101101010000000000000001; //addi
            RAM[44]=32'b00100010001100010000000000010000; //addi
            RAM[48]=32'b00010110101100001111111111110111; //bne
            RAM[52]=32'b10101110001100100000000000000000; //sw

            //hlt
            RAM[56]=32'b11111111111111111111111111111111; //hlt

            //op
            RAM[60]=32'b00000000000000000000000000100010; //sub
            RAM[64]=32'b00100000000100000000000000000000; //addi
            RAM[68]=32'b00000010000000001000100000100101; //or
            RAM[72]=32'b00001000000000000000000000000000; //j
            ct=72;
        end 
    always@(posedge clk)
        if(reset) // in the mode of reset
            begin
                if(clear)
                    begin 
                        ct<=72; //if reset and clear, we can change the number
                        RAM[72]<=32'b00001000000000000000000000000000;
                    end
                else if(load) //put int number
                    begin
                        RAM[ct]<=32'b00100000000100100000000000000000+num; //addi
                        RAM[ct+4]<=32'b10101110001100100000000000000000; //sw
                        RAM[ct+8]<=32'b00100010001100010000000000010000; //addi: s1=s1+16
                        RAM[ct+12]<=32'b00100010000100000000000000000001; //addi
                        RAM[ct+16]<=32'b00001000000000000000000000000000; //j
                        ct<=ct+16;
                    end
                else 
                    begin
                        ct<=ct;
                        // RAM[ct]<=32'b00001000000000000000000000000000;
                    end
            end
    assign rd=RAM[a];
endmodule