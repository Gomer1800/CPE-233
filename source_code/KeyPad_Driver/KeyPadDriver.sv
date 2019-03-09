`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: 
// Module Name: KeyPad Driver
//////////////////////////////////////////////////////////////////////////////////

module KeyPadDriver(input clk, C, A, E,
                    output [6:0] seg,
                    output [3:0] an,
                    output logic B, G, F, D ,
                    output interrupt);                    
    // logic i;
    // assign interrupt = i;
    logic press, sclk_22;
    logic [3:0] din, dout;
    // logic [21:0] count;
    // logic [1:0] count2;
    // localparam MAX_COUNT = 2272727;

    ClockDivider clkdiv_22(
        .clk(clk),
        .sclk(sclk_22)
        );

    KeyFSM FSMKey(
        .clk(sclk_22),
        .C(C),
        .A(A),
        .E(E),
        .B(B),
        .G(G),
        .F(F),
        .D(D),
        .press(press),
        .data(din)
        );
                
    IntFSM2 FSMInt(
        .clk(clk),
        .press(press),
        .interrupt(interrupt)
        );

    Register keyreg(
        .clk(sclk_22),
        .LD(press),
        .DIN(din),
        .Q(dout)
        );

    BinSseg sevseg(
        .binary(dout),
        .seg(seg),
        .an(an)
        );                    
                  
endmodule