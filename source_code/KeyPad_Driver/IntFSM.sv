`timescale 1ns / 1ps

module IntFSM(
    input clk, press,
    output logic interrupt
    );
           
    typedef enum {ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7} STATE;
    STATE NS, PS = ST0;

    always_ff @ (posedge clk)
        begin
        PS <= NS;
        end

    always_comb
    begin
    case(PS)
    ST0:begin // Waiting for initial key press
        if (press == 0)
            begin
            interrupt = 0;
            NS = ST0;
            end
        else
            begin
            interrupt = 0;
            NS = ST1;
            end
        end
    ST1:begin // waiting for key press to end, then trigger interrupt
        if (press == 0)
            begin
            NS = ST2; interrupt = 1;
            end
        else 
            begin
            NS = ST1;
            interrupt  = 0;
            end
        end                  
    ST2:begin NS = ST3; interrupt = 1; end
    ST3:begin NS = ST4; interrupt = 1; end
    ST4:begin NS = ST5; interrupt = 1; end
    ST5:begin NS = ST6; interrupt = 1; end
    ST6:begin NS = ST7; interrupt = 1; end    
    ST7:begin
        NS = ST0;
        interrupt = 0;
        end 
    default:
        begin
        NS = ST0;
        interrupt = 0;
        end
    endcase
    end
endmodule