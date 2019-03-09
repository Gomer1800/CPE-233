`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Created by Paul Hummel
// Modified by Luis Gomez
// 
// Create Date: 06/28/2018 05:21:01 AM
// Module Name: RAT_WRAPPER
// Target Devices: RAT MCU on Basys3
// Description: Basic RAT_WRAPPER
//
// Revision:
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////

module RAT_WRAPPER(
    input CLK,
    input BTNC, // RESET
    input BTNU, // INTERRUPT
    input [7:0] SWITCHES,
    output [7:0] LEDS,
    output [6:0] SEG,
    output [3:0] an
    // seven seg display annodes can be added here
    );
    
    // INPUT PORT IDS ////////////////////////////////////////////////////////
    // Right now, the only possible inputs are the switches
    // In future labs you can add more port IDs, and you'll have
    // to add constants here for the mux below
    localparam SWITCHES_ID = 8'h20;
       
    // OUTPUT PORT IDS ///////////////////////////////////////////////////////
    // In future labs you can add more port IDs
    localparam LEDS_ID      = 8'h40;
    localparam SEG_ID       = 8'h81;
       
    // Signals for connecting RAT_MCU to RAT_wrapper /////////////////////////
    logic [7:0] s_output_port;
    logic [7:0] s_port_id;
    logic s_load;
    logic s_interrupt;
    logic s_reset;
    logic s_clk_50 = 1'b0;     // 50 MHz clock
    
    // Register definitions for output devices ///////////////////////////////
    logic [7:0]     s_input_port;
    logic [7:0]     r_leds = 8'h00;
    logic [3:0]     r_seg  = 4'h00;
    
    // Declare RAT_CPU ///////////////////////////////////////////////////////
    MCU RAT_MCU(
        .CLK(s_clk_50),
        .INTERRUPT(s_interrupt),
        .RESET(s_reset),
        .IN_PORT(s_input_port),
        .OUT_PORT(s_output_port),
        .PORT_ID(s_port_id),
        .IO_STRB(s_load));
    
    // Declare Sev Seg Display
    BinSseg RAT_SEV_SEG(
        r_seg,
        SEG,
        an);
        
    // Declare Debouncer    
    debounce_one_shot RAT_debounce(
        s_clk_50,
        BTNU,
        s_interrupt);
                       
    // Clock Divider to create 50 MHz Clock //////////////////////////////////
    always_ff @(posedge CLK) begin
        s_clk_50 <= ~s_clk_50;
    end
    
     
    // MUX for selecting what input to read //////////////////////////////////
    // add else-if statements to read additional inputs
    always_comb begin
        if (s_port_id == SWITCHES_ID)
            s_input_port = SWITCHES;
        else
            s_input_port = 8'h00;
    end
   
    // MUX for updating output registers /////////////////////////////////////
    // Register updates depend on rising clock edge and asserted load signal
    // add additional if statements to read the Port id and see if if matches your new INPUT_ID
    // then assign r_input <= s_output_port
    always_ff @ (posedge CLK) begin
        if (s_load == 1'b1) begin
            if (s_port_id == LEDS_ID) begin
                r_leds <= s_output_port;
            end
            else if (s_port_id == SEG_ID) begin
                r_seg <= s_output_port;
            end            
        end
    end
     
    // Connect Signals ///////////////////////////////////////////////////////
    assign s_reset = BTNC;
    // assign s_interrupt = BTNU;  // no interrupt used yet
     
    // Output Assignments ////////////////////////////////////////////////////
    assign LEDS = r_leds;
    
    endmodule
