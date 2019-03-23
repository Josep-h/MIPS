`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 15:49:42
// Design Name: 
// Module Name: DataMemory
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


module DATA_MEMORY (
    input clk,
    input [31:0] a, //location in RAM
    input [31:0] wd, //write data
    output [31:0] rd, //read data
    input we //write enable
    );
    reg [31:0] RAM [63:0];
    
    initial 
        begin //TODO: here we have our initial files.
            RAM[0]=12; //sub
            RAM[4]=32; //addi
            RAM[8]=14; //add
            RAM[12]=18; //add
            RAM[16]=32; //add
            RAM[20]=34; //sw
            RAM[24]=-7; //nop
            RAM[28]=96; //slt......
            RAM[32]=49; //beq......
            RAM[36]=-34; //lw
            RAM[40]=34; //nop
            RAM[44]=102; //addi
            RAM[48]=52; //addi
            RAM[52]=-14; //bne
        end 
    assign rd =RAM[a[31:2]]; 

    always@(posedge clk) //write into RAM?
    begin
        if(we)
            RAM[a[31:2]]<=wd;
    end
endmodule
