.EQU IN_PORT = 0x9A
.EQU OUT_PORT_TOP = 0x41
.EQU OUT_PORT_BOT = 0x42

.CSEG
.ORG 0x01
; Efficient Program that computes 16b product of
; 8 bit values, A * B
;
; Registers Used
; R1- Input B
; R2- Output Bot / Subroutine Operand A & Sum
; R3- Input A	 / Subroutine Operand B
; R4- Output Top / Subroutine Carry
; R5- Counter
		MOV R2, 0x00	; Initialize Registers
		MOV R4, 0x00
		MOV R5, 0x00
		IN R3, IN_PORT	; Input A
		IN R1, IN_PORT	; Input B
		CMP R3, 0x00
		BREQ OUTPUT
MULT:	CMP R5, R1		; counter > B?
		BREQ OUTPUT
		ADD R5, 0x01	; counter++
		CALL ADD_EIGHT_BIT
		BRN MULT
OUTPUT:	OUT R2, OUT_PORT_BOT
		OUT	R4, OUT_PORT_TOP
END:	BRN END

; Subroutine ADD_EIGHT_BIT
; Description:
; Subroutine adds two 8b registers and
; stores the carry.
;
; R2- Operand A & Sum
; R3- Operand B
; R4- Carry
ADD_EIGHT_BIT:	
				ADD R2,R3		; Sum = A + B
				ADDC R4, 0x00	; Store Carry
END_SUB:		RET

