`timescale 1ns / 1ps

module MUX4_1#(parameter WIDTH=32)
    (input [WIDTH-1:0] d0,
    input [WIDTH-1:0] d1,
    input [WIDTH-1:0] d2,
    input [WIDTH-1:0] d3,
    input [1:0] s,
    output reg [WIDTH-1:0] out
    );
    always@(*)
    begin
        case(s)
            0:out=d0;
            1:out=d1;
            2:out=d2;
            3:out=d3;
        endcase
    end
endmodule
