`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2019 09:28:16 AM
// Design Name: 
// Module Name: pc_MUX
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


module pc_MUX(
    input logic [9:0] IR, 
    input logic [9:0] SCR_DATA_OUT,
    input logic [1:0] PC_MUX_SEL,
    output logic [9:0] DIN
    );
        
    always_comb begin
        case (PC_MUX_SEL)
                0:  begin
                    DIN <= IR;
                    end
                1:  begin
                    DIN <= SCR_DATA_OUT;
                    end
                2:  begin
                    DIN <= 10'h3FF;
                    end
            // elminiated 2'b11, no case for this
        endcase
    end
endmodule
