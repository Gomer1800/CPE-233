; Author: Luis Gomez
; Efficient 8bit to BCD converter
.EQU IN_PORT = 0x9A
.EQU OUT_PORT_1 = 0x43
.EQU OUT_PORT_10 = 0x42
.EQU OUT_PORT_100 = 0x41

.CSEG
.ORG 0x01
; Registers Used
; R0- Input
; R1- Subroutine Quotient
; R2- Subroutine Remainder
main:	IN R0, IN_PORT
		CALL DIV_10
		MOV R0, R1
		OUT R2, OUT_PORT_1
		CALL DIV_10
		OUT R2, OUT_PORT_10
		OUT R1, OUT_PORT_100
END:	BRN END
; Subroutine DIV_10
; Description:
; Subroutine divides input value by 10
;
; Parameter Registers:
; R0- Input
; R1- Quotient
; R2- Remainder
DIV_10:	MOV R1, 0x00	; Quotient/Counter
		MOV R2, R0		; Remainder
DIFF:	CMP R2, 0x0A	; Remainder < 10?
		BRCS END_SUB	; if True, branch
		ADD R1, 0x01	; Else, increment Quotient/Counter
		SUB R2, 0x0A	; Remainder - 10
		BRN DIFF
END_SUB:RET 
