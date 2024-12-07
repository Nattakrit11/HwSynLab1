`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 02:11:29 PM
// Design Name: 
// Module Name: ReceiveUSB
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


module ReceiveUSB(
    input clk,
    input reset,
    input PS2Clk,
    input PS2Data,
    output reg keyboardDataRdy,
    output reg [7:0] keyboardData
    );
    
    wire mid1, mid2;
    
    DFlipFlop d1(mid1, PS2Clk, reset, clk);
    DFlipFlop d2(mid2, mid1, reset, clk);
    
    reg [1:0] state;
    reg [10:0] kbreg;
    reg [3:0] bit_count;
    reg PS2Clk_prev = 1;
    reg PS2Clk_sync = 1;
    
    always @(posedge clk or posedge reset) begin
        PS2Clk_prev <= PS2Clk_sync;
        if (reset) begin
            PS2Clk_sync <= 1'b1;
        end else begin
            PS2Clk_sync <= mid2;
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            kbreg <= 0;
            bit_count <= 0;
            keyboardDataRdy <= 0;
            keyboardData <= 0;
        end
        else begin
            case (state)
                0: begin //idle or start position
                    keyboardDataRdy <= 0;
                    if(PS2Clk_sync == 0 && PS2Clk_prev == 1) //falling edge, begin rx
                    begin
                        state <= 1;
                        bit_count <= bit_count+1;
                        kbreg[bit_count] <= PS2Data;
                    end
                    else
                    begin
                        bit_count <= 0;
                    end
                end
                1: begin //during rx
                    if(PS2Clk_sync == 0 && PS2Clk_prev == 1) //falling edge, continue rx
                    begin
                        bit_count <= bit_count + 1;
                        kbreg[bit_count] <= PS2Data;
                        if(bit_count == 10) begin
                            state <= 2;
                        end
                    end
                end
                2: begin //done
                    if (kbreg[0] == 0 && kbreg[10] == 1 //start and stop bits
                    && (^kbreg[9:1] == 1)) //parity check
                    begin
                        keyboardData <= kbreg[8:1];  // Extract 8 data bits
                        keyboardDataRdy <= 1;              // Indicate valid data
                    end
                    state <= 0;  // Return to idle state
                end
                3: begin //unused, reset state machine
                    state <= 0;
                    kbreg <= 0;
                    bit_count <= 0;
                    keyboardDataRdy <= 0;
                    keyboardData <= 0;
                end
            endcase
        end
    end
    
endmodule
