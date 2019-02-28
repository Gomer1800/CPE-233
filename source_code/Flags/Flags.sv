`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Luis Gomez
// Module Name: Flags
// Description: 
// 
// Dependencies: 
// 
//////////////////////////////////////////////////////////////////////////////////

module Flags(
    input CLK,
    input FLG_C_SET,
    input FLG_C_CLR,
    input FLG_C_LD,
    input FLG_Z_LD,
    input FLG_LD_SEL,
    input FLG_SHAD_LD,
    input C,
    input Z,
    output logic C_FLAG,
    output logic Z_FLAG
    );
    // SIMPLE FLAGS
    
    always_ff@(posedge CLK)
    begin
        if(FLG_Z_LD==1) begin
            Z_FLAG <= Z;
            end
        else Z_FLAG <= Z_FLAG;
    end
    
    always_ff @(posedge CLK) begin
        if (FLG_C_CLR==1)
            C_FLAG <= 0;
        else if (FLG_C_LD==1)
            C_FLAG <= C;
        else if (FLG_C_SET==1)
            C_FLAG <= 1;
        else C_FLAG <= C_FLAG;
    end
    /*
    /////////////////////////////////////////////////
    // Z MUX
    logic Z_IN;
    logic Z_OUT;
    logic SHAD_Z_OUT;
    
    always_comb begin
        case(FLG_LD_SEL)
            0: Z_IN = Z;
            1: Z_IN = SHAD_Z_OUT;
        endcase
    end
    // Z Reg
    always_ff @(posedge CLK) begin
        if (FLG_Z_LD==1) 
            Z_OUT <= Z_IN;
    end
    // SHAD_Z
    always_ff @(posedge CLK) begin
        if (FLG_SHAD_LD==1)
            SHAD_Z_OUT <= Z_OUT;
    end
    /////////////////////////////////////////////////
    // C MUX
    logic C_IN;
    logic C_OUT;
    logic SHAD_C_OUT;
    
    always_comb begin
        case(FLG_LD_SEL)
            0: C_IN = C;
            1: C_IN = SHAD_C_OUT;
        endcase
    end
    // C Reg
    always_ff @(posedge CLK) begin
        if (FLG_C_CLR==1)
            C_OUT <= 0;
        else if (FLG_C_LD==1)
            C_OUT <= C_IN;
        else if (FLG_C_SET==1)
            C_OUT <= 1;
        else C_OUT <= C_OUT;
    end
    // SHAD_C
    always_ff @(posedge CLK) begin
        if (FLG_SHAD_LD==1)
            SHAD_C_OUT <= C_OUT;
        else
            SHAD_C_OUT <= SHAD_C_OUT;
    end
    
    assign Z_FLAG = Z_OUT, C_FLAG = C_OUT;
    */
endmodule
