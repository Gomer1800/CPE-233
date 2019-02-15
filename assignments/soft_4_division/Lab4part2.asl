

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


(0001)                       000  || .EQU COUNTER = 0x00
(0002)                            || .CSEG 
(0003)                       001  || .ORG 0x01 
(0004)                     0x001  || start: 
(0005)  CS-0x001  0x3219A         || 	IN R1,  0x9A ; first input
(0006)  CS-0x002  0x3229A         || 	IN R2,  0x9A ; second input 
(0007)  CS-0x003  0x30200         || 	CMP R2, 0x00
(0008)  CS-0x004  0x0800A         || 	BREQ start
(0009)  CS-0x005  0x36300         || 	MOV R3, COUNTER ; initializing counter
(0010)                     0x006  || loop:
(0011)  CS-0x006  0x04411         || 	MOV R4, R2 ; save the incoming first value  
(0012)  CS-0x007  0x04509         || 	MOV R5, R1 ; save the incoming second value	
(0013)  CS-0x008  0x02112         || 	SUB R1, R2 ; subtract first value from the second
(0014)  CS-0x009  0x0806A         || 	BREQ zero_output 	
(0015)  CS-0x00A  0x0A078         || 	BRCS output
(0016)  CS-0x00B  0x28301         || 	ADD R3, 0x01 ; add one to the counter 
(0017)  CS-0x00C  0x0A031         || 	BRCC loop
(0018)                     0x00D  || zero_output:
(0019)  CS-0x00D  0x28301         || 	ADD R3, 0x01 ; add one to the counter 
(0020)  CS-0x00E  0x36500         || 	MOV R5, COUNTER ;clears remainder
(0021)                     0x00F  || output:
(0022)  CS-0x00F  0x34342         || 	OUT R3, 0x42 
(0023)  CS-0x010  0x34543         || 	OUT R5, 0x43

(0024)                            || 	OUT R5, 0x43






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
LOOP           0x006   (0010)  ||  0017 
OUTPUT         0x00F   (0021)  ||  0015 
START          0x001   (0004)  ||  0008 
ZERO_OUTPUT    0x00D   (0018)  ||  0014 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
COUNTER        0x000   (0001)  ||  0009 0020 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
