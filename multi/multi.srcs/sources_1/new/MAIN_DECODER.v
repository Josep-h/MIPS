`timescale 1ns / 1ps

module MAIN_DECODER(
    input clk,reset,
    input [5:0] op_code, //from register instr
    output pc_write, //enbale for register:pc
    output mem_write, // enable for write in instr-data memory
    output ir_write, // enable for write in register:instr
    output reg_write, //enable for write in register file
    output alu_srca, //0 choose pc as input while 1 use read data
    output branch, //if the instr is branch
    output IorD, //0 choose pc as input to read next instr
    output mem_to_reg, // 0 choose read data as destination, 1 choose the output of ALU
    output reg_dist, 
    output [1:0] alu_srcb,
    output [1:0] pc_src,
    output [2:0] alu_op
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
    parameter JALX    =12; //State 9

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
    reg [15:0] controls;

    always@(posedge clk, posedge reset)
        if(reset) state<=FETCH;
        else state<=nextstate;

    always@(*)
    begin
        case(state)
            FETCH:  nextstate=DECODE;
            DECODE: case(op_code)
                        RTYPE:     nextstate=RTYPEEX;
                        ADDI:      nextstate=ADDIEX;
                        // ADDIU:     nextstate=ADDIEX;
                        // SLTI:      nextstate=ADDIEX;
                        // SLTIU:     nextstate=ADDIEX;
                        // ORI:       nextstate=ADDIEX;
                        // ANDI:      nextstate=ADDIEX;
                        // XORI:      nextstate=ADDIEX;

                        LW:        nextstate=MEMADR;
                        SW:        nextstate=MEMADR;

                        BEQ:       nextstate=BEQEX;
                        // BNE:       nextstate=BEQEX;
                        // BGTZ:      nextstate=BEQEX;
                        // BLEZ:      nextstate=BEQEX;

                        // JAL:       nextstate=JALEX;                        
                        JUMP:      nextstate=JEX;
                    endcase
            MEMADR: case(op_code)
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
            // JALX:   nextstate=FETCH;
        endcase
    end 

    assign {pc_write,mem_write,ir_write,reg_write,alu_srca,branch,IorD,mem_to_reg,reg_dist,alu_srcb,pc_src,alu_op}=controls;
    always@(*)
    begin
        case(state)
            FETCH:    controls=16'b1010_00000_01_00_000;
            DECODE:   controls=16'b0000_00000_11_00_000;
            MEMADR:   controls=16'b0000_10000_10_00_000;
            MEMRD:    controls=16'b0000_00100_00_00_000;
            MEMWB:    controls=16'b0001_00010_00_00_000;
            MEMWR:    controls=16'b0100_00100_00_00_000;
            RTYPEEX:  controls=16'b0000_10000_00_00_111;
            RTYPEWB:  controls=16'b0001_00001_00_00_000;
            BEQEX:    controls=16'b0000_11000_00_01_001;
            ADDIEX:   controls=16'b0000_10000_10_00_000;
            ADDIWB:   controls=16'b0001_00000_00_00_000;
            JEX:      controls=16'b1000_00000_00_10_000;
            default:  controls=16'hxxxx;
            // JALX:     controls=15'b
        endcase
    end

endmodule