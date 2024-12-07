`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 06:35:59 PM
// Design Name: 
// Module Name: DFlipFlop
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


module DFlipFlop(
    output reg q,
    input d,
    input nreset,
    input clock 
    );
    
    initial begin
        q<=0;
    end
    
    always @(posedge clock or negedge nreset) begin
        if (nreset == 0) begin
            q<=0;
        end else begin
            q<=d;
        end
    end
    
endmodule
