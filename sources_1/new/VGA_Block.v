`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 05:18:02 PM
// Design Name: 
// Module Name: VGA_Block
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


module VGA_Block(
    output [7:0]addr,
    input [7:0] mem,
    input clk,
    input reset,
    output wire hsync, vsync,
	output wire [3:0] vgaBlue,
	output wire [3:0] vgaRed,
	output wire [3:0] vgaGreen,
	input ramBusy
    );
    
    wire p_tick;
	wire [9:0] x,y;
	
	// basys rgb stuff
	wire [11:0] rgb_reg;
	
	// video status output from vga_sync to tell when to route out rgb signal to DAC
	wire video_on;

    // instantiate vga_sync
    vga_sync vga_sync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
                                .video_on(video_on), .p_tick(p_tick), .x(x), .y(y));
   
    //  rgb buffer
    vga_text vga_text_unit(rgb_reg,addr,mem,p_tick,x,y,clk, ramBusy);
        
    // output
    assign {vgaBlue, vgaRed, vgaGreen} = (video_on) ? rgb_reg : 12'b0;
endmodule
