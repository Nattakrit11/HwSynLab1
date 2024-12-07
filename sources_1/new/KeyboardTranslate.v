`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 04:18:10 PM
// Design Name: 
// Module Name: KeyboardTranslate
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


module KeyboardTranslate(
    input clk,
    input reset,
    input [7:0] sc,
    input kbDataRdy,
    output reg [7:0] asciiData,
    output reg asciiDataRdy
    );
    
    reg shift = 0;
    reg capslock = 0;
    reg releasing = 0;
    reg [7:0]heldKey = 0;
    
    wire [7:0] ascii;
    
    PS2ScanToAscii(
        .sc(sc), .shift(shift), .capslock(capslock), .ascii(ascii)    
    );
    
    always @(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            shift <= 0;
            capslock <= 0;
            releasing <= 0;
            heldKey <= 0;
            asciiData <= 0;
            asciiDataRdy <= 0;
        end
        else if(kbDataRdy)
        begin
            case(sc)
                //special keys
                8'h12: begin
                    shift <= ~releasing; // LSHIFT
                    asciiDataRdy <= 0;
                end
                8'h59: begin
                    shift <= ~releasing; // RSHIFT
                    asciiDataRdy <= 0;
                end
                6'h58: begin
                    capslock <= ~(~releasing&&capslock); //CAPSLOCK
                    asciiDataRdy <= 0;
                end
                //normal keys
                default: begin
                    asciiData <= ascii;
                    if(releasing && heldKey == ascii) begin
                        releasing <= 0;
                        heldKey <= 0;
                        asciiDataRdy <= 0;
                    end
                    else begin
                        heldKey <= ascii;
                        asciiData <= ascii;
                        asciiDataRdy <= (ascii != heldKey);
                    end
                end
            endcase
        end
    end
    
endmodule
