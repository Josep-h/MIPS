`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/08 21:04:39
// Design Name: 
// Module Name: MAIN_DECODER
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


module MAIN_DECODER(
    input [5:0] op_code,
    output mem_reg,
    output mem_write,
    output branch,
    output nbranch, //markes the if bne or neq take place
    output alu_src,
    output reg_dist,
    output reg_write,
    output [1:0] alu_op,
    output jump
    );
    reg [9:0] controls;
    assign {reg_write, reg_dist, alu_src, branch, nbranch, mem_write, mem_reg, alu_op, jump}=controls;

    always@(*)
    case(op_code)
        6'b000000:controls<=10'b1100000100; //R-type
        6'b100011:controls<=10'b1010001000; //lw
        6'b101011:controls<=10'b0010010000; //sw
        6'b000100:controls<=10'b0001000010; //beq
        6'b000101:controls<=10'b0001100010; //bne
        6'b001000:controls<=10'b1010000000; //addi
        6'b001101:controls<=10'b1010000000; //ori
        6'b001010:controls<=10'b1010000000; //slti
        6'b001100:controls<=10'b1010000000; //andi
        6'b000010:controls<=10'b0000000001; //jump
        default:  controls<=10'b0000000000; //nop
    endcase
endmodule