`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 15:50:50
// Design Name: 
// Module Name: RegisterFile
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


module REGISTER_FILE 
    (input we3, //wirte enable
    input clk,
    input [4:0] a1,   //output what register to rd1
    input [4:0] a2,   //output what register to rd2
    input [4:0] a3,   //input to what register
    input [31:0] wd3, //write data
    output [31:0] rd1,//output the read data
    output [31:0] rd2 //output the read data
    );
    reg [31:0] register_file[31:0];
    //output
    assign rd1 = (a1!=0)?register_file[a1]:0; 
    assign rd2 = (a2!=0)?register_file[a2]:0;
    
    initial
        begin
            register_file[0]=0;
            register_file[1]=1;
            register_file[16]=7'b1110101;
            register_file[17]=7'b0101100;
            register_file[18]=2;
            register_file[19]=-3;
            register_file[20]=20;
            register_file[21]=0;
        end

    always@(posedge clk) //write data to register
    begin
        if(we3)
            register_file[a3]<=wd3;
    end
endmodule
