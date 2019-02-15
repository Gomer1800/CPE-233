

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
(0002)                       066  || .EQU OUT_PORT = 0x42
(0003)                            || .CSEG
(0004)                       001  || .ORG 0x01
(0005)                            || 
(0006)  CS-0x001  0x32130  0x001  || start:	IN R1, IN_PORT
(0007)  CS-0x002  0x30180         || 		CMP R1, 0x80
(0008)  CS-0x003  0x0A038         || 		BRCS less			; is c == 1, jump to less
(0009)  CS-0x004  0x10101         || 		LSR R1				; divide R1 by 2
(0010)  CS-0x005  0x10101         || 		LSR R1				; divide R1 by 2
(0011)  CS-0x006  0x08040         || 		BRN output
(0012)  CS-0x007  0x10100  0x007  || less:	LSL R1				; multiply R1 by 2
(0013)  CS-0x008  0x34142  0x008  || output:	OUT R1, OUT_PORT
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
LESS           0x007   (0012)  ||  0008 
OUTPUT         0x008   (0013)  ||  0011 
START          0x001   (0006)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
IN_PORT        0x030   (0001)  ||  0006 
OUT_PORT       0x042   (0002)  ||  0013 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
