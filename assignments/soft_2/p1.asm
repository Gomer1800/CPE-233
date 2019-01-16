.EQU IN_PORT = 0x30
.EQU OUT_PORT = 0x42
.ORG 0x01

start:	IN R1, IN_PORT
		CMP R1, 0x80
		BRCS less
		LSR R1
		LSR R1
		BRN output
less:	LSL R1
output:	OUT R1, OUT_PORT