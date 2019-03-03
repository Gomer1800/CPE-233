.EQU SWITCH_PORT = 0x20 ; port for switch input
.EQU LED_PORT = 0x40 ; port for LED output

.CSEG
.ORG 0x01

main:	IN R10,SWITCH_PORT	; R10 = input value from switch_port
		MOV R11,0xFF		; R11 = 0xFF
		EXOR R10,r11		; R10 = R10 EXOR R11
		OUT R10,LED_PORT	; output result to LED_PORT
		BRN main			; repeat
		
		