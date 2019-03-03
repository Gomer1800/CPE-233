`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Luis Gomez
//////////////////////////////////////////////////////////////////////////////////

module MCU(
    input CLK,
    input INTERRUPT,
    input RESET,
    input [7:0] IN_PORT,
    output logic [7:0] OUT_PORT, 
    output logic [7:0] PORT_ID,
    output logic IO_STRB
    );
    
    /////////////////////
    //  SP
    ////////////////////
                                // RST
                                // SP_LD
                                // SP_INCR
                                // SP_DECR
    logic [7:0] A;
    logic [7:0] B;
    logic [7:0] SP_DATA_OUT;
    assign B = SP_DATA_OUT;
    /////////////////////
    //  PC
    ////////////////////
                                // RST
                                // PC_LD
                                // PC_INC
    logic [9:0] PC_DIN;
                                // [12:3] IR
                                // SCR_DATA_OUT;
    logic [9:0] PC_COUNT;
    /////////////////////
    //  Prog Rom
    ////////////////////
                                // PC_COUNT
    logic [17:0] IR;
    /////////////////////
    //  Reg File
    ////////////////////
    logic [7:0] REG_DIN;
                                // ADRX, 
                                // ADRY;
    logic [7:0] DX_OUT;
    logic [7:0] DY_OUT;
    /////////////////////
    //  SCR
    ////////////////////
    logic [9:0] SCR_DATA_IN;
                                // SCR_WE
    logic [7:0] SCR_ADDR;       // ADDR
    logic [9:0] SCR_DATA_OUT;   // DATA OUT
    /////////////////////
    //  ALU
    ////////////////////
                                // SEL
                                // A
    logic [7:0] ALU_B;          // B
    logic ALU_C_OUT;            // C
    logic ALU_Z_OUT;            // Z
    logic [7:0] ALU_RESULT;

    /////////////////////
    //  CU
    ////////////////////
                            // C, Z
    logic I_SET;            // I
    logic I_CLR;
    logic PC_LD;            // PC
    logic PC_INC;
    logic [1:0] PC_MUX_SEL;
    logic ALU_OPY_SEL;      // ALU
    logic [3:0] ALU_SEL;
    logic RF_WR;            // RF
    logic [1:0] RF_WR_SEL;
    logic SP_LD;            // SP
    logic SP_INCR;
    logic SP_DECR;
    logic SCR_WE;           // SCR
    logic [1:0] SCR_ADDR_SEL;
    logic SCR_DATA_SEL;
    logic FLG_C_SET;        // FLG
    logic FLG_C_CLR;
    logic FLG_C_LD;
    logic FLG_Z_LD;
    logic FLG_LD_SEL;
    logic FLG_SHAD_LD;
    logic RST;              // RST
    /////////////////////
    //  FLAGS
    ////////////////////
    logic C_FLAG;
    logic Z_FLAG;        
    assign OUT_PORT = DX_OUT;
    assign PORT_ID = IR[7:0];
    assign A = DX_OUT;    
    
    /************************************************/
    /////////////////////
    //  PC DIN MUX
    ////////////////////
    always_comb
    begin
        case(PC_MUX_SEL)
            0: begin PC_DIN = IR[12:3]; end
            1: begin PC_DIN = SCR_DATA_OUT; end
            2: begin PC_DIN = 10'h3FF; end
            default: PC_DIN = 0;
        endcase
    end
    /////////////////////
    //  REG FILE DIN MUX
    ////////////////////
    always_comb
    begin
        case(RF_WR_SEL)
            0: REG_DIN = ALU_RESULT;
            1: REG_DIN = SCR_DATA_OUT[7:0];
            2: REG_DIN = B;
            3: REG_DIN = IN_PORT;
            default: REG_DIN = REG_DIN;
        endcase
    end
    /////////////////////
    //  SCR DIN MUX
    ////////////////////
    always_comb
    begin
        case (SCR_DATA_SEL)
            0: SCR_DATA_IN = DX_OUT;
            1: SCR_DATA_IN = PC_COUNT;
        endcase
    end
    /////////////////////
    //  SCR ADDR MUX
    ////////////////////
    always_comb
    begin
        case (SCR_ADDR_SEL)
            0: SCR_ADDR = DY_OUT;
            1: SCR_ADDR = IR[7:0];
            2: SCR_ADDR = SP_DATA_OUT;
            3: SCR_ADDR = SP_DATA_OUT-1;
        endcase
    end
    /////////////////////
    //  ALU B MUX
    ////////////////////
    always_comb begin
        case (ALU_OPY_SEL)
            0: ALU_B = DY_OUT;    
            1: ALU_B = IR[7:0];
        endcase
    end
    
    /************************************************/
    
    program_counter RAT_PC(
        CLK,
        PC_DIN,
        RST,
        PC_LD,
        PC_INC,
        PC_COUNT);
     
    ProgRom RAT_Prog_Rom(
        CLK,        // PROG CLK
        PC_COUNT,   // PROG ADDR
        IR);       // PROG IR
    
    Reg_File RAT_REG_FILE(
        CLK, 
        REG_DIN,
        RF_WR,
        IR[12:8],   // ADRX,
        IR[7:3],    // ADRY, 
        DX_OUT, 
        DY_OUT);
   
    ScratchRAM RAT_SCR(
        CLK,
        SCR_DATA_IN,
        SCR_WE,
        SCR_ADDR,
        SCR_DATA_OUT);
   
    ALU RAT_ALU(
        C_FLAG,     // CIN
        ALU_SEL,    // SEL
        DX_OUT,     // A
        ALU_B,      // B 
        ALU_RESULT, // RESULT    
        ALU_C_OUT,  // C
        ALU_Z_OUT); // Z
        
    control_unit RAT_CU(
        CLK,
        C_FLAG,     // C
        Z_FLAG,     // Z
        INTERRUPT,
        RESET,
        IR[17:13],  // OPCODE_HI_5
        IR[1:0],    // OPCODE_LO_2
        I_SET,          // I FLAGS
        I_CLR,
        PC_LD,          // PC FLAGS
        PC_INC,
        PC_MUX_SEL,
        ALU_OPY_SEL,    // ALU FLAGS
        ALU_SEL,
        RF_WR,          // RF FLAGS
        RF_WR_SEL,
        SP_LD,          // SP FLAGS
        SP_INCR,
        SP_DECR,
        SCR_WE,         // SCR FLAGS
        SCR_ADDR_SEL,
        SCR_DATA_SEL,
        FLG_C_SET,      // C Z FLAGS
        FLG_C_CLR,
        FLG_C_LD,
        FLG_Z_LD,
        FLG_LD_SEL,
        FLG_SHAD_LD,
        RST,            // RST FLAG
        IO_STRB);       // STROBE
        
    Flags RAT_flags(
        CLK,
        FLG_C_SET,  // FLAGS FROM CU
        FLG_C_CLR,
        FLG_C_LD,
        FLG_Z_LD,
        FLG_LD_SEL,
        FLG_SHAD_LD,
        ALU_C_OUT,  // C
        ALU_Z_OUT,  // Z
        C_FLAG,
        Z_FLAG);

    Stack_Pointer RAT_SP(
        CLK,
        RST,
        SP_LD,
        SP_INCR,
        SP_DECR,
        A,
        SP_DATA_OUT);
endmodule
