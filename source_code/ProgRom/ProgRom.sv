`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Credit to Engineer, Paul Hummel
// 
// Create Date: 01/10/2019 02:57:01 PM
// Design Name: 
// Module Name: ProgRom
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

module ProgRom(
    input CLK,
    input [9:0] ADDR,
    output logic [17:0] IR // system verilog uses Logic instead of wire or reg
    );
    
    //reg [9:0] ADDR = 0;
    (* rom_style="{distributed | block}" *) // force the ROM to be block memory
    logic [17:0] rom[0:1023];
    
    // initialize the ROM with the prog_rom.mem file
    initial begin
        $readmemh("part2.mem", rom, 0, 1023); // (0 ,1023)
    end
    
    always_ff @ (posedge CLK) begin
        IR <= rom[ADDR];
    end
    
endmodule