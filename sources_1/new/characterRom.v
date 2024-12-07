`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 01:47:53 AM
// Design Name: 
// Module Name: characterRom
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


module characterRom(
    input wire [10:0] addr,
    output wire [7:0] data
    );
    
    //input: charId + y-axis
    //output: 8x1 bitmap line
    reg [7:0] rom[0:1023];
    
    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1) begin
            rom[i] = 8'b00000000;  // Default value
        end
        $readmemb("rom.data", rom);
    end
    assign data = rom[addr];
    
endmodule
