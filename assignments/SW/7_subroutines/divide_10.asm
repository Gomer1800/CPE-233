.EQU IN_PORT = 0x9A
.EQU OUT_PORT_100 = 0x41
.EQU OUT_PORT_10 = 0x42
.EQU OUT_PORT_1 = 0x43

.CSEG
.ORG 0x01

; Registers Used
; R0- Input
; R1- Subroutine Quotient
; R2- Subroutine Remainder
1main:	IN R0, IN_PORT
ONES: CMP R0, 0x25		; R0 < 25?
		BRCS OUT_1
		CALL DIV_10
		MOV R0, R1
		BRN ONES
OUT_1:	OUT R2, OUT_PORT_1
TENS:	CMP R0, 0x02		; R0 < 2?
		BRCS OUT_10
		BREQ OUT_10
		CALL DIV_10
		MOV R0, R1
		BRN TENS
OUT_10:	OUT R2, OUT_PORT_10
		OUT R1, OUT_PORT_100
END:	BRN END

; Subroutine DIV_10
; Description:
; Subroutine divides input value by 10
; Parameter Registers:
; R0- Input
; R1- Quotient
; R2- Remainder
DIV_10:	
		MOV R1, 0x00	; Quotient/Counter
		MOV R2, R0		; Remainder
DIFF:	CMP R2, 0x0A
		BRCS END_SUB
		ADD R1, 0x01
		SUB R2, 0x0A
		BRN DIFF
END_SUB:RET

