`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luis Gomez
// 
// Create Date: 01/17/2019 10:22:46 AM
// Module Name: PC_and_PCMUX_tb
// Description: Series of tests for my Program Counter for the RAT architecture computer
// 
// Dependencies: 
//////////////////////////////////////////////////////////////////////////////////


module ALU_tb();
    logic [4:0] SEL;        // input
    logic [7:0] A, B;       // input
    logic CIN;              // input
    logic [7:0] RESULT = 0; // output
    logic C = 0, Z = 0;     // output
    
    ALU ALU_DUT(.*);
    
    initial begin   // 34 Tests Total
        // Test 1:  ADD
        SEL = 0; A = 8'hAA; B = 8'hAA; CIN = 0;
        #1; // nanosecond
        // Test 2:
        SEL = 0; A = 8'h0A; B = 8'hA0; CIN = 1;
        #1;
        // Test 3:
        SEL = 0; A = 8'hFF; B = 8'h01; CIN = 0;
        #1;
        // Test 4:  ADDC
        SEL = 1; A = 8'hC8; B = 8'h36; CIN = 1;
        #1;
        // Test 5:
        SEL = 1; A = 8'hC8; B = 8'h64; CIN = 1;
        #1;
        // Test 6:  SUB
        SEL = 2; A = 8'hC8; B = 8'h64; CIN = 0;
        #1;
        // Test 7:
        SEL = 2; A = 8'hC8; B = 8'h64; CIN = 1;
        #1;
        // Test 8:
        SEL = 2; A = 8'h64; B = 8'hC8; CIN = 0;
        #1;
        // Test 9:  SUBC
        SEL = 3; A = 8'hC8; B = 8'h64; CIN = 0;
        #1;
        // Test 10:
        SEL = 3; A = 8'hC8; B = 8'h64; CIN = 1;
        #1;
        // Test 11:
        SEL = 3; A = 8'h64; B = 8'hC8; CIN = 0;
        #1;
        // Test 12:
        SEL = 3; A = 8'h64; B = 8'hC8; CIN = 1;
        #1;
        // Test 13: CMP
        SEL = 4; A = 8'hAA; B = 8'hFF; CIN = 0;
        #1;
        // Test 14:
        SEL = 4; A = 8'hFF; B = 8'hAA; CIN = 0;
        #1;
        // Test 15:
        SEL = 4; A = 8'hAA; B = 8'hAA; CIN = 0;
        #1;
        // Test 16: AND
        SEL = 5; A = 8'hAA; B = 8'hAA; CIN = 0;
        #1;
        // Test 17:
        SEL = 5; A = 8'h03; B = 8'hAA; CIN = 0;
        #1
        // Test 18: OR
        SEL = 6; A = 8'hAA; B = 8'hAA; CIN = 0;
        #1
        // Test 19:
        SEL = 6; A = 8'h03; B = 8'hAA; CIN = 0;
        #1
        // Test 20: EXOR
        SEL = 7; A = 8'hAA; B = 8'hAA; CIN = 0;
        #1
        // Test 21:
        SEL = 7; A = 8'h03; B = 8'hAA; CIN = 0;
        #1
        // Test 22: TEST
        SEL = 8; A = 8'hAA; B = 8'hAA; CIN = 0;
        #1
        // Test 23:
        SEL = 8; A = 8'h55; B = 8'hAA; CIN = 0;
        #1
        // Test 24: LSL
        SEL = 9; A = 8'h01; B = 8'h12; CIN = 0;
        #1
        // Test 25: LSR
        SEL = 10; A = 8'h80; B = 8'h33; CIN = 0;
        #1
        // Test 26:
        SEL = 10; A = 8'h80; B = 8'h43; CIN = 1;
        #1
        // Test 27: ROL
        SEL = 11; A = 8'h01; B = 8'hAB; CIN = 1;
        #1
        // Test 28:
        SEL = 11; A = 8'hAA; B = 8'hF2; CIN = 0;
        #1
        // Test 29: ROR
        SEL = 12; A = 8'h80; B = 8'h3C; CIN = 0;
        #1
        // Test 30:
        SEL = 12; A = 8'h80; B = 8'h98; CIN = 1;
        #1
        // Test 31: ASR
        SEL = 13; A = 8'h80; B = 8'h81; CIN = 0;
        #1
        // Test 32:
        SEL = 13; A = 8'h40; B = 8'hB2; CIN = 0;
        #1
        // Test 33: MOV
        SEL = 14; A = 8'h00; B = 8'h30; CIN = 0;
        #1
        // Test 34:
        SEL = 14; A = 8'h43; B = 8'h00; CIN = 1;
        #1                                                                                                                                                                                                                                                            
        $finish;
    end
endmodule
