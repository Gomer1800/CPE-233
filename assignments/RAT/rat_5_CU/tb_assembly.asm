.EQU SWITCH_PORT = 0x20	; port for switch input
.EQU LED_PORT = 0x40	; port for LED output

.CSEG
.ORG 0x10

main:	IN	R10, SWITCH)PORT
		MOV R11, 0xFF
		EXOR R10, R11
		OUT R10, LED_PORT
		BRN main