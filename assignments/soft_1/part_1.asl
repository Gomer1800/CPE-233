

List FileKey 
----------------------------------------------------------------------
C1      C2      C3      C4    || C5
--------------------------------------------------------------
C1:  Address (decimal) of instruction in source file. 
C2:  Segment (code or data) and address (in code or data segment) 
       of inforation associated with current linte. Note that not all
       source lines will contain information in this field.  
C3:  Opcode bits (this field only appears for valid instructions.
C4:  Data field; lists data for labels and assorted directives. 
C5:  Raw line from source code.
----------------------------------------------------------------------


(0001)                       048  || .EQU IN_PORT = 0x30
(0002)                       064  || .EQU OUT_PORT = 0x40
(0003)                            || .CSEG
(0004)                       001  || .ORG 0x01
(0005)                            || 
(0006)  CS-0x001  0x32130  0x001  || start:	IN R1, IN_PORT ; read val1
(0007)  CS-0x002  0x32230         || 		IN R2, IN_PORT ; read val2
(0008)  CS-0x003  0x32330         || 		IN R3, IN_PORT ; read val3
(0009)  CS-0x004  0x02110         || 		ADD R1, R2 ; R1 + R2
(0010)  CS-0x005  0x02118         || 		ADD R1, R3 ; Total sum
(0011)  CS-0x006  0x34140         || 		OUT R1, OUT_PORT
(0012)  CS-0x007  0x08008         || 		BRN start
(0013)                            || 		
(0014)                            || 		





Symbol Table Key 
----------------------------------------------------------------------
C1             C2     C3      ||  C4+
-------------  ----   ----        -------
C1:  name of symbol
C2:  the value of symbol 
C3:  source code line number where symbol defined
C4+: source code line number of where symbol is referenced 
----------------------------------------------------------------------


-- Labels
------------------------------------------------------------ 
START          0x001   (0006)  ||  0012 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
IN_PORT        0x030   (0001)  ||  0006 0007 0008 
OUT_PORT       0x040   (0002)  ||  0011 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
