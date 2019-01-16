.CSEG
.ORG 0x40

main_loop:	MOV R29, 0xFC	; Move 252 to Reg 29
			ADD R29, 0x01	; R29 = 252 + 1
			MOV R30, 0xFA	; Move 250 to Reg 30
			MOV R31, 0x05	; Move 5 to Reg 31
			EXOR R30, R31	; 0000 0101 ( Bitwise EXOR ) 1111 1010 = 1111 1111 = 0xFF
			SUB R30, R29	; R30 = 255 - 253
			BRNE 0x41		; if Z = 0 go to line 41
			