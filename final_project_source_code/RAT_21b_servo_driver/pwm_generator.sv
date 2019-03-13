`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Luis Gomez 
// 
// Description: 21-bit PWM generator
// 
//////////////////////////////////////////////////////////////////////////////////

module pwm_generator (
    input CLK,  // internal clock
    input SCLK,
    input [2:0] DIN,
    output logic [2:0] LEDS,
    output logic pwm = 0// output duty cycle signal
    );
    
    logic [19:0] select = 20'h124F8;
    logic [20:0] count = 0;
    localparam maxcount = 20'hFFFFF;    // numerical rep of half wave length, a
    localparam R = 20'h19A28;           // +60 angular position
    localparam L = 20'h0AFC8;           // -60 angular position
    localparam N = 20'h124F8, DELTA = 20'h001F4;
    
    always_comb begin
        case(DIN)
            2: LEDS = 3'b010;
            4: LEDS = 3'b100;
            1: LEDS = 3'b001;
            default: LEDS = 3'b000;
            endcase
    end
    
    always_ff @(posedge SCLK)
    begin
    select <= 0;
    
    case(DIN)
    2:  select <= N;
    4:  begin
        if(select > L)
            select <= select - DELTA;
        else select <= L;
        end
    1:  begin
        if(select < R)
            select <= select + DELTA;
        else select <= R;
        end
    default: select <= 0;
    endcase
    end
    // else select <= select;        
    // else select <= 0;
    
    always_ff @ (posedge CLK)
    begin
        if (select == 0)        // 0% duty cycle
            pwm <= 0;
        else if (select == maxcount) // % 100 duty cycle
            pwm <= 1;
        else
            count <= count + 1; 
            if (count == 2*maxcount)
            begin
                count <= 0;
                pwm <= 1;
            end
            if (count == 2*select)  // generates duty cycle
            begin
                pwm <= 0;
            end
    end
endmodule