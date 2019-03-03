`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Luis Gomez
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU(
    input CIN,
    input [3:0] SEL,
    input [7:0] A, 
    input [7:0] B,
    output [7:0] RESULT,
    output logic C,
    output logic Z
    );
    logic [8:0] nine_bit;
    
    always_comb
    begin
        case(SEL)
            0:  begin nine_bit = {1'b0,A} + {1'b0,B}; end               // ADD
            1:  begin nine_bit = {1'b0,A} + {1'b0,B} + {8'h00,CIN}; end // ADDC
            2:  begin nine_bit = {1'b0,A} - {1'b0,B}; end               // SUB 
            3:  begin nine_bit = {1'b0,A} - {1'b0,B} - {8'h00,CIN}; end // SUBC
            4:  begin nine_bit = {1'b0,A} - {1'b0,B}; end               // CMP
            5:  begin nine_bit = {1'b0,A} & {1'b0,B}; end               // AND
            6:  begin nine_bit = {1'b0,A} | {1'b0,B}; end               // OR
            7:  begin nine_bit = {1'b0,A} ^ {1'b0,B}; end               // EXOR
            8:  begin nine_bit = {1'b0,A} & {1'b0,B}; end               // TEST
            9:  begin nine_bit = {A[7:0], CIN}; end                     // LSL
            10: begin nine_bit = {A[0], CIN, A[7:1]}; end               // LSR
            11: begin nine_bit = {A[7:0], A[7]}; end                    // ROL
            12: begin nine_bit = {A[0], A[0], A[7:1]}; end              // ROR
            13: begin nine_bit = {A[0], A[7], A[7:1]}; end              // ASR
            14: begin nine_bit = {1'b0,B}; end                          // MOV
            15: begin nine_bit = 0; end
            default begin nine_bit = 0; end
        endcase
    end
    
    assign RESULT = nine_bit[7:0];
    
    always_comb
    begin
        if (nine_bit[8] == 1)
            C = 1;
        else
            C = 0;
    end
    
    /*always_comb
    begin
        RESULT = nine_bit[7:0];
    end*/
        
    always_comb
    begin
        if (nine_bit[7:0] == 0)
            Z = 1;
        else 
            Z = 0;
    end
endmodule