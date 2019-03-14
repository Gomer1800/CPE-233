.EQU SERVO_PORT = 0x49
.EQU LED_PORT   = 0x40

.CSEG
.ORG 0x10

	MOV R2,0x00
	MOV R1,0x01
	MOV R0,0x00
R:
	CMP R0,0x0A
	BREQ end1
	ADD R0,0x01
	OUT R1,SERVO_PORT
	OUT R2,SERVO_PORT
	BRN R
end1:
	MOV R2,0x01
	OUT R2,LED_PORT
end2:
	BRN end2
	
	