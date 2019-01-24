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
    input [9:0] FROM_IMMED, FROM_STACK,
    input [1:0] PC_MUX_SEL,
    output logic [9:0] DIN = 0
    );
    
    parameter [9:0] SIZE = 10'h3FF;
    
    always_comb begin
        case (PC_MUX_SEL)
            2'b00:  begin
                    DIN <= FROM_IMMED;
                    end
            2'b01:  begin
                    DIN <= FROM_STACK;
                    end
            2'b10:  begin
                    DIN <= 10'h3FF;
                    end
            2'b11:  begin
                    DIN <= 0;
                    end
        endcase
    end
endmodule
