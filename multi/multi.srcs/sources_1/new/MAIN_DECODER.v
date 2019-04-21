`timescale 1ns / 1ps

module MAIN_DECODER(
    input clk,reset,
    input [5:0] op_code, //from register instr
    output pc_write, //enbale for register:pc
    output mem_write, // enable for write in instr-data memory
    output ir_write, // enable for write in register:instr
    output reg_write, //enable for write in register file
    output alu_srca, //0 choose pc as input while 1 use read data
    output [3:0] branch, //if the instr is branch
    output IorD, //0 choose pc as input to read next instr
    output [1:0] mem_to_reg, // 0 choose read data as destination, 1 choose the output of ALU
    output [1:0] reg_dist, 

    //new
    output sign,

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
    parameter BNEEX   =13; //state 11
    parameter BGTZEX  =15; //State 6
    parameter BLEZEX  =16; //State 6
    
    parameter ADDIEX  =9; //State 7
    parameter ADDIWB  =10; //State 8
    parameter JEX     =11; //State 9
    parameter JALEX   =12; //State 10
    parameter ADDIUEX =14; //state 12

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
    reg [19:0] controls;

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
                        SLTI:      nextstate=ADDIEX;

                        ADDIU:     nextstate=ADDIUEX;
                        SLTIU:     nextstate=ADDIUEX;
                        ORI:       nextstate=ADDIUEX;
                        ANDI:      nextstate=ADDIUEX;
                        XORI:      nextstate=ADDIUEX;

                        LW:        nextstate=MEMADR;
                        SW:        nextstate=MEMADR;

                        BEQ:       nextstate=BEQEX;
                        BNE:       nextstate=BNEEX;
                        BGTZ:      nextstate=BGTZEX;
                        BLEZ:      nextstate=BLEZEX;

                        JAL:       nextstate=JALEX;                        
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
            BNEEX:  nextstate=FETCH;
            BGTZEX: nextstate=FETCH;
            BLEZEX: nextstate=FETCH;
            ADDIEX: nextstate=ADDIWB;
            ADDIUEX:nextstate=ADDIWB;
            ADDIWB: nextstate=FETCH;
            JEX:    nextstate=FETCH;
            JALEX:  nextstate=JEX;
        endcase
    end 
    //brach: bne,beq
    assign {pc_write,mem_write,ir_write,reg_write,alu_srca,branch,IorD,mem_to_reg,reg_dist,alu_srcb,pc_src,alu_op,sign}=controls;
    always@(*)
    begin
        case(state)
            FETCH:    controls=20'b1010_0_0000_0_00_00_01_00_000_0;
            DECODE:   controls=20'b0000_0_0000_0_00_00_11_00_000_0;
            MEMADR:   controls=20'b0000_1_0000_0_00_00_10_00_000_0;
            MEMRD:    controls=20'b0000_0_0000_1_00_00_00_00_000_0;
            MEMWB:    controls=20'b0001_0_0000_0_01_00_00_00_000_0;
            MEMWR:    controls=20'b0100_0_0000_1_00_00_00_00_000_0;
            RTYPEEX:  controls=20'b0000_1_0000_0_00_00_00_00_111_0;
            RTYPEWB:  controls=20'b0001_0_0000_0_00_01_00_00_000_0;

            BEQEX:    controls=20'b0000_1_0001_0_00_00_00_01_001_0;
            BNEEX:    controls=20'b0000_1_0010_0_00_00_00_01_001_0;
            BGTZEX:   controls=20'b0000_1_0100_0_00_00_00_01_001_0;
            BLEZEX:   controls=20'b0000_1_1000_0_00_00_00_01_001_0;
            
            ADDIEX:   controls=20'b0000_1_0000_0_00_00_10_00_000_0;
            ADDIUEX:  controls=20'b0000_1_0000_0_00_00_10_00_000_1;
            ADDIWB:   controls=20'b0001_0_0000_0_00_00_00_00_000_0;
            JEX:      controls=20'b1000_0_0000_0_00_00_00_10_000_0;
            JALEX:    controls=20'b0001_0_0000_0_10_10_00_00_000_0;
            default:  controls=20'hxxxx;
            // JALX:     controls=15'b
        endcase
    end

endmodule