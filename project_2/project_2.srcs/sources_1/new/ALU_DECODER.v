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
    input [5:0] op_code,
    input [1:0] alu_op,
    input [5:0] funct,
    output reg [2:0] alu_control
    );
    
    always@(*)
        case(op_code)
            001010:alu_control<=111;//stli
            001101:alu_control<=001;//ori
            001100:alu_control<=000;//andi
            default:
                case(alu_op)
                    0:alu_control<=3'b010; //add
                    1:alu_control<=3'b110; //sub
                    default: //func
                        case(funct)
                            6'b100000: alu_control<=3'b010; //add
                            6'b100010: alu_control<=3'b110; //sub
                            6'b100100: alu_control<=3'b000; //and
                            6'b100101: alu_control<=3'b001; //or
                            6'b101010: alu_control<=3'b111; //slt

                            // 6'b101010: alu_control<=3'b111; //andu
                            // 6'b101010: alu_control<=3'b111; //andiu
                            // 6'b101010: alu_control<=3'b111; //subu
                            // 6'b101010: alu_control<=3'b111; //sltu

                            // 6'b101010: alu_control<=3'b111; //nor
                            // 6'b101010: alu_control<=3'b111; //nori
                            // 6'b101010: alu_control<=3'b111; //xor
                            // 6'b101010: alu_control<=3'b111; //xori

                            // 6'b101010: alu_control<=3'b111; //sll
                            // 6'b101010: alu_control<=3'b111; //srl
                            // 6'b101010: alu_control<=3'b111; //sra
                            // 6'b101010: alu_control<=3'b111; //sllv
                            // 6'b101010: alu_control<=3'b111; //srlv

                            // 6'b101010: alu_control<=3'b111; //jr
                            // 6'b101010: alu_control<=3'b111; //jal
                            default: alu_control<=3'bxxx;
                        endcase
                endcase
        endcase
endmodule