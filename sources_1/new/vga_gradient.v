`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 06:27:51 PM
// Design Name: 
// Module Name: vga_gradient
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


module vga_gradient(
        output reg [11:0] rgb_reg,
        output [7:0] addr,
        input [7:0] mem,
        input p_tick,
        input [9:0] x,
        input [9:0] y,
        input clk
    );
        localparam WIDTH = 640;
        localparam HEIGHT = 480;
        
        //draw logic
        always @(posedge clk) begin
            if(p_tick == 1) begin
                //rgb reg is 12 bits with 4 bits each to BRG
                //for now, temporarily assign 0 to rgb_reg (all black screen)
                rgb_reg <= 0;
            end
        end
endmodule
