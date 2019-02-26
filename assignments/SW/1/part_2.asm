.EQU IN_PORT = 0x30
.EQU OUT_PORT = 0x40
.CSEG
.ORG 0x01

start:	IN R1, IN_PORT ; read 8-bit val
		MOV R0, 0xff ; loads 8-bit value (255)
		EXOR R1, R0 ; inverts R0
		ADD R1, 0x01 ; R0 + 1
		OUT R1, OUT_PORT ; output
		BRN start
		
		