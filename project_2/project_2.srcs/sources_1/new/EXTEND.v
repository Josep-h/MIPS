`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 14:04:52
// Design Name: 
// Module Name: EXTEND
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


module EXTEND(
    input [15:0] in,
    output [31:0] out,
    input sign
    );
    wire [31:0] sign_extend,zero_extend;
    ZERO_EXTEND ZERO_EXTEND_0(in,zero_extend);
    SIGN_EXTEND SIGN_EXTEDN_1(in,sign_extend);
    assign out=sign ? zero_extend : sign_extend;
endmodule
