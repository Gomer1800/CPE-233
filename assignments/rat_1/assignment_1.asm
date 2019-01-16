.EQU LED_PORT = 0x10	; output port
.CSEG
.ORG 0x40	; code starts here

; code seg 2: prog A
main_loop:	MOV	R10,0x05
			MOV R11,0x64
			ADD	R10,R11
			ADD	R10,0x14
			MOV	R20,R10
			OUT	R20,LED_PORT
			BRN	main_loop	; endless loop
			
			