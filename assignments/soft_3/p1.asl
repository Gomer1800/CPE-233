

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
(0002)                            || ; CPE 233
(0003)                            || ;
(0004)                            || ; Registers Used:
(0005)                            || ;	R0- counter variable
(0006)                            || ; 	R2- input value, lower half of input (multiplier B)
(0007)                            || ; 	R3- upper half of input, (multiplicand A)
(0008)                            || ; 	R4- product (A * B)
(0009)                            || ;
(0010)                            || ; This program multiplies A * B, via iterations of addition
(0011)                            || 
(0012)                       154  || .EQU IN_PORT = 0x9A
(0013)                       066  || .EQU OUT_PORT = 0x42
(0014)                       004  || .EQU SIZE = 4
(0015)                            || 
(0016)                            || .CSEG
(0017)                       001  || .ORG 0x01
(0018)                            || 							; SET-UP
(0019)  CS-0x001  0x36004  0x001  || 	start:	MOV R0, SIZE	; initialize counter
(0020)  CS-0x002  0x36400         || 			MOV R4, 0x00	; intialize product
(0021)  CS-0x003  0x3229A         || 			IN R2, IN_PORT	; Read input value
(0022)  CS-0x004  0x04311         || 			MOV R3, R2
(0023)  CS-0x005  0x18000  0x005  || 	upper:	CLC				; ISOLATE A LOOP
(0024)  CS-0x006  0x10301         || 			LSR R3
(0025)  CS-0x007  0x2C001         || 			SUB R0, 1		; counter--
(0026)  CS-0x008  0x0802B         || 			BRNE upper		; END LOOP if R0 == 0
(0027)  CS-0x009  0x04418         || 			CMP R4, R3		; if A == 0, output 0
(0028)  CS-0x00A  0x08092         || 			BREQ end
(0029)  CS-0x00B  0x2020F         || 			AND R2, 0x0F 	; ISOLATE B
(0030)  CS-0x00C  0x04410         || 			CMP R4, R2		; if B == 0, output 0
(0031)  CS-0x00D  0x08092         || 			BREQ end
(0032)  CS-0x00E  0x04011         || 			MOV R0, R2		; initialize multiplication counter
(0033)  CS-0x00F  0x02418  0x00F  || 	 mult:	ADD R4, R3		; MULT LOOP
(0034)  CS-0x010  0x2C001         || 			SUB R0, 1		; counter--
(0035)  CS-0x011  0x0807B         || 			BRNE mult		; END LOOP if R0 == 0
(0036)  CS-0x012  0x34442  0x012  || 	  end:	OUT R4, OUT_PORT
(0037)                            || 	  
(0038)                            || 	  
(0039)                            || 	  
(0040)                            || 	  





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
END            0x012   (0036)  ||  0028 0031 
MULT           0x00F   (0033)  ||  0035 
START          0x001   (0019)  ||  
UPPER          0x005   (0023)  ||  0026 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
IN_PORT        0x09A   (0012)  ||  0021 
OUT_PORT       0x042   (0013)  ||  0036 
SIZE           0x004   (0014)  ||  0019 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
