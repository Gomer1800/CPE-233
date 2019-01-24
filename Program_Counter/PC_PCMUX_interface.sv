`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2019 09:42:19 AM
// Design Name: 
// Module Name: PC_PCMUX_interface
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

module PC_PCMUX_interface(
    // clock signal
    input CLK,
    // PC_MUX interface
    input [9:0] FROM_IMMED, FROM_STACK,
    input [1:0] PC_MUX_SEL,
    // output logic [9:0] DIN
    // Program Counter interface
    input PC_LD, PC_INC, RST,
    output logic [9:0] PC_COUNT
    // output logic [9:0] DIN // USED ONLY FOR TEST BENCH
    );
    // logic [9:0] DIN;
    
    pc_MUX PCMUX(FROM_IMMED, FROM_STACK, PC_MUX_SEL, DIN);
    program_counter PC(DIN, PC_LD, PC_INC, RST, CLK, PC_COUNT);
    
endmodule
