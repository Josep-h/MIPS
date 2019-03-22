`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 16:01:09
// Design Name: 
// Module Name: Counter
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


module PC 
    (output reg [31:0] pc_out,
    input [31:0] pc_in,
    input clk,reset
    );
    initial 
    begin
        pc_out=0;
    end
    
    always@(posedge clk,posedge reset)
    begin
        if(reset) pc_out<=60; //when reset equals 1
        else if(pc_out==56) pc_out<=pc_out;
        else pc_out<=pc_in;
        //pc_out<=pc_in; 
    end
endmodule
