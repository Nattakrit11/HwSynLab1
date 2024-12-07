`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 01:55:08 PM
// Design Name: 
// Module Name: ReceiveBtn
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


module ReceiveBtn(
    input clk,
    input reset,
    input btnC,
    input [7:0] sw,
    output btnDataRdy,
    output [7:0] btnData
    );
    
    assign btnData = sw;
    
    SinglePulser(.Q(btnDataRdy), .rawD(btnC), .clk(clk));
    
endmodule
