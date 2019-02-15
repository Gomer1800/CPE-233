`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Luis Gomez 
// 
// Description: 8-bit PWM generator
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm_generator (
    input clk,  // internal clock
    input [7:0] sw, // input switches
    output [7:0] led,
    output logic pwm = 0// output duty cycle signal
    );
    assign led = sw; // enables leds for switches
    logic [8:0] count = 0;
    logic [7:0] maxcount = 255; // numerical rep of half wave length
    
    always_ff @ (posedge clk)
    begin
        if (sw == 0)        // 0% duty cycle
            pwm = 0;
        else if (sw == 255) // % 100 duty cycle
            pwm = 1;
        else
            count = count + 1; 
            if (count == 2*maxcount)
            begin
                count = 0;
                pwm = 1;
            end
            if (count == 2*sw)  // generates duty cycle
            begin
                pwm = 0;
            end
    end
endmodule