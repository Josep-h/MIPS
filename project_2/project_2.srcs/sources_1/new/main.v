`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/22 10:32:42
// Design Name: 
// Module Name: main
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


module main(
    input mclk,
    input reset,
    input load,
    input clear,
    input [11:0] num,
    output reg [7:0] pc,
    output reg [7:0] reg_2
    );
    wire clk;
    clkdiv CLKDIV_1(mclk,clk);
    TOP TOP_0(clk,reset,load,clear,num);
    always@(posedge clk,posedge reset)
    begin
      if(reset==1)
        pc<=TOP_0.INSTR_MEMORY_2.ct;
      else 
        begin 
          reg_2<=TOP_0.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[18];
          pc<=TOP_0.INSTR_MEMORY_2.RAM[TOP_0.MIPS_1.pc];
        end
    end
endmodule
