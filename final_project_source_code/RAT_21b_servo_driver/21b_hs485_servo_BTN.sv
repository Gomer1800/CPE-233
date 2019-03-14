`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Luis Gomez
// Module Name: 21b_hs485_servo_BTN
//////////////////////////////////////////////////////////////////////////////////

module pwm_gen_btn(
    input CLK,  // internal clock
    input SCLK,
    input BC, // Reset    
    input BL,
    input BR,
    output logic pwm// output duty cycle signal
    );

    localparam maxcount = 20'hFFFFF;    // numerical rep of half wave length, a
    localparam R = 20'h1D9A2;           // +60 angular position
    localparam L = 20'h06C02;           // -60 angular position
    localparam N = 20'h122D2;           // Neutral pos
    localparam DELTA = 20'H001F4; //20'H00208;// 20'h00410;       // 1 deg increment

    logic [20:0] count = 0;
    logic [19:0] select = L;
                             
    always_ff @(posedge SCLK)
    begin
    if (BC) begin
        select <= L;
        end    
    else if (BL) begin
        /*if(select > L)
            select <= select - DELTA;
        else select <= select + DELTA;*/
        select <= L;
        end
    else if (BR) begin
        if(select < R)
            select <= select + DELTA;
        else select <= R;
        end
    end
    //////////////////////////////////////////GOOD   
    always_ff @ (posedge CLK)
    begin
           if (select == 0)        // 0% duty cycle
               pwm <= 0;
           else if (select == maxcount) // % 100 duty cycle
               pwm <= 1;
           else begin
               count <= count + 1; 
               if (count == 2*maxcount)
               begin
                   count <= 0;
                   pwm <= 1;
               end
               else if (count == 2*select)  // generates duty cycle
               begin
                   pwm <= 0;
               end
           end // line # 64
    end
endmodule