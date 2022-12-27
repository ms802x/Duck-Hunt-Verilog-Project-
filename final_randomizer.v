`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2022 09:00:56 PM
// Design Name: 
// Module Name: randomizer
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

module randomizer(
    input clk0,
    input rst,
    output reg [3:0] random_bits = 4'hf 
    );
   
// the is line is the xor gate, which means we have only one mask 
wire feedback = random_bits[4] ^ random_bits[1] ;

    always @(posedge clk0)
    begin
    if (rst) 
      // if reset we get f 
        random_bits <= 4'hf;
    else
      // else we get a 5 bits number shifted by feedback bit 
        random_bits <= {random_bits[3:0], feedback} ;
    end
endmodule
