`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 01:22:02 PM
// Design Name: 
// Module Name: DualPortRAM
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

module DualPortRAM(
        input wire [7:0] writeAddr,
        input wire [7:0] readAddr,
        input wire [7:0] dataIn,
        input wire clk,
        input wire we,
        input wire en,
        output wire [7:0] dataOut
    );

  //  Xilinx Simple Dual Port Single Clock RAM
  //  This code implements a parameterizable SDP single clock memory.
  //  If a reset or enable is not necessary, it may be tied off or removed from the code.
  wire outReset;                          // Output reset (does not affect memory contents)
  wire regceb;                        // Output register enable

  reg [7:0] dpram [255:0];
  reg [7:0] mem = {8{1'b0}};

  // The following code either initializes the memory values to a specified file or to all zeros to match hardware

      integer ram_index;
      initial
        for (ram_index = 0; ram_index < 256; ram_index = ram_index + 1)
         dpram[ram_index] = {8{1'b0}};

  always @(posedge clk) begin
    if (we)
      dpram[writeAddr] <= dataIn;
    if (en)
      mem <= dpram[readAddr];
  end

  assign dataOut = mem;
				
endmodule
