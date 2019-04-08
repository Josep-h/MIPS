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
    input [4:0] rt,
    output mem_reg,
    output mem_write,
    output beq,bne,bgtz,blez,bgez,bltz,cmp_0,
    output alu_src,
    output reg_dist,
    output reg_write,
    output [2:0] alu_op,
    output jump,
    output jal,
    output sign
    );
    reg [17:0] controls;
    assign {reg_write, reg_dist, alu_src, beq, bne, bgtz, blez, bgez, bltz, cmp_0, mem_write, mem_reg, alu_op, jump, jal, sign}=controls;

    always@(*)
    case(op_code)
        6'b000000:controls<=18'b110_0000000_00_111_000; //R-type
        6'b100011:controls<=18'b101_0000000_01_000_000; //lw
        6'b101011:controls<=18'b001_0000000_10_000_000; //sw
        6'b000100:controls<=18'b000_1000000_00_001_000; //beq
        6'b000101:controls<=18'b000_0100000_00_001_000; //bne
        6'b000111:controls<=18'b000_0010000_00_001_000; //bgtz
        6'b000110:controls<=18'b000_0001000_00_001_000; //blez

        6'b001000:controls<=18'b101_0000000_00_000_000; //addi
        6'b001001:controls<=18'b101_0000000_00_000_001; //addiu
        6'b001101:controls<=18'b101_0000000_00_010_001; //ori
        6'b001010:controls<=18'b101_0000000_00_100_000; //slti
        6'b001011:controls<=18'b101_0000000_00_100_001; //sltiu
        6'b001100:controls<=18'b101_0000000_00_011_001; //andi
        6'b000010:controls<=18'b000_0000000_00_000_100; //jump
        6'b000011:controls<=18'b100_0000000_00_000_110; //jal
        6'b001110:controls<=18'b101_0000000_00_101_001; //xori
        6'b000001:
            case(rt)
                6'b00001:controls<=18'b000_0000101_00_111_000;//bgez
                6'b10001:controls<=18'b100_0000101_00_111_010;//bgezal
                6'b00000:controls<=18'b000_0000011_00_111_000;//bltz
                6'b10000:controls<=18'b100_0000011_00_111_010;//bltzal
            endcase
        default:  controls<=18'b000_0000000_00_000_000; //nop
    endcase
endmodule