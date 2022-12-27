`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2022 02:32:37 PM
// Design Name: 
// Module Name: vga_out
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

//Output pixels 
module vga_out(
    input clk, 
    input rst,
    input [3:0] draw_r, draw_g, draw_b,
    output reg [3:0] pix_r, pix_g, pix_b,
    output reg vsync, hsync,
    output reg [10:0] cur_x, cur_y
    );
    reg [10:0]hcount = 11'd0;
    reg [9:0]vcount = 10'd0;
    // operates on 83Mhz 
    always@(posedge clk)
    begin
    if(rst)begin
        hcount <= 11'd0; // the count horzintal and vertical of the
        vcount <= 10'd0; // this counts vertically 
        end
    else 
    begin
        if(hcount == 11'd1679) // last addressanle range
            begin
            hcount <= 11'd0; //reset 
            if(vcount == 827)
                begin
                vcount <= 10'd0; // reset
                end
            else
                begin
                if(vcount < 10'd3) // from the gitlab page
                    vsync <= 1'b1; // set Vsync to indicate new rew 
                else
                    vsync <= 1'b0;
                vcount <= vcount + 1'b1;
                end
            end
        else
            begin
            hcount <= hcount + 1'b1;
            if(hcount < 11'd136)
            begin
                hsync <= 1'b0; // set hsync to indicate new coulmn
            end
            else
                hsync <= 1'b1;
            end
        end
        if((11'd335 < hcount) && (hcount < 11'd1616) && (11'd26 < vcount) && (vcount < 11'd827))
        begin
            cur_x <= hcount - 11'd336; //offset counter for visible part of screen
            cur_y <= vcount - 11'd27;
            pix_r <= draw_r;
            pix_b <= draw_b;
            pix_g <= draw_g;
        end    
        else
            begin
            cur_x <= 11'd0;
            cur_y <= 11'd0;
            pix_r <= 4'h0;
            pix_b <= 4'h0;
            pix_g <= 4'h0;
            end
        
    end
endmodule
