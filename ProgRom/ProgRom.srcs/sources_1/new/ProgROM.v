`timescale 1ns/1ps
// Company: Cal Poly
// Credit to Engineer, Paul Hummel

module ProgRom(
    input PROG_CLK,
    input [9:0] PROG_ADDR
    //output logic [17:0] PROG_IR
    );
    
    (* rom_style="{distributed | block}" *) // force the ROM to be block memory
    //logic [17:0] , rom[0:1023];
    
    // initialize the ROM with the prog_rom.mem file
    initial begin
        $readmemh("assignment_1.mem", rom, 0, 1023);
    end
    
    /*always ff @(posedge PROG_CLK) begin
        PROG_IR <= rom[PROG_ADDR];
    end*/
    
endmodule
    