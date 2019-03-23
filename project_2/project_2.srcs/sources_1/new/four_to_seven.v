`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/04 22:46:10
// Design Name: 
// Module Name: four_to_seven
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


module four_to_seven(
    input [3:0] sw,
    output reg [6:0] led
    );
    always@(*)
    begin
        case(sw)
            0:led = 7'b1000000;
            1:led = 7'b1111001;
            2:led = 7'b0100100;
            3:led = 7'b0110000;
            4:led = 7'b0011001;
            5:led = 7'b0010010;
            6:led = 7'b0000010;
            7:led = 7'b1111000;
            8:led = 7'b0000000;
            9:led = 7'b0011000;
            default: led = 7'b1111_111;
       endcase
    end
endmodule
