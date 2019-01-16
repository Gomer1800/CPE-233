

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
(0006)  CS-0x001  0x32130  0x001  || start:	IN R1, IN_PORT ; read 8-bit val
(0007)  CS-0x002  0x360FF         || 		MOV R0, 0xff
(0008)  CS-0x003  0x00102         || 		EXOR R1, R0
(0009)  CS-0x004  0x28101         || 		ADD R1, 0x01
(0010)  CS-0x005  0x34140         || 		OUT R1, OUT_PORT
(0011)  CS-0x006  0x08008         || 		BRN start
(0012)                            || 		
(0013)                            || 		





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
START          0x001   (0006)  ||  0011 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
IN_PORT        0x030   (0001)  ||  0006 
OUT_PORT       0x040   (0002)  ||  0010 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
