`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 02:37:54 PM
// Design Name: 
// Module Name: DataManager
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


module DataManager(clk, reset, btnDataRdy, btnData, keyboardDataRdy, keyboardData, data, send);
input clk;
input reset;
input btnDataRdy;
input [7:0] btnData;
input keyboardDataRdy;
input [7:0] keyboardData;
output reg [7:0] data;
output reg send;

wire [7:0] charData;
wire charDataRdy;
KeyboardTranslate(clk, reset, keyboardData, keyboardDataRdy, charData, charDataRdy);

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        data <= 0;
        send <= 0;
    end
    else
    begin
        if(charDataRdy)
        begin
            data <= charData;
            send <= 1;
        end
        else if(btnDataRdy)
        begin
            data <= btnData;
            send <= 1;
        end
        else
            send <= 0;
    end
end

endmodule
