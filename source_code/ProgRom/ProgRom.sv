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
// Phase 1 Tests
        // 1a
        // $readmemh("1a_ANDrr_ORrr_EXORrr_LSL_LSR.mem", rom, 0, 1023); // (0 ,1023)
        // 1b
        // $readmemh("1b_ANDrr_ORrr_EXORrr_LSL_LSR.mem", rom, 0, 1023); // (0 ,1023)
        // 1c
        // $readmemh("1c_ANDrr_ORrr_EXORrr_LSL_LSR.mem", rom, 0, 1023); // (0 ,1023)
        // 3a
        // $readmemh("3ab_BRN_BREQ_BRNE_BRCS_BRCC_CLC_SEC.mem", rom, 0, 1023); // (0 ,1023)
        // 6a
        // $readmemh("6a_ADDri_ADDCri_SUBri_SUBCri.mem", rom, 0, 1023); // (0 ,1023)
        // 7a
        // $readmemh("7a_ADDrr_ADDCrr_SUBrr_SUBCrr.mem", rom, 0, 1023); // (0 ,1023)
//Phase2 Tests
        // 3B
        // $readmemh("3B.mem", rom, 0, 1023); // (0 ,1023)
        // 4A
        // $readmemh("4a_WSP_PUSH_POP_CALL_RET.mem", rom, 0, 1023); // (0 ,1023)        
        // 4B
        // $readmemh("4b_WSP_PUSH_POP_CALL_RET.mem", rom, 0, 1023); // (0 ,1023)         
        // 5A
        // $readmemh("5A.mem", rom, 0, 1023); // (0 ,1023)
        // 6B
        // $readmemh("6B.mem", rom, 0, 1023); // (0 ,1023)
        // Test All
        // $readmemh("TestAll.mem", rom, 0, 1023); // (0 ,1023)
//Phase3 Test        
        // 8A
        $readmemh("Phase3_8A.mem", rom, 0, 1023); // (0 ,1023)
        // 8 regular duration
        // $readmemh("Phase3_interrupt.mem", rom, 0, 1023); // (0 ,1023)                        
    end
    
    always_ff @ (posedge CLK) begin
        IR <= rom[ADDR];
    end
    
endmodule