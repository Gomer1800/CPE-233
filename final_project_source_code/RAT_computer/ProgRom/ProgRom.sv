`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Credit to Engineer, Paul Hummel
//////////////////////////////////////////////////////////////////////////////////

module ProgRom(
    input CLK,
    input [9:0] ADDR,
    output logic [17:0] IR // system verilog uses Logic instead of wire or reg
    );
    
    (* rom_style="{distributed | block}" *) // force the ROM to be block memory
    logic [17:0] rom[0:1023];
    
    // initialize the ROM with the prog_rom.mem file
    initial begin
// IR TESTS
        // $readmemh("test_IR.mem", rom, 0, 1023); // (0 ,1023)  
        // $readmemh("Final_inter_driven_pointer.mem", rom, 0, 1023); // (0 ,1023)   
// Servo Tests
        // $readmemh("test_h_zero.mem", rom, 0, 1023); // (0 ,1023)
        // $readmemh("servotest.mem", rom, 0, 1023); // (0 ,1023)
        // $readmemh("simple_horizontal.mem", rom, 0, 1023); // (0 ,1023)
        // $readmemh("dual_servo_delayed.mem", rom, 0, 1023); // (0 ,1023)
        $readmemh("dual_servo_isr.mem", rom, 0, 1023); // (0 ,1023)                   
// Scanner Tests
        // $readmemh("scan.mem", rom, 0, 1023); // (0 ,1023)
        // $readmemh("interrupt_test_A.mem", rom, 0, 1023); // (0 ,1023)       
// VGA Tests
        // $readmemh("draw2.mem", rom, 0, 1023); // (0 ,1023)
        // $readmemh("Test_B_change_lines.mem", rom, 0, 1023); // (0 ,1023)                   
        // $readmemh("Test_C_change_dot.mem", rom, 0, 1023); // (0 ,1023)
        // $readmemh("Test_D_basic_inter.mem", rom, 0, 1023); // (0 ,1023)
        // $readmemh("Test_Da_static_dot.mem", rom, 0, 1023); // (0 ,1023)
        // $readmemh("Test_Db_dot_wDelay.mem", rom, 0, 1023); // (0 ,1023)                  
    end
    
    always_ff @ (posedge CLK) begin
        IR <= rom[ADDR];
    end
    
endmodule