`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2022 03:40:29 PM
// Design Name: 
// Module Name: pos_logic
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


module pos_logic(input clk_slw, rst,
    input  [3:0]dir_but, // direction button as 0-left, 1-up, 2-right, 3-down
    output reg [10:0] sniper_x = 11'd640, sniper_y = 11'd400
    );
    // this module work on 60 Hz 
    always @(posedge clk_slw)
    begin
    if (rst)
    begin
        sniper_x <= 11'd640;
        sniper_y <= 11'd400;
    end
    else
        begin
        case(dir_but) // it decides the direction the aim will go to based on the dir_but 
        4'b0001: begin //down
                 if(sniper_y <  11'd765)
                 sniper_y <= sniper_y + 2'b11;
                 end
        4'b0010: begin //right
                 if(sniper_x <  11'd1249)
                 sniper_x <= sniper_x + 2'b11;
                 end
        4'b0100: begin //up
                 if(sniper_y >  11'd10)
                 sniper_y <= sniper_y - 2'b11;
                 end
        4'b1000: begin //down
                 if(sniper_x >  11'd10)
                 sniper_x <= sniper_x - 2'b11;
                 end
        4'b0011: begin //down and right
                 if((sniper_x <  11'd1249) && (sniper_y < 11'd765)) begin
                 sniper_y <= sniper_y + 2'b11;
                 sniper_x <= sniper_x + 2'b11;
                 end
                 end
        4'b0110: begin //up and right
                 if((sniper_x < 11'd1249) && (sniper_y > 11'd10)) begin
                 sniper_y <= sniper_y - 2'b11;
                 sniper_x <= sniper_x + 2'b11;
                 end
                 end
        4'b1100: begin //up and left
                 if((sniper_x >  11'd10) && (sniper_y >  11'd10)) begin
                 sniper_y <= sniper_y - 2'b11;
                 sniper_x <= sniper_x - 2'b11;
                 end
                 end
        4'b1001: begin //down and left
                 if((sniper_x >  11'd10) && (sniper_y <  11'd765)) begin
                 sniper_y <= sniper_y + 2'b11;
                 sniper_x <= sniper_x - 2'b11;
                 end
                 end
        default: begin //down
                 sniper_y <= sniper_y;
                 sniper_x <= sniper_x;
                 end
        endcase
            
        end
         
end
endmodule
