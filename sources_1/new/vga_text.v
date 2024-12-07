`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 08:15:53 PM
// Design Name: 
// Module Name: vga_text
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


module vga_text(
        output reg [11:0] rgb_reg,
        output [7:0] addr,
        input [7:0] mem,
        input p_tick,
        input [9:0] x,
        input [9:0] y,
        input clk,
        input ramBusy
    );
    
    assign addr = {y[5:3], x[7:3]};
    
    wire [7:0]val;
    characterRom cr({mem[6:0], y[2:0]}, val);
    
    wire vgaWhite;
    assign vgaWhite = 12'b111111111111;
    
    //receive x and y for pixel position, use addr to get mem for what ASCII character should be on display
    //and then respond with RGB values for that particular pixel
    //draw logic
    always @(posedge clk) begin
        if(p_tick == 1) begin
            //rgb reg is 12 bits with 4 bits each to BRG
            //for now, temporarily assign 0 to rgb_reg (all black screen)
            rgb_reg <= ramBusy ? 0 : val[x[2:0]] * vgaWhite;
        end
    end
    
    
endmodule
