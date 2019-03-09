.EQU KEYPAD_PORT = 0x82
.CSEG
.ORG 0x1
; Code Demonstrating use of the Key Pad Driver
; 8-bit counter with LD

		SEI
start:	MOV R0, 0x00
count:	ADD R0, 0x01
		CMP R0, 0xFF
		BRNE count
		BRN start
.CSEG
.ORG 0x3FF
ISR:	IN R0, KEYPAD_PORT
		RETIE
		