`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Luis Gomez 
// 
// Description: 21-bit PWM generator
// 
//////////////////////////////////////////////////////////////////////////////////

module pwm_generator (
    input CLK,              // internal clock
    input SCLK,
    input RESET,            // System Reset
    input [2:0] DIN,        // Control Signals
    output logic INTER = 0,     // interrupt signal
    output logic [2:0] LEDS,// Control Indicator Lights
    output logic pwm = 0    // output duty cycle signal
    );

    localparam maxcount = 20'hFFFFF;    // numerical rep of half wave length, a
    localparam L = 20'h0DDD3; // 20'h1D9A2;           // ~75 angular position
    localparam N = 20'h11496; // 20'h122D2;           // ~90 pos
    localparam R = 20'h14B59; // 20'h06C02;           // ~105 angular position
    localparam DELTA = 20'h0015F;                     // (R-L)/40 vertical delta
    
    logic pwm_inter = 0;
    logic [20:0] count = 0;
    logic [19:0] select = L;
    logic [19:0] pwm_select = L;
    logic ENABLE = 0;   // PWM enable signal   
    
    typedef enum        // States     
    {START,IDLE,LEFT,RIGHT,NEUTRAL} STATE;
    
    STATE NS = IDLE;
    STATE PS = START;
                          
    always_ff @ (posedge SCLK) // State Selection
    begin
        if (RESET == 1)
        begin
            PS <= START;
        end
        else
            PS <= NS;
    end
    
    always_ff @ (posedge SCLK)
    begin
        if (ENABLE == 1)
        begin
            pwm_select <= select;
            INTER <= pwm_inter;
        end
        else
        begin
            pwm_select <= pwm_select;
            INTER <= 0;
        end
    end
    
    always_ff @ (posedge SCLK) // evaluate states
    begin
        pwm_inter <= 0;
        ENABLE <= 0;
        case(PS)
            START: 
            begin
                LEDS <= 0;
                select <= L;
                NS <= IDLE;
            end
            IDLE:
            begin
                LEDS <= 3'b010;
                select <= select;
                case(DIN)
                    4: NS <= LEFT;
                    2: NS <= NEUTRAL;
                    1: NS <= RIGHT;
                    default: NS <= IDLE;
                endcase
            end
            LEFT:
            begin
                ENABLE <= 1;
                select <= L;
                LEDS <= 3'b100;
                NS <= IDLE;
            end
            NEUTRAL:
            begin
                ENABLE <= 1;
                select <= N;
                LEDS <= 3'b010;
                NS <= IDLE;
            end
            RIGHT:
            begin
                ENABLE <= 1;
                pwm_inter <= 1;                
                if(select < R)
                    select <= select + DELTA;
                else select <= R;
                LEDS <= 3'b001;
                NS <= IDLE;
            end
            default: NS <= START;
        endcase // PS case    
    end // evaluate states
    
    //////////////////////////////////////////GOOD   
    always_ff @ (posedge CLK)
    begin
        if (pwm_select == 0)        // 0% duty cycle
            pwm <= 0;
        else if (pwm_select == maxcount) // % 100 duty cycle
            pwm <= 1;
        else 
        begin
            count <= count + 1;
            if (count == 2*maxcount)
            begin
                count <= 0;
                pwm <= 1;
            end
            else if (count == 2*pwm_select)  // generates duty cycle
            begin
                pwm <= 0;
            end
        end    
    end // always_ff
endmodule