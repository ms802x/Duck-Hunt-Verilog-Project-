`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2022 06:36:34 PM
// Design Name: 
// Module Name: drawcon
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


module drawcon(
input [10:0] sniper_x, sniper_y, blkpos_x, blkpos_y, draw_x, draw_y, 
input flag_shoot, flag,
input [1:0] press_count,
input [11:0] douta_tree, douta_cloud, douta_sun, douta_grass, douta_dog, douta_gun, douta_game_over, douta_aim, 
douta_duck_up, douta_bullet, douta_bullet2, douta_bullet3,
output reg [3:0] r, g, b
    );
reg [3:0] bg_b, bg_g, bg_r;
reg [3:0] blk_b, blk_g, blk_r; 

always@*
begin 
            // to draw wall on the edge
     if((((11'd0 <= draw_x) && (draw_x < 11'd10)) || ((11'd0<= draw_y) && (draw_y<11'd10))) 
     || (((draw_x>=11'd1268) && (draw_x <= 11'd1278)) || ((11'd789<= draw_y) && (draw_y<11'd799)))) 
        begin 
            bg_r = 4'hf;
            bg_g = 4'h0;
            bg_b = 4'h0;
        end
     else
        begin  
            if(draw_y > 11'd670) //condition to separate the background - for ground brown 
            begin
            bg_r = 4'h9;
            bg_g = 4'h6;
            bg_b = 4'h0;
            end
            else
            begin
                if(draw_y > 11'd609) // for grass green
                begin
                    bg_r = 4'h9;
                    bg_g = 4'hc;
                    bg_b = 4'h0;
                end
                else
                if((press_count == 2'd3) && ~ flag_shoot) // if game is finished pink color on the sky
                begin
                    if(flag) begin //if user won
                        bg_r = 4'hc;
                        bg_g = 4'hf;
                        bg_b = 4'h0;
                    end
                    else begin //if user lost
                        bg_r = 4'hc;
                        bg_g = 4'h0;
                        bg_b = 4'ha;
                    end
                end
                else begin  // for sky blue
                    bg_r = 4'h0;
                    bg_g = 4'ha;
                    bg_b = 4'he;
                end
            end
        end
end

always@*
begin
        r = bg_r;
        g = bg_g;
        b = bg_b;
         
//code to draw tree on the screen
    if((draw_x > 11'd100) && (draw_x < 11'd395) && (draw_y > 11'd168) &&  (draw_y < 11'd602))
    begin
    if(douta_tree == 12'h0ae) begin
            r = r;
            g = g;
            b = b;
        end
        else begin
            r = douta_tree[11:8];
            g = douta_tree[7:4];
            b = douta_tree[3:0];
    end 
    end
    
   if((draw_x > 11'd362) &&  (draw_x < 11'd543) && (draw_y > 11'd30) &&  (draw_y < 11'd159))
      begin
        if(douta_cloud == 12'h000) begin
            r = r;
            g = g;
            b = b;
            end
        else begin
            r = douta_cloud[11:8];
            g = douta_cloud[7:4];
            b = douta_cloud[3:0];
        end 
        end
    //to draw sun on the screen
    if((press_count == 2'd3) && (draw_x > 11'd522) && (draw_x < 11'd779) && (draw_y > 11'd300) && (draw_y < 11'd429))
    begin
        if(douta_game_over == 12'h000) begin
            r = r;
            g = g;
            b = b;
        end
        else begin
            r = douta_game_over[11:8];
            g = douta_game_over[7:4];
            b = douta_game_over[3:0];
    end 
    end
    // to draw the sun 
    if((draw_x > 11'd1000) && (draw_x < 11'd1114) && (draw_y > 11'd30) &&  (draw_y < 11'd146))
    begin
        if(douta_sun == 12'h0ae) begin
            r = r;
            g = g;
            b = b;
        end
        else begin
            r = douta_sun[11:8];
            g = douta_sun[7:4];
            b = douta_sun[3:0];
    end 
    end
    if((draw_x > 11'd10) &&  (draw_x < 11'd1269) && (draw_y > 11'd590) &&  (draw_y < 11'd610))
    begin
        r = douta_grass[11:8];
        g = douta_grass[7:4];
        b = douta_grass[3:0];
    end 
    // for bullet 
    if((draw_x > 11'd103) &&  (draw_x < 11'd120) && (draw_y > 11'd700) &&  (draw_y < 11'd733))
     begin
        r = douta_bullet[11:8];
        g = douta_bullet[7:4];
        b = douta_bullet[3:0];
    end 
    // for bullet
    if((draw_x > 11'd123) &&  (draw_x < 11'd140) && (draw_y > 11'd700) &&  (draw_y < 11'd733))
     begin
        r = douta_bullet2[11:8];
        g = douta_bullet2[7:4];
        b = douta_bullet2[3:0];
    end 
    // for bullet 
    if((draw_x > 11'd143) &&  (draw_x < 11'd160) && (draw_y > 11'd700) &&  (draw_y < 11'd733))
     begin
        r = douta_bullet3[11:8];
        g = douta_bullet3[7:4];
        b = douta_bullet3[3:0];
    end 
    
    // to draw a dog    
    if((draw_x > 11'd802) &&  (draw_x < 11'd923) && (draw_y > 11'd510) &&  (draw_y < 11'd591))
    begin
        if(douta_dog == 12'h0ae) begin
           r = r;
           g = g;
           b = b;
           end
        else begin
           r = douta_dog[11:8];
           g = douta_dog[7:4];
           b = douta_dog[3:0];
    end 
    end
    // to draw empty bullet set 
    if((press_count == 2'd3) && ~flag_shoot)
            begin
            r = r;
            g = g;
            b = b;
            end
    else begin 
        // for the duck drawing 
        if((draw_x > blkpos_x) &&  (draw_x < blkpos_x + 11'd71) &&(draw_y > blkpos_y) &&  (draw_y < blkpos_y + 11'd54)) //for moving pixels
        begin
        if(douta_duck_up == 12'h000) begin
            r = r;
            g = g;
            b = b;
            end
        else begin
            r = douta_duck_up[11:8];
            g = douta_duck_up[7:4];
            b = douta_duck_up[3:0];
             end
        end
    end  
    // for the aim drawing 
    if((draw_x > sniper_x + 4'd2) && (draw_x < sniper_x + 11'd28) && (draw_y > sniper_y) && (draw_y < sniper_y + 11'd26))
    begin
       if(douta_aim == 12'hfff) begin
        r = r;
        g = g;
        b = b;
        end
        else
        begin
        r = douta_aim[11:8];
        g = douta_aim[7:4];
        b = douta_aim[3:0];
        end
    end
    // for the gun drawing
    if((draw_x > 11'd602) &&  (draw_x < 11'd667) && (draw_y > 11'd660) &&  (draw_y < 11'd789))
    begin
        if((douta_gun == 12'h000) || (douta_gun == 12'hfff)) begin
        r = r;
        g = g;
        b = b;
        end
        else
        begin
        r = douta_gun[11:8];
        g = douta_gun[7:4];
        b = douta_gun[3:0];
        end
   end

end
//end
endmodule
