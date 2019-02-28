`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luis Gomez
//////////////////////////////////////////////////////////////////////////////////

module Reg_File(
    input CLK,
    input [7:0] DIN,
    input RF_WR,
    input [4:0] ADRX,
    input [4:0] ADRY,
    output logic [7:0] DX_OUT,
    output logic [7:0] DY_OUT
    );
    
    logic [7:0] regMemory [0:31]; // 32 X 8
    
    initial
    begin
        int i;
        for (i = 0; i < 32; i++)
        begin
            regMemory[i] = 0;
        end
     end
    
    always_ff @ (posedge CLK)
    begin
        if(RF_WR == 1)
        begin
            regMemory[ADRX] <= DIN;
        end
    end
    
    assign DX_OUT = regMemory[ADRX];
    assign DY_OUT = regMemory[ADRY];  
endmodule
