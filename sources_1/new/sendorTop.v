`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 01:31:14 PM
// Design Name: 
// Module Name: senderTop
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


module senderTop(
    input clk,
    input baud,
    input reset,
    input btnC,
    input [7:0] sw,
    input PS2Clk,
    input PS2Data,
    output RsTx,
    output reg [7:0] numTx,
    output reg txDataRdy
    );
    wire [7:0] keyboardData;
    wire keyboardDataRdy;
    wire [7:0] btnData;
    wire btnDataRdy;
    wire [7:0] data;
    wire send;
    wire txSent;
    
    ReceiveUSB(clk, reset, PS2Clk, PS2Data, keyboardDataRdy, keyboardData);
    ReceiveBtn(clk, reset, btnC, sw, btnDataRdy, btnData);
    
    DataManager(clk, reset, btnDataRdy, btnData, keyboardDataRdy, keyboardData, data, send);
    
    uart_tx(baud, data, send, txSent, RsTx);
    
    always @(posedge clk)
    begin
        if(send) begin
            numTx <= data;
            txDataRdy <= 1;
        end
        else
        begin
            numTx <= 0;
            txDataRdy <= 0;
        end
    end
    
endmodule
