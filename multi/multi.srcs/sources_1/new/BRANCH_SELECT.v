`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/23 14:51:47
// Design Name: 
// Module Name: BRANCH_SELECT
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


module BRANCH_SELECT(
    input zero,less,
    input [3:0] branch,
    output branch_sig
    );
    wire beq_branch,bne_branch;
    // wire bgtz_branch,blez_branch,bgez_branch,bltz_branch;
    assign beq_branch=zero&branch[0];
    assign bne_branch=~zero&branch[1];
    assign bgtz_branch=~less&~zero&branch[2];
    assign blez_branch=(less|zero)&branch[3];

    // assign bgez_branch=bgez&(~less);
    // assign bltz_branch=bltz&less;
    // assign branch=beq_branch|bne_branch|bgtz_branch|blez_branch|bgez_branch|bltz_branch;
    assign branch=beq_branch|bne_branch|bgtz_branch|blez_branch;
endmodule
