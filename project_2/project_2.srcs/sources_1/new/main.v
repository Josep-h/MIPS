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
    output reg [7:0] an,
    output reg [6:0] LED,
    output [7:0] pc
    // output reg [7:0] reg_2
    );
    wire clk,clk_LED;
    clkdiv2 CLKDIV_1(mclk,clk_LED,clk);
    TOP TOP_0(clk,reset,load,clear,num);
    // always@(posedge clk,posedge reset)
    // begin
    //   if(reset==1)
    //     pc<=TOP_0.INSTR_MEMORY_2.ct;
    //   else 
    //     begin 
    //       reg_2<=TOP_0.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[18];
    //       pc<=TOP_0.INSTR_MEMORY_2.RAM[TOP_0.MIPS_1.pc];
    //     end
    // end


    reg [2:0] enable;
    wire [6:0] pos_0_LED,pos_1_LED,pos_2_LED,pos_3_LED,pos_4_LED,pos_5_LED,pos_6_LED,pos_7_LED; //after LED and for state=1
    // reg [3:0] pos_0_1,    pos_1_1,    pos_2_1,    pos_3_1;
    // reg [6:0] pos_0_0_LED,pos_1_0_LED,pos_2_0_LED,pos_3_0_LED; //after LED and for state=0
    wire [3:0]  pos_0,    pos_1,    pos_2,    pos_3,    pos_4,    pos_5,    pos_6,    pos_7;
    four_to_seven fts_0(pos_0,pos_0_LED);
    four_to_seven fts_1(pos_1,pos_1_LED);
    four_to_seven fts_2(pos_2,pos_2_LED);
    four_to_seven fts_3(pos_3,pos_3_LED);

    four_to_seven fts_4(pos_4,pos_4_LED);
    four_to_seven fts_5(pos_5,pos_5_LED);
    four_to_seven fts_6(pos_6,pos_6_LED);
    four_to_seven fts_7(pos_7,pos_7_LED);

    assign pos_0=TOP_0.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[18]%10;
    assign pos_1=(TOP_0.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[18]/10)%10;
    assign pos_2=(TOP_0.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[18]/100)%10;
    assign pos_3=0;
    assign pos_4=TOP_0.MIPS_1.pc%10;
    assign pos_5=(TOP_0.MIPS_1.pc/10)%10;
    assign pos_6=(TOP_0.MIPS_1.pc/100)%10;
    assign pos_7=0;
    assign pc=TOP_0.INSTR_MEMORY_2.ct;

    always@(posedge clk_LED)
      begin
        case(enable)
          3'b000:begin an=8'b1111_1110; LED=pos_0_LED; end
          3'b001:begin an=8'b1111_1101; LED=pos_1_LED; end
          3'b010:begin an=8'b1111_1011; LED=pos_2_LED; end
          3'b010:begin an=8'b1111_0111; LED=pos_3_LED; end
          
          3'b011:begin an=8'b1110_1111; LED=pos_4_LED; end
          3'b100:begin an=8'b1101_1111; LED=pos_5_LED; end
          3'b101:begin an=8'b1011_1111; LED=pos_6_LED; end
          3'b110:begin an=8'b0111_1111; LED=pos_7_LED; end
          default enable<=0;
        endcase
        enable<=enable+1;
      end

    // always@(posedge clk_LED)
    //     begin
    //       if(reset==1)
    //         begin 
    //           pos_0<=TOP_0.INSTR_MEMORY_2.ct%10;
    //           pos_1<=(TOP_0.INSTR_MEMORY_2.ct/10)%10;
    //           pos_2<=(TOP_0.INSTR_MEMORY_2.ct/100)%10;
    //           pos_3<=0;
    //         end
    //       else
    //         begin
    //           pos_0<=TOP_0.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[18]%10;
    //           pos_1<=(TOP_0.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[18]/10)%10;
    //           pos_2<=(TOP_0.MIPS_1.DATAPATH_3.REGISTER_FILE_10.register_file[18]/100)%10;
    //           pos_3<=0;
              
    //           pos_4<=TOP_0.MIPS_1.pc%10;
    //           pos_5<=(TOP_0.MIPS_1.pc/10)%10;
    //           pos_6<=(TOP_0.MIPS_1.pc/100)%10;
    //           pos_7<=0;
    //         end
    //       case(enable)
    //         2'b000:begin an<=8'b1111_1110; LED<=pos_0_LED; end
    //         2'b001:begin an<=8'b1111_1101; LED<=pos_1_LED; end
    //         2'b010:begin an<=8'b1111_1011; LED<=pos_2_LED; end
    //         2'b010:begin an<=8'b1111_0111; LED<=pos_3_LED; end
            
    //         2'b011:begin an<=8'b1110_1111; LED<=pos_4_LED; end
    //         2'b100:begin an<=8'b1101_1111; LED<=pos_5_LED; end
    //         2'b101:begin an<=8'b1011_1111; LED<=pos_6_LED; end
    //         2'b110:begin an<=8'b0111_1111; LED<=pos_7_LED; end
    //         default enable<=0;
    //       endcase
    //       enable<=enable+1;
    //     end

endmodule
