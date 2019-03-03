`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2019 02:12:52 PM
// Design Name: 
// Module Name: Stack_Pointer
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


module Stack_Pointer(
    input CLK,
    input RST,
    input SP_LD,
    input SP_INCR,
    input SP_DECR,
    input [7:0] A,
    output logic [7:0] DATA_OUT
    );
    
    always_ff @(posedge CLK)
    begin
        if (RST)
            DATA_OUT <= 0;
        else if (SP_LD)
            DATA_OUT <= A;
        else if (SP_INCR)
            DATA_OUT <= DATA_OUT + 1;
        else if (SP_DECR)
            DATA_OUT <= DATA_OUT - 1;
    end
endmodule
