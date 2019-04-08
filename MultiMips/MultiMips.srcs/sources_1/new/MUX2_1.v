`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/08 20:58:16
// Design Name: 
// Module Name: MUX2_1
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


module MUX2_1#(parameter WIDTH=32)
    (input [WIDTH-1:0] d0,
    input [WIDTH-1:0] d1,
    input s,
    output [WIDTH-1:0] out
    );
    assign out=s?d1:d0;
endmodule
