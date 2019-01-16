.EQU IN_PORT = 0x30
.EQU OUT_PORT = 0x40
.CSEG
.ORG 0x01

start:	IN R1, IN_PORT ; read val1
		IN R2, IN_PORT ; read val2
		IN R3, IN_PORT ; read val3
		ADD R1, R2 ; R1 + R2
		ADD R1, R3 ; Total sum
		OUT R1, OUT_PORT
		BRN start
		
		