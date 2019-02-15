`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2019 09:15:22 AM
// Design Name: 
// Module Name: ScratchRAM
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


module ScratchRAM(
input [9:0] DATA_IN,
input SCR_WE,
input [7:0] SCR_ADDR,
input CLK,
output [9:0] DATA_OUT
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
    if ( SCR_WE ==1)
    memory[SCR_ADDR] = DATA_IN;
end

assign DATA_OUT= memory[SCR_ADDR];


 
    
endmodule