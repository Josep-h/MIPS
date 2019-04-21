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
    input beq,bne,bgtz,blez,bgez,bltz,
    output branch
    );
    wire beq_branch,bne_branch,bgtz_branch,blez_branch,bgez_branch,bltz_branch;
    assign beq_branch=zero&beq;
    assign bne_branch=~zero&bne;
    assign bgtz_branch=~less&~zero&bgtz;
    assign blez_branch=(less|zero)&blez;

    assign bgez_branch=bgez&(~less);
    assign bltz_branch=bltz&less;
    assign branch=beq_branch|bne_branch|bgtz_branch|blez_branch|bgez_branch|bltz_branch;
endmodule
