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
    output beq,bne,bgtz,blez,
    output alu_src,
    output reg_dist,
    output reg_write,
    output [2:0] alu_op,
    output jump,
    output sign
    );
    reg [13:0] controls;
    assign {reg_write, reg_dist, alu_src, beq, bne,bgtz,blez, mem_write, mem_reg, alu_op, jump, sign}=controls;

    always@(*)
    case(op_code)
        6'b000000:controls<=14'b110_0000_00_111_00; //R-type
        6'b100011:controls<=14'b101_0000_01_000_00; //lw
        6'b101011:controls<=14'b001_0000_10_000_00; //sw
        6'b000100:controls<=14'b000_1000_00_001_00; //beq
        6'b000101:controls<=14'b000_0100_00_001_00; //bne
        6'b000111:controls<=14'b000_0010_00_001_00; //bgtz
        6'b000110:controls<=14'b000_0001_00_001_00; //blez

        6'b001000:controls<=14'b101_0000_00_000_00; //addi
        6'b001001:controls<=14'b101_0000_00_000_01; //addiu
        6'b001101:controls<=14'b101_0000_00_010_01; //ori
        6'b001010:controls<=14'b101_0000_00_100_00; //slti
        6'b001011:controls<=14'b101_0000_00_100_01; //sltiu
        6'b001100:controls<=14'b101_0000_00_011_01; //andi
        6'b000010:controls<=14'b000_0000_00_000_10; //jump

        //add instr
        6'b001110:controls<=14'b101_0000_00_101_01; //xori

        default:  controls<=14'b000_0000_00_000_00; //nop
    endcase
endmodule