`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 14:52:19
// Design Name: 
// Module Name: sim1
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

`timescale 1ns / 1ps
    /////////////////////////////////////////////////////////////////
module Top_cal();
        reg clk;
        reg clear;
        reg reset;
        reg load;
        reg [11:0] num;
        reg [11:0] num_in;
        TOP TOP_1(clk,reset,load,clear,num);
        reg [31:0] reg0,reg_s0,reg_s1,reg_s2,reg_s3,reg_s4,reg_s5,pc,instr,branch_pc;
        reg pc_src,t_nbranch,t_branch,t_zero;
        always@(*)
            begin
                reg0=TOP_1.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[0];
                reg_s0=TOP_1.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[16];
                reg_s1=TOP_1.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[17];
                reg_s2=TOP_1.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[18];
                reg_s3=TOP_1.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[19];
                reg_s4=TOP_1.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[20];
                reg_s5=TOP_1.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[21];
                // RAM_1=TOP_1.INSTR_MEMORY_2.RAM[72];
                // RAM_2=TOP_1.INSTR_MEMORY_2.RAM[76];
                // RAM_3=TOP_1.INSTR_MEMORY_2.RAM[80];
                // RAM_4=TOP_1.INSTR_MEMORY_2.RAM[84];
                // RAM_5=TOP_1.INSTR_MEMORY_2.RAM[88];
                // RAM_6=TOP_1.INSTR_MEMORY_2.RAM[92];
                // RAM_7=TOP_1.INSTR_MEMORY_2.RAM[96];
                // RAM_8=TOP_1.INSTR_MEMORY_2.RAM[100];
                // RAM_9=TOP_1.INSTR_MEMORY_2.RAM[104];
                num_in=TOP_1.INSTR_MEMORY_2.num;
                pc=TOP_1.INSTR_MEMORY_2.a;
                instr=TOP_1.INSTR_MEMORY_2.rd;
            end
        initial
        begin
        //    reset=1; clear=1; num=11; clk=1; load=0;
        //    #2 clear=~clear; load=~load; num=12; clk=~clk;
        //    #2 num=13; clk=~clk;
        //    #2 num=14; clk=~clk;
        //    #2 reset=0;
           reset=1;clk=0;load=0;clear=1;
           #2 clk=~clk; //1
           #2 clk=~clk; //0
           #2 clear=~clear;clk=~clk;//clear=0, 1
           #2 load=~load;clk=~clk;num=48; //0
           #2 clk=~clk; //1
           #2 clk=~clk;num=74; //0
           #2 clk=~clk;
           #2 clk=~clk;num=17;
           #2 clk=~clk;
           #2 clk=~clk;num=101;
           #2 clk=~clk;
           #2 clk=~clk;num=79;
           #2 clk=~clk;
           #2 clk=~clk;num=34;
           #2 clk=~clk;
           #2 load=~load;clk=~clk;
           #2 reset=~reset;
           repeat (200) #2 clk=~clk;
        end

endmodule


