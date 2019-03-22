`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 15:52:15
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] src_A,
    input [31:0] src_B,
    input [2:0] alu_control,
    output zero,
    output reg [31:0] alu_result
    );
    reg [31:0] tp;
    always@(*)
        case(alu_control)
            0:alu_result <= src_A & src_B; //add
            1:alu_result <= src_A | src_B; //or
            2:alu_result <= src_A + src_B; //+
            3:;//not used
            4:alu_result <= src_A & ~src_B;//A and ~B
            5:alu_result <= src_A | ~src_B;//A or ~B
            6:alu_result <= src_A - src_B; //A-B
            7:
                begin //SLT, if less output 1
                    tp <= src_A - src_B;
                    alu_result <= tp[31];
                end
        endcase
        assign zero = alu_result == 0;
endmodule
