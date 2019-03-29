`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/08 21:04:39
// Design Name: 
// Module Name: ALU_DECODER
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


module ALU_DECODER(
    input [2:0] alu_op,
    input [5:0] funct,
    output reg [3:0] alu_control
    );
    
    always@(*)
        case(alu_op)
            0:alu_control=4'b0010; //addi
            1:alu_control=4'b0110; //subi
            2:alu_control=4'b0001; //ori
            3:alu_control=4'b0000; //andi
            4:alu_control=4'b0111; //slti
            5:alu_control=4'b1001; //xori
            default: //func
                case(funct)
                    6'b100000: alu_control=4'b0010; //add
                    6'b100010: alu_control=4'b0110; //sub
                    6'b100100: alu_control=4'b0000; //and
                    6'b100101: alu_control=4'b0001; //or
                    6'b101010: alu_control=4'b0111; //slt
                    //add but finished
                    6'b100001: alu_control=4'b0010; //andu
                    6'b100011: alu_control=4'b0110; //sltu
                    6'b100111: alu_control=4'b0011; //nor
                    6'b101011: alu_control=4'b1000; //sltu
                    6'b100110: alu_control=4'b1001; //xor
                    6'b000000: alu_control=4'b1010; //sll
                    6'b000100: alu_control=4'b1011; //sllv
                    6'b000011: alu_control=4'b1100; //sra
                    6'b000111: alu_control=4'b1101; //srav
                    6'b000010: alu_control=4'b1110; //srl
                    6'b000110: alu_control=4'b1111; //srlv

                    //add but not finish

                    default: alu_control=4'bxxxx;
                endcase
        endcase
endmodule