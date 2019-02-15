`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luis Gomez
// 
// Create Date: 01/17/2019 10:22:46 AM
// Design Name: 
// Module Name: PC_and_PCMUX_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Series of tests for my Program Counter for the RAT architecture computer
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PC_and_PCMUX_tb(); // Normally we would define input/output inside here, instead our inputs/outputs are internal logic signals found below
    // clock signal
    logic CLK;
    // PC_MUX interface
    logic [9:0] FROM_IMMED, FROM_STACK;
    logic [1:0] PC_MUX_SEL;
    // Program Counter interface
    logic PC_LD, PC_INC, RST;
    logic [9:0] PC_COUNT;
    logic [9:0] DIN;
    
    PC_PCMUX_interface DUT_interface(.*);
    
    always // Sim Clock signal
    begin
        CLK = 0; #50; // 5 nanosecs
        CLK = 1; #50;
    end
    
    initial begin
        // Test 1: NO LOAD, DIN = FROM_IMMED
        FROM_IMMED = 10'hA; FROM_STACK = 10'hB; 
        PC_MUX_SEL = 0; PC_LD = 0; PC_INC = 0; RST = 0;
        #100; // Test 2: : LOAD, DIN = FROM_STACK
        PC_LD = 1; PC_MUX_SEL = 1;
        #100; // Test 3: RESET  
        RST = 1; PC_LD = 0;
        #100; // Test 4: : INCREMENT
        PC_INC = 1; RST = 0;
        #200;        
        $finish;
    end
endmodule
