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
module Top_test();
        reg clk;
        reg reset;
        TOP TOP_1(clk,reset);
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
                pc=TOP_1.INSTR_MEMORY_2.a;
                instr=TOP_1.INSTR_MEMORY_2.rd;
                branch_pc=TOP_1.MIPS_1.DATAPATH_3.pc_branch;
                pc_src=TOP_1.MIPS_1.pc_src;
                t_branch=TOP_1.MIPS_1.branch;
                t_nbranch=TOP_1.MIPS_1.nbranch;
                t_zero=TOP_1.MIPS_1.zero;
            end
        initial
        begin
           reset=0;clk=1;
           #2 reset=~reset;
           #2;
           reset=~reset;
           repeat (600) #2 clk=~clk;
        end

endmodule


