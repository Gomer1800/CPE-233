`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2019 04:28:53 PM
// Design Name: 
// Module Name: Controller
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


module Controller(
    input CLK,  // internal clock
    input BTNC,
    input BTNL,
    input BTNR,
    output logic [2:0] LEDS,
    output logic pwm// output duty cycle signal
    );
    
    // Clock Divider to create 50 MHz Clock //////////////////////////////////
    logic s_clk_50;
    always_ff @(posedge CLK) begin
        s_clk_50 <= ~s_clk_50;
    end
    
    // button logic
    logic C, L, R;
    debounce_one_shot dbC(
        s_clk_50,
        BTNC,
        C);
        
    debounce_one_shot dbL(
        s_clk_50,
        BTNL,
        L);
            
    debounce_one_shot dbR(
        s_clk_50,
        BTNR,
        R);
                            
    pwm_generator DUT(
        .CLK(CLK),  // internal clock
        .SCLK(s_clk_50),
        .BC(C),
        .BL(L),
        .BR(R),
        .LEDS(LEDS),
        .pwm(pwm)// output duty cycle signal
        );
            
endmodule
