`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Luis Gomez 
// 
// Description: 8-bit PWM generator
// 
//////////////////////////////////////////////////////////////////////////////////

module pwm_generator (
    input CLK,  // internal clock
    // input [15:0] sw, // input switches
    input BTNC,
    input BTNL,
    input BTNR,
    output logic [2:0] LEDS,
    output logic pwm = 0// output duty cycle signal
    );
    logic [17:0] sw;
    logic [18:0] count = 0;
    logic [17:0] maxcount = 18'h3FFFF; // numerical rep of half wave length
    localparam L = 17'h0D6D8, R = 17'h17318, N = 17'h124F8;
    
    always_comb begin
        if(BTNC == 1) begin sw = 0; LEDS = 3'b010; end
        else if (BTNL) begin sw = L; LEDS = 3'b100; end
        else if (BTNR) begin sw = R; LEDS = 3'b001; end
        else begin sw = 0; LEDS = 0; end
        // else begin sw = 0; LEDS = 3'b000; end
    end
    
    always_ff @ (posedge CLK)
    begin
        if (sw == 0)        // 0% duty cycle
            pwm <= 0;
        else if (sw == 17'h1FFFF) // % 100 duty cycle
            pwm <= 1;
        else
            count <= count + 1; 
            if (count == 2*maxcount)
            begin
                count <= 0;
                pwm <= 1;
            end
            if (count == 2*sw)  // generates duty cycle
            begin
                pwm <= 0;
            end
    end
endmodule