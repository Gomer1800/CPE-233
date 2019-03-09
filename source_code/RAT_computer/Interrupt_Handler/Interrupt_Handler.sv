`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2019 05:04:11 PM
// Design Name: 
// Module Name: Interrupt_Handler
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


module Interrupt_Handler(
    input CLK,
    input I_SET,
    input I_CLR,
    output logic OUT
    );
    
    always_ff@(posedge CLK)
    begin
        if(I_CLR) begin OUT <= 0; end
        else if(I_SET) begin OUT <= 1; end
    end
endmodule
