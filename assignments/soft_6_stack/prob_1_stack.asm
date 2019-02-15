.EQU IN_PORT = 0x9A
.EQU OUT_PORT = 0x42
.CSEG
.ORG 0x01
;-------------------
; registers used:
;	R1- Input
;	R2- Ouput
;	R3- stack size counter
;-------------------
start:	IN R1,IN_PORT	;READ: read value from port 0x9A
		CMP R1,0xFF	;Is value 0xFF?
		BREQ popped		
		PUSH R1			;If not, push value to stack, return to READ
		ADD R3,0x01		; increment stack size
		BRN start
popped: POP R2			;Popped: pop stack
		OUT R2,OUT_PORT	;output popped value
		SUB R3, 0x01	;decrement stack size
		CMP R3, 0x00
		BRNE popped 	;is stack empty? return to Popped

