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
    output logic [7:0] RESULT,
    output logic C,
    output logic Z
    );
    logic [8:0] nine_bit;
    typedef enum {X, ADD, ADDC, SUB, SUBC, CMP, _AND, _OR, EXOR, TEST, LSL, LSR, ROL, ROR, ASR, MOV} INST;
    INST ALU_INST = X;
    
    always_comb
    begin
        case(SEL)
            0:  nine_bit = {1'b0,A} + {1'b0,B};                 // ADD
            1:  nine_bit = {1'b0,A} + {1'b0,B} + {8'b0,CIN};    // ADDC
            2:  nine_bit = {1'b0,A} - {1'b0,B};                 // SUB 
            3:  nine_bit = {1'b0,A} - {1'b0,B} - {8'b0,CIN};    // SUBC
            4:  nine_bit = {1'b0,A} - {1'b0,B};                 // CMP
            5:  nine_bit = {1'b0,A} & {1'b0,B};                 // AND
            6:  nine_bit = {1'b0,A} | {1'b0,B};                 // OR
            7:  nine_bit = {1'b0,A} ^ {1'b0,B};                 // EXOR
            8:  nine_bit = {1'b0,A} & {1'b0,B};                 // TEST
            9:  nine_bit = {A[7:0], CIN};                       // LSL
            10: nine_bit = {A[0], CIN, A[7:1]};                 // LSR
            11: nine_bit = {A[7], A[6:0], A[7]};                // ROL
            12: nine_bit = {A[0], A[0], A[7:1]};                // ROR
            13: nine_bit = {A[0], A[7], A[7:1]};                // ASR
            14: nine_bit = {1'b0,B};                            // MOV
        endcase
    end
    
    always_comb
    begin
        case(SEL)
            0:  ALU_INST = ADD;
            1:  ALU_INST = ADDC;
            2:  ALU_INST = SUB; 
            3:  ALU_INST = SUBC;
            4:  ALU_INST = CMP;
            5:  ALU_INST = _AND;
            6:  ALU_INST = _OR;
            7:  ALU_INST = EXOR;
            8:  ALU_INST = TEST;
            9:  ALU_INST = LSL;
            10: ALU_INST = LSR;
            11: ALU_INST = ROL;
            12: ALU_INST = ROR;
            13: ALU_INST = ASR;
            14: ALU_INST = MOV;
            default: ALU_INST = X;
            
        endcase
    end
    always_comb
    begin
        if (nine_bit[8] == 1)
            C = 1;
        else
            C = 0;
    end
    
    always_comb
    begin
        RESULT = nine_bit[7:0];
    end
        
    always_comb
    begin
        if (nine_bit[7:0] == 0)
            Z = 1;
        else 
            Z = 0;
    end
endmodule