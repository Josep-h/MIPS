`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/20 10:05:25
// Design Name: 
// Module Name: multisim
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


module multisim(

    );
    reg clk,reset,load,clear;
    wire [11:0] num;
    TOP TOP_0(clk,reset,load,clear,num);

    //eye region
    reg [31:0] pc;
    reg [31:0] register_1;
    reg [31:0] register_2;
    reg [31:0] alu_out;
    reg [31:0] srcA,srcB;
    reg [31:0] pc_in;
    reg [31:0] instr;
    reg [14:0] controls;
    always@(*)
        begin
            pc=TOP_0.MIPS_1.DATAPATH_3.pc_out;
            register_1=TOP_0.MIPS_1.DATAPATH_3.REGISTER_FILE_8.register_file[1];
            register_2=TOP_0.MIPS_1.DATAPATH_3.REGISTER_FILE_8.register_file[2];
            pc_in=TOP_0.MIPS_1.DATAPATH_3.pc_in;
            alu_out=TOP_0.MIPS_1.DATAPATH_3.w17_18;
            srcA=TOP_0.MIPS_1.DATAPATH_3.srcA;
            srcB=TOP_0.MIPS_1.DATAPATH_3.srcB;
            instr=TOP_0.MIPS_1.instr;
            controls=TOP_0.MIPS_1.MAIN_DECODER_2.controls;
        end
    initial

    //sim region
    begin
        clk=1;
        reset=1;
        load=0;
        clear=0;
        #2 ;
        #2 reset=0;
        repeat (100) #2 clk=~clk;
    end
endmodule