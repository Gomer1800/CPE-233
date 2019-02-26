.EQU PWM_OUT = 0x03 ; pwm port on fpga
.CSEG
.ORG 0x01

; delay Immed -> PORT
; delay Reg -> PORT
; Immed or Reg values are 8-bit inputs to the PWM generator

	IN	R1, 0x00
	CALL delay 0xFF
	CALL delay R1
