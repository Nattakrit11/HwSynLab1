`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 04:31:41 PM
// Design Name: 
// Module Name: PS2ScanToAscii
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


module PS2ScanToAscii(
        input [7:0] sc,
        input shift,
        input capslock,
        output reg [7:0] ascii
    );
    
    always @(sc)
    begin
        if (shift) begin
            case (sc)
            8'h0d: ascii <= 8'h09; //TAB
            8'h0e: ascii <= 8'h7e;	// ~
            8'h15: ascii <= capslock ? 8'h51 : 8'h71;	// Q
            8'h16: ascii <= 8'h21;	// !
            8'h1b: ascii <= capslock ? 8'h73 : 8'h53;	// s/S
            8'h1a: ascii <= capslock ? 8'h7a : 8'h5a;	// z/Z
            8'h1c: ascii <= capslock ? 8'h61 : 8'h41;	// a/A
            8'h1d: ascii <= capslock ? 8'h77 : 8'h57;	// w/W
            8'h1e: ascii <= 8'h40;	// @
            8'h21: ascii <= capslock ? 8'h63 : 8'h43;	// c/C
            8'h22: ascii <= capslock ? 8'h78 : 8'h58;	// x/X
            8'h23: ascii <= capslock ? 8'h64 : 8'h44;	// d/D
            8'h24: ascii <= capslock ? 8'h65 : 8'h45;	// E
            8'h25: ascii <= 8'h24;	// $
            8'h26: ascii <= 8'h23;	// #
            8'h29: ascii <= 8'h20;	// space
            8'h2a: ascii <= capslock ? 8'h76 : 8'h56;	// V
            8'h2b: ascii <= capslock ? 8'h66 : 8'h46;	// F
            8'h2c: ascii <= capslock ? 8'h74 : 8'h54;	// T
            8'h2d: ascii <= capslock ? 8'h72 : 8'h52;	// R
            8'h2e: ascii <= 8'h25;	// %
            8'h31: ascii <= capslock ? 8'h6e : 8'h4e;	// N
            8'h32: ascii <= capslock ? 8'h62 : 8'h42;	// B
            8'h33: ascii <= capslock ? 8'h68 : 8'h48;	// H
            8'h34: ascii <= capslock ? 8'h67 : 8'h47;	// G
            8'h35: ascii <= capslock ? 8'h79 : 8'h59;	// Y
            8'h36: ascii <= 8'h5e;	// ^
            8'h3a: ascii <= capslock ? 8'h6d : 8'h4d;	// M
            8'h3b: ascii <= capslock ? 8'h6a : 8'h4a;	// J
            8'h3c: ascii <= capslock ? 8'h75 : 8'h55;	// U
            8'h3d: ascii <= 8'h26;	// &
            8'h3e: ascii <= 8'h2a;	// *
            8'h41: ascii <= 8'h3c;	// <
            8'h42: ascii <= capslock ? 8'h6b : 8'h4b;	// K
            8'h43: ascii <= capslock ? 8'h69 : 8'h49;	// I
            8'h44: ascii <= capslock ? 8'h6f : 8'h4f;	// O
            8'h45: ascii <= 8'h29;	// )
            8'h46: ascii <= 8'h28;	// (
            8'h49: ascii <= 8'h3e;	// >
            8'h4a: ascii <= 8'h3f;	// ?
            8'h4b: ascii <= capslock ? 8'h6c : 8'h4c;	// L
            8'h4c: ascii <= 8'h3a;	// :
            8'h4d: ascii <= capslock ? 8'h70 : 8'h50;	// P
            8'h4e: ascii <= 8'h5f;	// _
            8'h52: ascii <= 8'h22;	// "
            8'h54: ascii <= 8'h7b;	// {
            8'h55: ascii <= 8'h2b;	// +
            8'h5b: ascii <= 8'h7d;	// }
            8'h5d: ascii <= 8'h7c;	// |
            8'h71: ascii <= 8'h7f;	// del
            default:	ascii <= 8'h2d; // -
            endcase
        end
        else begin
            case (sc)
                8'h0d: ascii <= 8'h09;	// tab
                8'h0e: ascii <= 8'h60;	// `
                8'h15: ascii <= capslock ? 8'h51 : 8'h71;	// q
                8'h16: ascii <= 8'h31;	// 1
                8'h1a: ascii <= capslock ? 8'h5a : 8'h7a;	// z
                8'h1b: ascii <= capslock ? 8'h53 : 8'h73;	// s
                8'h1c: ascii <= capslock ? 8'h41 : 8'h61;	// a
                8'h1d: ascii <= capslock ? 8'h57 : 8'h77;	// w
                8'h1e: ascii <= 8'h32;	// 2
                8'h21: ascii <= capslock ? 8'h43 : 8'h63;	// c
                8'h22: ascii <= capslock ? 8'h58 : 8'h78;	// x
                8'h23: ascii <= capslock ? 8'h44 : 8'h64;	// d
                8'h24: ascii <= capslock ? 8'h45 : 8'h65;	// e
                8'h25: ascii <= 8'h34;	// 4
                8'h26: ascii <= 8'h33;	// 3
                8'h29: ascii <= 8'h20;	// space
                8'h2a: ascii <= capslock ? 8'h56 : 8'h76;	// v
                8'h2b: ascii <= capslock ? 8'h46 : 8'h66;	// f
                8'h2c: ascii <= capslock ? 8'h54 : 8'h74;	// t
                8'h2d: ascii <= capslock ? 8'h52 : 8'h72;	// r
                8'h2e: ascii <= 8'h35;	// 5
                8'h31: ascii <= capslock ? 8'h4e : 8'h6e;	// n
                8'h32: ascii <= capslock ? 8'h42 : 8'h62;	// b
                8'h33: ascii <= capslock ? 8'h48 : 8'h68;	// h
                8'h34: ascii <= capslock ? 8'h47 : 8'h67;	// g
                8'h35: ascii <= capslock ? 8'h59 : 8'h79;	// y
                8'h36: ascii <= 8'h36;	// 6
                8'h3a: ascii <= capslock ? 8'h4d : 8'h6d;	// m
                8'h3b: ascii <= capslock ? 8'h4a : 8'h6a;	// j
                8'h3c: ascii <= capslock ? 8'h55 : 8'h75;	// u
                8'h3d: ascii <= 8'h37;	// 7
                8'h3e: ascii <= 8'h38;	// 8
                8'h41: ascii <= 8'h2c;	// ,
                8'h42: ascii <= capslock ? 8'h4b : 8'h6b;	// k
                8'h43: ascii <= capslock ? 8'h49 : 8'h69;	// i
                8'h44: ascii <= capslock ? 8'h4f : 8'h6f;	// o
                8'h45: ascii <= 8'h30;	// 0
                8'h46: ascii <= 8'h39;	// 9
                8'h49: ascii <= 8'h2e;	// .
                8'h4a: ascii <= 8'h2f;	// /
                8'h4b: ascii <= 8'h6c;	// l
                8'h4c: ascii <= 8'h3b;	// ;
                8'h4d: ascii <= capslock ? 8'h50 : 8'h70;	// p
                8'h4e: ascii <= 8'h2d;	// -
                8'h52: ascii <= 8'h27;	// '
                8'h54: ascii <= 8'h5b;	// [
                8'h55: ascii <= 8'h3d;	// =
                8'h5b: ascii <= 8'h5d;	// ]
                8'h5d: ascii <= 8'h5c;	// \
                8'h66: ascii <= 8'h08;	// backspace
                8'h71: ascii <= 8'h7f;	// del
                default: ascii <= 8'h2d;  // -
            endcase
        end
    end
endmodule
