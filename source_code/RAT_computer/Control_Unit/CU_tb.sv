`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luis Gomez
// 
// Description: 
// 
// Dependencies: 
// 
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CU_tb();
    logic clk;
    logic C,Z, _INT_, RESET;
    logic [4:0] OPCODE_HI_5;
    logic [1:0] OPCODE_LO_2;
    logic [1:0] I;
    logic [3:0] PC;
    logic [4:0] ALU;
    logic [2:0] RF;
    logic [2:0] SP;
    logic [3:0] SCR;
    logic [5:0] FLG;
    logic RST;
    
    control_unit CU_DUT(.*);
    
    always begin
        clk = 0; #50;
        clk = 1; #50;
    end
    
    initial begin
        // Test 1: MOV
    end
endmodule
