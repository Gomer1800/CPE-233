

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
(0003)                       001  || .ORG 0x01
(0004)                            || 
(0005)  CS-0x001  0x32130  0x001  || start:	IN R1, IN_PORT
(0006)  CS-0x002  0x30180         || 		CMP R1, 0x80
(0007)  CS-0x003  0x0A038         || 		BRCS less
(0008)  CS-0x004  0x10101         || 		LSR R1
(0009)  CS-0x005  0x10101         || 		LSR R1
(0010)  CS-0x006  0x08040         || 		BRN output
(0011)  CS-0x007  0x10100  0x007  || less:	LSL R1
(0012)  CS-0x008  0x34142  0x008  || output:	OUT R1, OUT_PORT





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
LESS           0x007   (0011)  ||  0007 
OUTPUT         0x008   (0012)  ||  0010 
START          0x001   (0005)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
IN_PORT        0x030   (0001)  ||  0005 
OUT_PORT       0x042   (0002)  ||  0012 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
