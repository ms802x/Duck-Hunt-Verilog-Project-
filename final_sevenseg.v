`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: KAUST
// Engineer: ALI ALHEJAB & ABDURAUF ABDURAKHMANOV
// 
// Create Date: 12/01/2022 07:16:03 PM
// Design Name: 
// Module Name: sevenseg
// Project Name: 
// Target Devices: Nexys A7 100T
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


module sevenseg(
    input [3:0] num,
    output a,b,c,d,e,f,g
    
);
    wire[6:0] segment ;
// the seven segments code from HW 1, is a decoder. 
    assign segment = (num == 4'h0) ? 7'h01: 
                     (num == 4'h1) ? 7'h4f:
                     (num == 4'h2) ? 7'h12:
                     (num == 4'h3) ? 7'h06:
                     (num == 4'h4) ? 7'h4c:
                     (num == 4'h5) ? 7'h24:
                     (num == 4'h6) ? 7'h20:
                     (num == 4'h7) ? 7'h0f:
                     (num == 4'h8) ? 7'h00:
                     (num == 4'h9) ? 7'h04:
                     (num == 4'ha) ? 7'h08:
                     (num == 4'hb) ? 7'h60:
                     (num == 4'hc) ? 7'h31:
                     (num == 4'hd) ? 7'h42:
                     (num == 4'he) ? 7'h60:
                     (num == 4'hf) ? 7'h70: 7'h70;
                     
                     assign a= segment[6];
                     assign b= segment[5];
                     assign c= segment[4];
                     assign d= segment[3];
                     assign e= segment[2];
                     assign f= segment[1];
                     assign g= segment[0];
endmodule
