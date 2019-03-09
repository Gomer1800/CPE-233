`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luis Gomez
// Module Name: program_counter
//////////////////////////////////////////////////////////////////////////////////

module program_counter(
    input CLK,
    input [9:0] DIN,
    input RST,    
    input PC_LD,
    input PC_INC,
    output logic [9:0] PC_COUNT
    );
    
    always_ff @ (posedge CLK)
    begin
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
                        PC_COUNT <= PC_COUNT + 1;
                        end         
            endcase 
        end
    end
endmodule
