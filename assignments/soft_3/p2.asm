; Luis Gomez
; CPE 2333
;
; Program which reads in a value, and generates a delay of .5 seconds, the outputs value
;
; Give that each instruction ~ 40 ns, RAT MCU ~ 25MHZ. To create a delay of .5 seconds I will use
; (n) nested loops consisting of decrement counters of size 0xFF
;	
;	(255^n) * 40ns = .5 secs
;	n = ln(1/80ns)/ln(255) ~ 3 nested loops
;
; Registers Used:
;	R0- input value
;	R1- counter 1
;	R2- counter 2
;	R3- counter 3

.EQU IN_PORT = 0x9A
.EQU OUT_PORT = 0x42
.EQU COUNT = 0FF

.CSEG
.ORG 0x01

	start:	IN R0, IN_PORT	; read input
			MOV R1, COUNT
	loop1:	MOV R2, COUNT
	loop2:	MOV R3, COUNT
	loop3:	SUB R3, 1		; count3--
			BRNE loop3
			SUB R2, 1		; count2--
			BRNE loop2
			SUB R1, 1		; count1--
			BRNE loop1
			OUT R0, OUT_PORT
			
			