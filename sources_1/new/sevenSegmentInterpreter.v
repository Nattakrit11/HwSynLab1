`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 11:20:50 PM
// Design Name: 
// Module Name: sevenSegmentInterpreter
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


module sevenSegmentInterpreter(
    input clk,
    input reset,
    input txDataReady,
    input rxDataReady,
    input [7:0] numTx,
    input [7:0] numRx,
    output [6:0] seg,
    output [3:0] an,
    output dp
    );
    
    reg [3:0] num3,num2,num1,num0; // left to right
    
    wire an0,an1,an2,an3;
    assign an={an3,an2,an1,an0};
    
    ////////////////////////////////////////
    // Clock
    wire targetClk;
    wire [18:0] tclk;
    
    assign tclk[0]=clk;
    
    genvar c;
    generate for(c=0;c<18;c=c+1) begin
        clockDiv fDiv(tclk[c+1],tclk[c]);
    end endgenerate
    
    clockDiv fdivTarget(targetClk,tclk[18]);
    
    ////////////////////////////////////////
    // Display
    quadSevenSeg q7seg(seg,dp,an0,an1,an2,an3,num0,num1,num2,num3,targetClk);
    
    ////////////////////////////////////////
    
    always @(posedge targetClk)
    begin
        if(reset)
            {num3, num2, num1, num0} <= 0;
        else
            if(txDataReady)
                {num3, num2} <= numTx;
            if(rxDataReady)
                {num1, num0} <= numRx;
    end
    
endmodule
