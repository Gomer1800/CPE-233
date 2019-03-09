`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luis Gomez
//////////////////////////////////////////////////////////////////////////////////
module ScratchRAM(
    input CLK,
    input [9:0] DATA_IN,
    input SCR_WE,
    input [7:0] SCR_ADDR,
    output logic [9:0] DATA_OUT
    );
    
logic [9:0] memory [0:255];

initial 
begin 
    int i;
    for ( i=0; i< 255; i++)
        memory [i] = 0;     
 end 

always_ff @ (posedge CLK)
begin 
    if (SCR_WE ==1)
        memory[SCR_ADDR] <= DATA_IN;
end

assign DATA_OUT = memory[SCR_ADDR];

endmodule