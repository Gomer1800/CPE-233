`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2019 08:12:12 PM
// Design Name: 
// Module Name: Register
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


module Register(input clk, LD, 
                input [3:0] DIN,
                output logic [3:0] Q
                );
                
    always_ff @ (posedge clk)
        begin
            case(LD)
            1: Q <= DIN;
            0: Q <= Q;
            endcase
        end
        
endmodule