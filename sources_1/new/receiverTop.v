`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 03:04:54 PM
// Design Name: 
// Module Name: receiverTop
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


module receiverTop(clk, baud, reset,RsRx, numRx, rxDataRdy,vgaBlue, vgaRed, vgaGreen, Hsync, Vsync);
    input clk;
    input baud;
    input reset;
    input RsRx;
    output [7:0] numRx; 
    output rxDataRdy;
    output [3:0] vgaBlue;
    output [3:0] vgaRed;
    output [3:0] vgaGreen;
    output Hsync;
    output Vsync;
    
    wire ramBusy;
    wire [7:0] addr;
    wire [7:0] mem;
    
    uart_rx(baud, reset, RsRx, rxDataRdy, numRx);
    
    DataStorage(clk, reset, numRx, rxDataRdy, addr, mem, ramBusy);
    
    VGA_Block(addr, mem, clk, reset, Hsync, Vsync, vgaBlue, vgaRed, vgaGreen, ramBusy);
    
endmodule
