`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 06:35:59 PM
// Design Name: 
// Module Name: FlipFlopDebouncer
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


module FlipFlopDebouncer(
    output reg D,
    input rawD,
    input clk
    );
    
    wire mid1, mid2;
    
    DFlipFlop df1(.q(mid1),.clock(clk),.nreset(1),.d(rawD));
    DFlipFlop df2(.q(mid2),.clock(clk),.nreset(1),.d(mid1));
    
    reg [19:0] counter;
    initial begin
        counter <= 0;
    end
    
    always @(posedge clk) begin
        counter <= counter+1;
        if(counter == 0) begin
            D <= mid2;
        end
    end
    
endmodule
