`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// Created by Paul Hummel
// Modified by Luis Gomez
//////////////////////////////////////////////////////////////////////////////

module RAT_WRAPPER(
    input CLK,
    input BTNC,             // System RESET
    input BTNU,             // Vert Servo Reset
    input BTND,
    input BTNL,             // Horiz Servo Reset
    input BTNR,
    input [7:0] IRSENSOR,   // IR feedback
    input [7:0] SWITCHES,
    output [7:0] LEDS,
    output [2:0] FSM_LED,   
    output [6:0] SEG,
    output [3:0] an,
    output [7:0] VGA_RGB,
    output VGA_HS,
    output VGA_VS,
    output PWM_V, PWM_H,
    output PWM_FSM
    // seven seg display annodes can be added here
    );
    
    // INPUT PORT IDS ////////////////////////////////////////////////////////
    // Right now, the only possible inputs are the switches
    // In future labs you can add more port IDs, and you'll have
    // to add constants here for the mux below
    localparam SWITCHES_ID = 8'h20;
    localparam VGA_READ_ID = 8'h93;
    localparam IRSENSOR_ID = 8'hA6;     // Infrared Sensor
           
    // OUTPUT PORT IDS ///////////////////////////////////////////////////////
    // In future labs you can add more port IDs
    localparam LEDS_ID      = 8'h40;
    localparam SEG_ID       = 8'h81;
    localparam VGA_HADDR_ID = 8'h90;
    localparam VGA_LADDR_ID = 8'h91;
    localparam VGA_COLOR_ID = 8'h92;
    localparam SERVO_H_ID   = 8'h49;    // Servo FSM port
       
    // Signals for connecting RAT_MCU to RAT_wrapper /////////////////////////
    logic [7:0] s_output_port;
    logic [7:0] s_port_id;
    logic s_load;
    logic s_interrupt;
    logic s_reset;
    logic s_clk_50 = 1'b0;     // 50 MHz clock
    
    // Register definitions for output devices ///////////////////////////////
    logic [7:0]     s_input_port;
    logic [7:0]     r_leds    = 8'h00;
    logic [3:0]     r_seg     = 4'h0;
    logic [2:0]     r_servo_h = 3'b000;
    
    // signals for connecting VGA frambuffer Driver
    logic r_vga_we;         // write enable
    logic [12:0] r_vga_wa;  // address of framebuffer to read and write
    logic [7:0] r_vga_wd;   // pixel color data to write to framebuffer
    logic [7:0] r_vga_rd;   // pixel color data read from framebuffer
    
    // Declare VGA Frame Buffer///////////////////////////////////////////////
    vga_fb_driver RAT_VGA(
        .CLK(s_clk_50),
        .WA(r_vga_wa),
        .WD(r_vga_wd),
        .WE(r_vga_we),
        .RD(r_vga_rd),
        .ROUT(VGA_RGB[7:5]),
        .GOUT(VGA_RGB[4:2]),
        .BOUT(VGA_RGB[1:0]),
        .HS(VGA_HS),
        .VS(VGA_VS));
    
    // Declare Servo Fsm//////////////////////////////////////////////////////
    pwm_generator servo_fsm(
        .CLK(CLK),
        .SCLK(s_clk_50),
        .RESET(s_reset),
        .DIN(r_servo_h),
        .LEDS(FSM_LED),
        .pwm(PWM_FSM) // output duty cycle signal
        );
          
    // Declare Servos w/ Button Control///////////////////////////////////////
    logic H_BL, H_BR, V_BU, V_BD;      
    
    debounce_one_shot pwm_L( // Reset CCW
            s_clk_50,
            BTNL,
            H_BL);

    debounce_one_shot pwm_R( // Increment CW
            s_clk_50,
            BTNR,
            H_BR);
                    
    pwm_gen_btn H_servo(     // Horizontal servo
        .CLK(CLK),
        .SCLK(s_clk_50),
        .BC(s_reset),
        .BL(H_BL),
        .BR(H_BR),
        .pwm(PWM_H));
        
    debounce_one_shot pwm_U( // Reset CCW
        s_clk_50,
        BTNU,
        V_BU);
    
    debounce_one_shot pwm_D( // Reset CW
        s_clk_50,
        BTND,
        V_BD);
    
    pwm_gen_btn V_servo(    // Vertical Servo
        .CLK(CLK),
        .SCLK(s_clk_50),
        .BC(s_reset),
        .BL(V_BU),
        .BR(V_BD),
        .pwm(PWM_V));
                
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
    debounce_one_shot RAT_reset(
        s_clk_50,
        BTNC,
        s_reset);
                               
    // Clock Divider to create 50 MHz Clock //////////////////////////////////
    always_ff @(posedge CLK) begin
        s_clk_50 <= ~s_clk_50;
    end
    
     
    // MUX for selecting what input to read //////////////////////////////////
    // add else-if statements to read additional inputs
    always_comb begin
        if (s_port_id == SWITCHES_ID)
            s_input_port = SWITCHES;
        else if (s_port_id == VGA_READ_ID)
            s_input_port = r_vga_rd;
        else if (s_port_id == IRSENSOR_ID)
            s_input_port = IRSENSOR;            
        else
            s_input_port = 8'h00;
    end
   
    // MUX for updating output registers /////////////////////////////////////
    // Register updates depend on rising clock edge and asserted load signal
    // add additional if statements to read the Port id and see if if matches your new INPUT_ID
    // then assign r_input <= s_output_port
    always_ff @ (posedge CLK) begin
        r_vga_we <= 0;
        r_servo_h <= 0;
        
        if (s_load == 1'b1) begin
            if (s_port_id == LEDS_ID) begin
                r_leds <= s_output_port;
            end
            else if (s_port_id == SEG_ID) begin
                r_seg <= s_output_port;
            end
            else if (s_port_id == SERVO_H_ID) begin
                r_servo_h <= s_output_port[2:0];
            end
            else if (s_port_id == VGA_HADDR_ID) begin   // Y coord
                r_vga_wa[12:7] <= s_output_port[5:0];
            end
            else if (s_port_id == VGA_LADDR_ID) begin   // X coord
                r_vga_wa[6:0] <= s_output_port[6:0];
            end
            else if (s_port_id == VGA_COLOR_ID) begin   // Y coord
                r_vga_wd <= s_output_port;
                r_vga_we <= 1'b1;                       // write enable to save data to framebuffer
            end                                      
        end
    end
     
    // Connect Signals ///////////////////////////////////////////////////////
    assign s_interrupt = H_BR | V_BD; // Servo Interrupt
    // Output Assignments ////////////////////////////////////////////////////
    assign LEDS = r_leds;
    endmodule
