`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Luis Gomez
// Module Name: PC_PCMUX_interface
// 
// Dependencies: 
// 
//////////////////////////////////////////////////////////////////////////////////

module PC_PCMUX_interface(
    input CLK,  // clock signal
    input RST, 
    input PC_LD,
    input PC_INC,
    input [9:0] IR, 
    input [9:0] DATA_OUT,
    input [1:0] PC_MUX_SEL,
    output logic [9:0] PC_COUNT
    );
    logic [9:0] DIN;
    
    /*pc_MUX PCMUX(
        IR,
        DATA_OUT,
        PC_MUX_SEL,
        DIN);*/
    always_comb 
    begin
        case (PC_MUX_SEL)
            0:  DIN = IR;
            1:  DIN = DATA_OUT;
            2:  DIN = 10'h3FF;
            // elminiated 2'b11, no case for this
            endcase
        end 
                 
    program_counter PC(
        CLK,
        DIN,
        RST,
        PC_LD,
        PC_INC,
        PC_COUNT);
                
endmodule
