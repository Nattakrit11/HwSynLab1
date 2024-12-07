`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 06:35:59 PM
// Design Name: 
// Module Name: SinglePulser
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


module SinglePulser(
    output reg Q,
    input rawD,
    input clk
    );
    
    FlipFlopDebouncer DB(.D(D), .rawD(rawD), .clk(clk));

    reg state;
    
    initial begin
        Q<=0;
        state<=0;
    end
    
    always @(posedge clk) begin
        case(D)
            0: begin
                Q<=0;
                state<=0;
            end
            1: begin
                Q <= ~state;
                state<=1;
            end
        endcase
    end
    
endmodule
