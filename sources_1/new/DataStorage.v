`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 03:47:52 PM
// Design Name: 
// Module Name: DataStorage
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


module DataStorage(
        input wire clk,
        input wire reset,
        input wire [7:0]numRx,
        input wire rxDataRdy,
        input wire [7:0]addr,
        output wire [7:0]mem,
        output wire ramBusy
    );

    reg writeAddr;
    wire readAddr;
    reg [7:0] dataIn = 0;
    reg we;
    reg clearRam;
    reg shiftRam;
    assign ramBusy = clearRam || shiftRam;
    assign readAddr = shiftRam ? (writeAddr+33) : addr;
    wire [7:0] dataOut;
    DualPortRAM(
        .writeAddr(writeAddr), .readAddr(readAddr), .dataIn(dataIn), .clk(clk), .we(we), .en(1), .dataOut(dataOut)
    );
    
    reg [7:0] cursor;
    
    assign mem = dataOut;
    
    always @(posedge clk)
    begin
        if(reset)
        begin
            dataIn <= 0;
            we <= 1;
            clearRam <= 1;
            shiftRam <= 0;
            cursor <= 0;
            writeAddr <= 0;
        end
        else
        begin
            if(clearRam)
            begin

                if(writeAddr == 255)
                begin
                    clearRam <= 0;
                    we <= 0;
                    writeAddr <= cursor;
                end
                else
                begin
                    writeAddr <= writeAddr+1;
                    we <= 1;
                    dataIn <= 0;
                end
            end
            else
            begin
               if(shiftRam)
                    begin
                        writeAddr <= writeAddr+1;
                        dataIn <= (readAddr < 31) ? 0 : dataOut;
                        if(writeAddr == 254)
                        begin
                            shiftRam <= 0;
                            we <= 0;
                            cursor <= 224;
                        end
                        else
                            we <= 1;
                    end
                    //if ram was written to, increment cursor (and maybe shift ram)
                    else if(we) //implicitly RAM not busy
                    begin
                        we <= 0;
                        dataIn <= 0;
                        cursor <= cursor+1;
                        //if cursor points outside, begin shifting ram
                        if(cursor == 255)
                        begin
                            writeAddr <= 255;
                            shiftRam <= 1;
                        end
                    end
                    //if data ready
                    else if(rxDataRdy)
                    begin
                        writeAddr <= cursor;
                        dataIn <= numRx;
                        we <= 1;
                    end
            end
        end
    end
endmodule
