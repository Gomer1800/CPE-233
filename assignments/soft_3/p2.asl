

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


(0001)                            || ; Luis Gomez
(0002)                            || ; CPE 2333
(0003)                            || ;
(0004)                            || ; Program which reads in a value, and generates a delay of .5 seconds, then outputs value
(0005)                            || ;
(0006)                            || ; Given that each instruction ~ 40 ns, RAT MCU ~ 25MHZ. To create a delay of .5 seconds I will use
(0007)                            || ; (n) nested loops consisting of decrement counters of size 0xFF
(0008)                            || ;	
(0009)                            || ;	(255^n) * 40ns = 1/2 secs
(0010)                            || ;	n = ln(1/80ns)/ln(255) ~ 3 nested loops
(0011)                            || ;
(0012)                            || ; Registers Used:
(0013)                            || ;	R0- input value
(0014)                            || ;	R1- counter 1
(0015)                            || ;	R2- counter 2
(0016)                            || ;	R3- counter 3
(0017)                            || 
(0018)                       154  || .EQU IN_PORT = 0x9A
(0019)                       066  || .EQU OUT_PORT = 0x42
(0020)                       001  || .EQU COUNT = 0x01
(0021)                            || 
(0022)                            || .CSEG
(0023)                       001  || .ORG 0x01
(0024)                            || 
(0025)  CS-0x001  0x3209A  0x001  || 	start:	IN R0, IN_PORT	; read input
(0026)  CS-0x002  0x36101         || 			MOV R1, COUNT
(0027)  CS-0x003  0x36201  0x003  || 	loop1:	MOV R2, COUNT
(0028)  CS-0x004  0x36301  0x004  || 	loop2:	MOV R3, COUNT
(0029)  CS-0x005  0x2C301  0x005  || 	loop3:	SUB R3, 1		; count3--
(0030)  CS-0x006  0x0802B         || 			BRNE loop3
(0031)  CS-0x007  0x2C201         || 			SUB R2, 1		; count2--
(0032)  CS-0x008  0x08023         || 			BRNE loop2
(0033)  CS-0x009  0x2C101         || 			SUB R1, 1		; count1--
(0034)  CS-0x00A  0x0801B         || 			BRNE loop1
(0035)  CS-0x00B  0x34042         || 			OUT R0, OUT_PORT
(0036)                            || 			
(0037)                            || 			





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
LOOP1          0x003   (0027)  ||  0034 
LOOP2          0x004   (0028)  ||  0032 
LOOP3          0x005   (0029)  ||  0030 
START          0x001   (0025)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
COUNT          0x001   (0020)  ||  0026 0027 0028 
IN_PORT        0x09A   (0018)  ||  0025 
OUT_PORT       0x042   (0019)  ||  0035 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
