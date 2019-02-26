.EQU IN_PORT = 0x9A
.EQU OUT_PORT = 0x42
.CSEG
.ORG 0x01
;-------------------------
; Registers Used:
;	R1- input
;	R2- output
;	R3- Queue size counter
;	R4- Front of Queue address
;-------------------------
		MOV R4, 0xFF	; Front of Queue address
queue:	IN R1, IN_PORT
		CMP R1, 0xFF	; Check if value read is 0xFF
		BREQ deque
		PUSH R1			; Push to stack
		ADD R3,0x01		; increment stack size
		BRN queue
deque:	LD R2,(R4)		; deque from front
		OUT R2,OUT_PORT
		SUB R4,0x01		; shift queue address
		SUB R3,0x01		; decrement stack size
		CMP R3,0x00		; is stack empty?
		BRNE deque

