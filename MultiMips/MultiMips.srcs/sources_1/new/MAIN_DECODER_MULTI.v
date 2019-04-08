`timescale 1ns / 1ps

module MAIN_DECODER_MULTI(
    input clk,reset,
    input [5:0] op_code,
    input [4:0] rt,
    output mem_reg,
    output mem_write,
    output pc_write,
    output ir_write,
    output beq,bne,bgtz,blez,bgez,bltz,cmp_0,
    output alu_srca,
    output [1:0] alu_srcb,pc_src,
    output reg_dist,
    output reg_write,
    output [2:0] alu_op,
    output jump,
    output jal,
    output sign
    );

    parameter FETCH   =0; //State 0
    parameter DECODE  =1; //State 1
    parameter MEMADR  =2; //State 2
    parameter MEMRD   =3; //State 3
    parameter MEMWB   =4; //State 4
    parameter MEMWR   =5; //State 5
    parameter RTYPEEX =6; //State 5
    parameter RTYPEWB =7; //State 5
    parameter BEQEX   =8; //State 6
    parameter ADDIEX  =9; //State 7
    parameter ADDIWB  =10; //State 8
    parameter JEX     =11; //State 9

    parameter RTYPE      =6'b000000;
    
    parameter ADDI       =6'b001000;
    parameter ADDIU      =6'b001001;
    parameter SLTI       =6'b001010;
    parameter SLTIU      =6'b001011;
    parameter ORI        =6'b001101;
    parameter ANDI       =6'b001100;
    parameter XORI       =6'b001110;
    
    parameter LW         =6'b100011;
    parameter SW         =6'b101011;
    
    parameter BEQ        =6'b000100;
    parameter BNE        =6'b000101;
    parameter BGTZ       =6'b000111;
    parameter BLEZ       =6'b000110;

    parameter JUMP       =6'b000010;
    parameter JAL        =6'b000011;

    reg [3:0] state,nextstate;
    reg [14:0] controls;

    always@(posedge clk, posedge reset)
        if(reset) state<=FETCH;
        else state<=nextstate;

    always@(*)
    begin
        case(state)
            FETCH:  nextstate=DECODE;
            DECODE: case(op)
                        LW:     nextstate=MEMADR;
                        SW:     nextstate=MEMADR;
                        RTYPE:  nextstate=RTYPEEX;
                        BEQ:    nextstate=BEQEX;
                        ADDI:   nextstate=ADDIEX;
                        J:      nextstate=JEX;
                    endcase
            MEMADR: case(op)
                        LW:     nextstate=MEMRD;
                        SW:     nextstate=MEMWR;
                        default:nextstate=4'bx;
                    endcase
            MEMRD:  nextstate=MEMWB;
            MEMWB:  nextstate=FETCH;
            MEMWR:  nextstate=FETCH;
            RTYPEEX:nextstate=RTYPEWB;
            RTYPEWB:nextstate=FETCH;
            BEQEX:  nextstate=FETCH;
            ADDIEX: nextstate=ADDIWB;
            ADDIWB: nextstate=FETCH;
            JEX:    nextstate=FETCH;
        endcase
    end 

    // assign {pc_write,mem_write,ir_write,reg_write,alu_src}
    always@(*)
    begin
        case(state)
            FETCH:    controls=15'b
            DECODE:   controls=15'b
            MEMADR:   controls=15'b
            MEMRD:    controls=15'b
            MEMWB:    controls=15'b
            MEMWR:    controls=15'b
            RTYPEEX:  controls=15'b
            RTYPEWB:  controls=15'b
            BEQEX:    controls=15'b
            ADDIEX:   controls=15'b
            ADDIWB:   controls=15'b
            JEX:      controls=15'b
        endcase
    end

endmodule