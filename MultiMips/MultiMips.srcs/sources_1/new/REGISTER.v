`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 14:06:34
// Design Name: 
// Module Name: REGISTER
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


module REGISTER(
    input clk,
    input [31:0] in,
    input en,
    output reg [31:0] out
    );

    always@(posedge clk)
    begin
        if(en)
            out<=in;
        else out<=out;
    end
endmodule
