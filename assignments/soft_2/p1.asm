.EQU IN_PORT = 0x30
.EQU OUT_PORT = 0x42
.ORG 0x01

start:	IN R1, IN_PORT
		CMP R1, 0x80
		BRCS less			; is c == 1, jump to less
		LSR R1				; divide R1 by 2
		LSR R1				; divide R1 by 2
		BRN output
less:	LSL R1				; multiply R1 by 2
output:	OUT R1, OUT_PORT