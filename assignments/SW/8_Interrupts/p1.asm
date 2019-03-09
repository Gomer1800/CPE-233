; Luis Gomez
;
; This is an interrupt driven program that turns LEDS on and off
; Interrupt toggles LED output on and off, additionally the
; switch input is EXOR w/ the current LED output
; Input: 8-bit switch input from SWITCH_PORT
; Output: 8-bit led output from LED_PORT
.EQU LED_PORT = 0x42
.EQU SWITCH_PORT = 0x9A
.CSEG
.ORG 0x01
; Registers Used
;	R0 = LED TOGGLE
;	R1 = LED states
;	R2 = SWITCH states
;	R3 = Output
		MOV R0, 0x00
		MOV R1, 0x00
		MOV R3, 0x00
		SEI
loop:	OUT R3, LED_PORT	; Output LEDS
		BRN loop
		
ISR:	IN R2, SWITCH_PORT
		EXOR R0, 0x01		; Toggle LEDs
		EXOR R1, R2			; EXOR switches, LEDs
		CMP R0, 0x00		; Are LEDs Enabled?
		BRNE tog_on
		MOV R3, R0			; Output = Zero
		BRN exit
tog_on:	MOV R3, R1			; Output = LED states
exit:	RETIE

.ORG 0x3FF
		BRN ISR
		
		