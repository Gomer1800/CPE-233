`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2019 08:28:33 AM
// Design Name: 
// Module Name: program_counter
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

module program_counter(
    input [9:0] DIN,
    input PC_LD, PC_INC, RST, CLK,
    output logic [9:0] PC_COUNT
    );
    
    always_ff @ (posedge CLK) begin
        if (RST == 1) begin // RESET
           PC_COUNT <= 0;
        end
        else if (PC_LD == 1) begin // LOAD
            PC_COUNT <= DIN;            
        end
        else if (PC_INC == 1) begin // INCREMENT
            case(PC_COUNT)
                10'h3FF: begin
                        PC_COUNT <= 0; // OVERFLOW
                        end
               default: begin
                        PC_COUNT++;
                        end         
            endcase 
        end
    end
endmodule
