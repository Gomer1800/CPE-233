

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


(0001)                       016  || .EQU LED_PORT = 0x10	; output port
(0002)                            || .CSEG
(0003)                       064  || .ORG 0x40	; code starts here
(0004)                            || 
(0005)                            || ; code seg 2: prog A
(0006)  CS-0x040  0x36A05  0x040  || main_loop:	MOV	R10,0x05
(0007)  CS-0x041  0x36B64         || 			MOV R11,0x64
(0008)  CS-0x042  0x02A58         || 			ADD	R10,R11
(0009)  CS-0x043  0x28A14         || 			ADD	R10,0x14
(0010)  CS-0x044  0x05451         || 			MOV	R20,R10
(0011)  CS-0x045  0x35410         || 			OUT	R20,LED_PORT
(0012)  CS-0x046  0x08200         || 			BRN	main_loop	;endless loop
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
MAIN_LOOP      0x040   (0006)  ||  0012 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
LED_PORT       0x010   (0001)  ||  0011 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
