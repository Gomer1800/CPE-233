`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2019 05:18:18 PM
// Design Name: 
// Module Name: keypad_tb
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


module keypad_tb();
    logic clk, C, A, E;
    logic [6:0] seg;
    logic [3:0] an;
    logic B, G, F, D;
    logic interrupt;
    
    KeyPadDriver key_pad_DUT(.*);
    
    always
    begin
        clk = 0; #10;
        clk = 1; #10;
    end
    
    initial begin
        C = 0; A = 0; E = 0; #100000000;
        C = 1; A = 0; E = 0; #100000000;
        C = 0; A = 0; E = 0; #100000000;
    end
endmodule
