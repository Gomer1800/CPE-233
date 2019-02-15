

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


(0001)                            || ;header
(0002)                            || ;
(0003)                            || ;
(0004)                       000  || .EQU COUNTER = 0x00
(0005)                            || .CSEG
(0006)                       001  || .ORG 0x01 
(0007)                     0x001  || start:
(0008)                            || 
(0009)  CS-0x001  0x3219A         || 	IN R1, 0x9A
(0010)  CS-0x002  0x36300         || 	MOV R3, COUNTER
(0011)  CS-0x003  0x04209         || 	MOV R2, R1 
(0012)                     0x004  || loop:
(0013)  CS-0x004  0x04209         || 	MOV R2, R1
(0014)  CS-0x005  0x04419         || 	MOV R4, R3
(0015)  CS-0x006  0x28301         || 	ADD R3, 0x01
(0016)  CS-0x007  0x2C103         || 	SUB R1, 0x03
(0017)  CS-0x008  0x0A021         || 	BRCC loop
(0018)  CS-0x009  0x34243         || 	OUT R2, 0x43
(0019)  CS-0x00A  0x34442         || 	OUT R4, 0x42





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
LOOP           0x004   (0012)  ||  0017 
START          0x001   (0007)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
COUNTER        0x000   (0004)  ||  0010 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
