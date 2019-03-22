`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/22 10:32:42
// Design Name: 
// Module Name: main
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


module main(
    input mclk,
    input reset,
    input load,
    input clear,
    input [11:0] num,
    output [11:0] pc
    );
    
    TOP TOP_0(mclk,reset,load,clear,num);
    assign pc=TOP_0.pc;
endmodule
