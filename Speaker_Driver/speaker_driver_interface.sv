`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Luis Gomez
// 
// Create Date: 01/26/2019 10:50:59 PM
// Module Name: speaker_driver_interface
// Description: Interface for a Speaker Driver. Provides 8-bit input via switches on the Basys3 board
//
// Dependencies: clock_div.sv
//////////////////////////////////////////////////////////////////////////////////

module speaker_driver_interface(
    input clk,
    input [7:0] sw,
    output [7:0] led,
    output sclk // square_wave
    );
    assign sw = led; // enables leds for switches
    logic [15:0] maxcount = 0;
    
    ClockDivider CLOCK_GEN (.*);
    
    parameter 
    C = 47778,C_sharp = 45097,
    D = 42566,D_sharp = 40177,
    E = 37922,
    F = 35793,F_sharp = 33784,
    G = 31888,G_sharp = 30098,
    A = 28409, A_sharp = 26815,
    B = 25310;
    
    always_ff @(posedge clk)
    begin
        case (sw)
            0:  begin
                maxcount <= 0;
                end
            1:  begin   // C
                maxcount <= C;
                end
            2:  begin   // C#, D flat
                maxcount <= C_sharp;
                end
            3:  begin   // D
                maxcount <= D;
                end
            4:  begin   // D#, E flat
                maxcount <= D_sharp;
                end
            5:  begin   // E
                maxcount <= E;
                end
            6:  begin   // F
                maxcount <= F;
                end
            7:  begin // F#, G flat
                maxcount <= F_sharp;
                end
            8:  begin   // G
                maxcount <= G;
                end
            9:  begin   // G#,A flat
                maxcount <= G_sharp;
                end
           10:  begin   // A
                maxcount <= A;
                end
           11:  begin   // A#, B flat
                maxcount <= A_sharp;
                end
           12:  begin   // B
                maxcount <= B;
                end
/**********2nd OCTAVE*****************/
           13:  begin   // C
                maxcount <= C*2;
                end
           14:  begin   // C#, D flat
                maxcount <= 2*C_sharp;
                end
           15:  begin   // D
                maxcount <= 2*D;
                end
           16:  begin   // D#, E flat
                maxcount <= 2*D_sharp;
                end
           17:  begin   // E
                maxcount <= 2*E;
                end
           18:  begin   // F
                maxcount <= 2*F;
                end
           19:  begin // F#, G flat
                maxcount <= 2*F_sharp;
                end
           20:  begin   // G
                maxcount <= 2*G;
                end
           21:  begin   // G#,A flat
                maxcount <= 2*G_sharp;
                end
           22:  begin   // A
                maxcount <= 2*A;
                end
           23:  begin   // A#, B flat
                maxcount <= 2*A_sharp;
                end
           24:  begin   // B
                maxcount <= 2*B;
                end
/**********3rd OCTAVE*****************/
           25:  begin   // C
                maxcount <= 4*C;
                end
           26:  begin   // C#, D flat
                maxcount <= 4*C_sharp;
                end
           27:  begin   // D
                maxcount <= 4*D;
                end
           28:  begin   // D#, E flat
                maxcount <= 4*D_sharp;
                end
           29:  begin   // E
                maxcount <= 4*E;
                end
           30:  begin   // F
                maxcount <= 4*F;
                end
           31:  begin // F#, G flat
                maxcount <= 4*F_sharp;
                end
           32:  begin   // G
                maxcount <= 4*G;
                end
           33:  begin   // G#,A flat
                maxcount <= 4*G_sharp;
                end
           34:  begin   // A
                maxcount <= 4*A;
                end
           35:  begin   // A#, B flat
                maxcount <= 4*A_sharp;
                end
           36:  begin   // B
                maxcount <= 4*B;
                end
      default:  begin
                maxcount = 0;
                end
        endcase
    end
endmodule
