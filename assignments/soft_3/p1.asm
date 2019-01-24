; Luis Gomez
; CPE 233
;
; Registers Used:
;	R0- counter variable
; 	R2- input value, lower half of input (multiplier B)
; 	R3- upper half of input, (multiplicand A)
; 	R4- product (A * B)
;
; This program multiplies A * B, via iterations of addition

.EQU IN_PORT = 0x9A
.EQU OUT_PORT = 0x42
.EQU SIZE = 4

.CSEG
.ORG 0x01
							; SET-UP
	start:	MOV R0, SIZE	; initialize counter
			MOV R4, 0x00	; intialize product
			IN R2, IN_PORT	; Read input value
			MOV R3, R2
	upper:	CLC				; ISOLATE A LOOP
			LSR R3
			SUB R0, 1		; counter--
			BRNE upper		; END LOOP if R0 == 0
			CMP R4, R3		; if A == 0, output 0
			BREQ end
			AND R2, 0x0F 	; ISOLATE B
			CMP R4, R2		; if B == 0, output 0
			BREQ end
			MOV R0, R2		; initialize multiplication counter
	 mult:	ADD R4, R3		; MULT LOOP
			SUB R0, 1		; counter--
			BRNE mult		; END LOOP if R0 == 0
	  end:	OUT R4, OUT_PORT
	  
	  
	  
	  