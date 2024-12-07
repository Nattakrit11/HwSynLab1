`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 12:38:02 PM
// Design Name: 
// Module Name: system
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


module system(
    //clk
    input clk,
    //seven segment
    output [6:0] seg,
    output [3:0] an,
    output dp,
    //button
    input btnC,
    //VGA connector
    output [3:0] vgaBlue,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output Hsync,
    output Vsync,
    //USB-RS232 interface
    input RsRx,
    output RsTx,
    //USB-HID (PS/2) interface
    input PS2Clk,
    input PS2Data,
    //input switches and reset switch
    input [8:0] sw
    );
    wire txDataRdy, rxDataRdy;
    wire [7:0] numTx;
    wire [7:0] numRx;
    wire reset;
    
    assign reset = sw[8];
    
    baudrate_gen(clk, baud);
    
    senderTop(clk, baud, reset,
              btnC, sw[7:0],
              PS2Clk, PS2Data,
              RsTx, numTx, txDataRdy);
              
    receiverTop(clk, baud, reset,
                RsRx, numRx, rxDataRdy,
                vgaBlue, vgaRed, vgaGreen, Hsync, Vsync);
                
    sevenSegmentInterpreter(clk, reset,
                            txDataRdy, rxDataRdy, 
                            numTx, numRx,
                            seg, an, dp);
    
endmodule
