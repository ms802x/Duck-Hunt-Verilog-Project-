
module game_top(
    input clk0,
    input rst1,
    input [3:0] dir_but,
    input [2:0] speed,
    input b_shoot,
    output [3:0] pix_r, pix_g, pix_b,
    output vsync, hsync,
    output [7:0] segment,
    output a, b, c, d, e, f, g);

assign segment = 8'b11111110;  for which display is ON, logic low 
wire rst; // reset
wire [5:0] random_bits; // a wire that is assigned to the randomizae module
parameter [10:0] in_val = 11'd230; 
wire clk; //wire to connect clock
wire [10:0] cur_x, cur_y;  // current x and y values
wire [3:0]draw_r, draw_g, draw_b; 
reg  sign = 1'b1;  // sign to control the slope of the duck movment
//wire b_shoot;  // the shooting button 
reg temp = 1'd0;
reg flag_shoot = 1'b0; // this is a flag used to indicate the a duck was shot, it is setted by drawcon
//reg flag_duck = 1'd1; // to select between the two ducks 
reg [3:0] win_count = 4'd0;   // counts how many time we killed a duck.
reg [1:0] press_count = 2'd0; // bullet counter
reg [5:0] count = 6'd0;    
reg [10:0] up_bound = in_val - 10'd30, low_bound = in_val + 10'd30; // the upper boundary
reg [10:0] blkpos_x = 11'd10, blkpos_y = in_val; // the duck movment 
reg [16:0] addra_tree = 17'd0;
reg [12:0] addra_gun = 13'd0, addra_gun_flip = 13'd0;
reg [13:0] addra_sun = 14'd0, addra_dog = 14'd0;
reg [14:0] addra_game_over = 15'd0, addra_cloud = 15'd0;
reg [8:0] addra_grass = 9'd0, addra_bullet = 9'd0, addra_bullet2 = 9'd0, addra_bullet3 = 9'd0;
reg [9:0] addra_aim = 10'd0;
reg [11:0] addra_duck_up = 12'd0, addra_duck_down = 12'd0;
reg flag = 1'b0;  // this flag is used to indicate game wining, which mean the dog will apear. once we are out of bullets
reg count_flag = 1'b1; // flag to prevent button from being continsuly pressed
reg [11:0] select_duck;  // duck color selecter 
reg [11:0] select_gun, select_game_over; // selector but for gun
wire [7:0] duck_width = 8'd70, duck_height = 8'd53; 
wire [11:0] douta_tree, douta_sun, douta_grass, douta_gun, douta_gun_flip, douta_game_over, douta_cloud,
douta_dog, douta_aim, douta_duck_up, douta_duck_down, douta_bullet, douta_bullet2, douta_bullet3;
wire [10:0] sniper_x , sniper_y; // the aim position 
clock clock_inst(.clk(clk0), .rst(rst), .clk_slw(clk_slw)); // 60Hz clock slow
clk_wiz_0  clk_wiz1(// Clock in ports
  // Clock out ports
        clk1,clk0
 );

assign clk = clk1; //assigning clock output to our wire and connect to VGA_OUT
assign rst = ~rst1;
//assign addra_duck_up = duck_width*(cur_y - blkpos_y) + (cur_x - blkpos_x); //for moving block on the screen

//assign addra_duck_up = duck_width*(cur_y - 10'd100) + (cur_x - 11'd500); //tried for fixed sprite on the screen


randomizer random_number(clk,rst,random_bits);
 
vga_out vga_out1(clk, rst, draw_r, draw_g, draw_b, pix_r, pix_g, pix_b, vsync, hsync, cur_x, cur_y); 

pos_logic pl(clk_slw, rst, dir_but, sniper_x, sniper_y);

tree tree1(.clka(clk), .addra(addra_tree), .douta(douta_tree));

sun sun1(.clka(clk), .addra(addra_sun), .douta(douta_sun));

grass grass1(.clka(clk), .addra(addra_grass), .douta(douta_grass));

dog dog1(.clka(clk), .addra(addra_dog), .douta(douta_dog));

aim_r aim1(.clka(clk), .addra(addra_aim), .douta(douta_aim));

duck_up duck_up1(.clka(clk), .addra(addra_duck_up), .douta(douta_duck_up));

duck_down duck_down1(.clka(clk), .addra(addra_duck_down), .douta(douta_duck_down));

bullet bullet1(.clka(clk), .addra(addra_bullet), .douta(douta_bullet));

bullet bullet2(.clka(clk), .addra(addra_bullet2), .douta(douta_bullet2));

bullet bullet3(.clka(clk), .addra(addra_bullet3), .douta(douta_bullet3));

gun gun1(.clka(clk), .addra(addra_gun), .douta(douta_gun));

gun_flip gun_flip1(.clka(clk), .addra(addra_gun_flip), .douta(douta_gun_flip));

game_over game_over1(.clka(clk), .addra(addra_game_over), .douta(douta_game_over));

cloud cloud1(.clka(clk), .addra(addra_cloud), .douta(douta_cloud));

sevenseg sevenseg1(win_count, a, b, c, d, e, f, g );
// drawcon takes all the parameters to plot them 
drawcon drawcon1(sniper_x, sniper_y, blkpos_x, blkpos_y, cur_x, cur_y, flag_shoot, flag, press_count, douta_tree, douta_cloud, douta_sun, douta_grass, 
douta_dog, select_gun, select_game_over, douta_aim, select_duck, douta_bullet, douta_bullet2, douta_bullet3, draw_r, draw_g, draw_b);


// here the 83Mhz 
always@(posedge clk)
    begin
    if((count < 6'd32)) // to choose up or down duck
        select_duck <= douta_duck_up;
    else
        select_duck <= douta_duck_down;
    if((sniper_x < 11'd630)) // to choose gun
        select_gun <= douta_gun;
    else
        select_gun <= douta_gun_flip;
    if((count < 6'd32) && ((douta_game_over == 12'hed2) || (douta_game_over == 12'hed1)))
        select_game_over <= 12'h4c3;
    else
        select_game_over <= douta_game_over;
    if(rst)
    begin
    addra_dog = 14'd0;
    addra_tree = 17'd0;
    addra_sun = 14'd0;
    addra_grass = 9'd0;
    addra_aim = 10'd0;
    addra_bullet = 9'd0;
    addra_bullet2 = 9'd0;
    addra_bullet3 = 9'd0;
    addra_duck_up = 12'd0;
    addra_duck_down = 12'd0;
    addra_gun = 13'd0;
    addra_gun_flip = 13'd0;
    addra_game_over = 15'd0;
    addra_cloud =15'd0;
//    flag_duck = 1'd1;
    end
    else
        //tree sprite
    begin
    if((cur_x > 11'd98) &&  (cur_x < 11'd393) && (cur_y > 11'd168) &&  (cur_y < 11'd602))
         begin
            if (addra_tree == 17'd127301)
                addra_tree <= 17'd0;
            else
                addra_tree <= addra_tree + 1'd1;
     end
     //cloud sprite
     if((cur_x > 11'd360) &&  (cur_x < 11'd541) && (cur_y > 11'd30) &&  (cur_y < 11'd159))
         begin
            if (addra_cloud == 15'd23040)
                addra_cloud <= 15'd0;
            else
                addra_cloud <= 11'd180 * (cur_y - 8'd30) + (cur_x - 11'd360);
     end
     
     //sun sprite
     if((cur_x > 11'd998) &&  (cur_x < 11'd1112) && (cur_y > 11'd30) &&  (cur_y < 11'd146))
         begin
            if (addra_sun == 14'd12994)
                addra_sun <= 14'd0;
            else
                addra_sun <= addra_sun + 1'd1;
         end
     //grass sprite like a movement
     if((cur_x > 11'd8) &&  (cur_x < 11'd1266) && (cur_y > 11'd590) &&  (cur_y < 11'd610))
       begin
       if (addra_grass == 9'd401)
           addra_grass <= 9'd0;
       else
           addra_grass <= addra_grass + 1'd1;
       end
     //dog appearing mecahnism, the dog will appear if flag_shoot && flag are true which mean the duck was shot 
       if((cur_x > 11'd800) && (cur_x < 11'd921) && (cur_y > 11'd510) && (cur_y < 11'd591))
       begin
        if(flag_shoot && flag) begin
            if (addra_dog == 14'd9599)
                addra_dog <= 14'd0;
            else
//                addra_dog <= addra_dog + 1'd1;
                addra_dog <= 8'd120*(cur_y - 11'd510) + (cur_x - 11'd801);
        end
        else
            addra_dog <= 14'd0; // assign first address which is the same as background
     end
     if((cur_x > sniper_x) &&  (cur_x < sniper_x + 5'd26) && (cur_y > sniper_y) &&  (cur_y < sniper_y + 5'd26))
         begin
            if (addra_aim == 10'd624)
                addra_aim <= 10'd0;
            else
//                addra_aim <= addra_aim + 1'd1;
                addra_aim <= 8'd25*(cur_y - sniper_y) + (cur_x - sniper_x);
     end
     // gun sprite
     if((cur_x > 11'd600) &&  (cur_x < 11'd665) && (cur_y > 11'd660) && (cur_y < 11'd789))
         begin
            if (addra_gun == 13'd8191)
                addra_gun <= 13'd0;
            else
//                addra_gun <= addra_gun + 1'd1;
                addra_gun <= 9'd64*(cur_y - 11'd660) + (cur_x - 11'd600);
     end
     if((cur_x > 11'd600) &&  (cur_x < 11'd665) && (cur_y > 11'd660) && (cur_y < 11'd789))
         begin // gun flipping sprite
            if (addra_gun_flip == 13'd8191)
                addra_gun_flip <= 13'd0;
            else
//                addra_gun <= addra_gun + 1'd1;
                addra_gun_flip <= 9'd64*(cur_y - 11'd660) + (cur_x - 11'd600);
     end
     // gameover text
     if((cur_x > 11'd520) && (cur_x < 11'd777) && (cur_y > 11'd300) && (cur_y < 11'd429))
         begin
            if (addra_game_over == 15'd32767)
                addra_game_over <= 15'd0;
            else
//                addra_gun <= addra_gun + 1'd1;
                addra_game_over <= 11'd256*(cur_y - 11'd300) + (cur_x - 11'd520);
     end
     // duck mover 
     if((cur_x > blkpos_x) &&  (cur_x < blkpos_x + 11'd71) &&(cur_y > blkpos_y) &&  (cur_y < blkpos_y + 11'd54))
    begin
//        if(flag_duck) begin
        if(count < 6'd32) begin
            if (addra_duck_up == 12'd3709) begin 
//                flag_duck <=1'd0;
                addra_duck_up <= 12'd0;
                end 
            else
    //            addra_duck_up <= addra_duck_up + 1'd1;
                addra_duck_up <= duck_width*(cur_y - blkpos_y) + (cur_x - blkpos_x);
            end 
        else begin 
             if (addra_duck_down == 12'd3709) begin 
//                flag_duck <=1'd1;
                addra_duck_down <= 12'd0;
                end 
            else
    //            addra_duck_up <= addra_duck_up + 1'd1;
                addra_duck_down <= duck_width*(cur_y - blkpos_y) + (cur_x - blkpos_x);
            end 
    end
    
    if((cur_x > 11'd100) &&  (cur_x < 11'd117) && (cur_y > 11'd700) &&  (cur_y < 11'd733))
         begin
            if (press_count > 2'd2) //(addra_bullet == 9'd511)
                addra_bullet <= 9'd0;
            else
//                addra_bullet <= addra_bullet + 1'd1;
                  addra_bullet <= 8'd16*(cur_y - 11'd700) + (cur_x - 11'd101);
         end
     if((cur_x > 11'd120) &&  (cur_x < 11'd137) && (cur_y > 11'd700) &&  (cur_y < 11'd733))
         begin
            if (press_count > 2'd1)//(addra_bullet2 == 9'd511)
                addra_bullet2 <= 9'd0;
            else
                addra_bullet2 <= 8'd16*(cur_y - 11'd700) + (cur_x - 11'd121);
         end
      if((cur_x > 11'd140) &&  (cur_x < 11'd157) && (cur_y > 11'd700) &&  (cur_y < 11'd733))
         begin
            if (press_count > 2'd0)//(addra_bullet3 == 9'd511)
                addra_bullet3 <= 9'd0;
            else
//                addra_bullet3 <= addra_bullet3 + 1'd1;
                  addra_bullet3 <= 8'd16*(cur_y - 11'd700) + (cur_x - 11'd141);
         end
end //rst else's end
end // always block end
    

always@(posedge clk_slw)
    begin
    if(rst) begin   
        blkpos_x <= 11'd10;
        blkpos_y <= in_val;
        flag_shoot <= 1'b0;
        flag <= 1'd0;
        count <= 6'd0;
        press_count <= 2'd0;
        win_count <= 4'd0;
        end
    else 
        begin
        count <= count + 1'd1; //counter for delay of duck movement
        //to count bullets, count flag prevent the condition from being always true 
        if((b_shoot && count_flag && ~flag_shoot)) begin   
            press_count <= press_count + 1'd1;
            count_flag <= 1'd0;
        end
        else
            if (b_shoot == 1'd0)
                count_flag <= 1'd1;
         //shooting condition
        if(press_count == 1'd0)
            win_count <= 4'd0;
        if(b_shoot && ~flag_shoot && (blkpos_x - 11'd25 < sniper_x) && (blkpos_x + 11'd40 > sniper_x) &&
        (blkpos_y - 11'd20 < sniper_y) && (blkpos_y + 11'd40 > sniper_y))
            begin
                win_count <= win_count + 1'd1;
                flag_shoot <= 1'b1;
            end
      
        if(win_count > 4'd1)
            flag <= 1'd1;
        else
            flag <= 1'd0;
//                win_count <= 4'd0;
        // duck movement if not shot
        if(~flag_shoot) begin    
            if(blkpos_x < 11'd1200) // to check if block did not leave the screen
            begin
                blkpos_x <= blkpos_x + speed + 3'b11; //to move block to right by defined pixels
                if (blkpos_y <= up_bound)
                    sign <= 1'b1;
                if (blkpos_y >= low_bound + speed)
                    sign <= 1'b0;
                if(sign)
                    blkpos_y <= blkpos_y + 1'd1;
                else
                    blkpos_y <= blkpos_y - 1'd1; 
//                end                    
            end    
            else begin
            blkpos_x <= 11'd10;
            blkpos_y <= random_bits[3:0] * 11'd25;
            up_bound <= (random_bits[3:0] * 11'd25 - 11'd30);
            low_bound <= (random_bits[3:0] * 11'd25 + 11'd30);
            end
            end
            else begin      //if duck was shot and to fall down
            if(blkpos_y < 11'd600) begin //if did not hit ground 
                blkpos_y <= blkpos_y + 3'b101;
                blkpos_x <= blkpos_x;
                end
            else begin
                flag_shoot <= 1'b0;
                blkpos_x <= 11'd10;
                blkpos_y <= random_bits[3:0] * 11'd25;
                up_bound <= (random_bits[3:0] * 11'd25 - 11'd30);
                low_bound <= (random_bits[3:0] * 11'd25 + 11'd30 + speed*2'd2);
                end
            end
        end
    end
endmodule
