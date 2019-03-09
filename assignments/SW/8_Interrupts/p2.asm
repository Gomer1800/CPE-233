; Luis Gomez
;
; This is an interrupt driven program that turns LEDS on and off
; Interrupt toggles LED output on and off, additionally the
; switch input is EXOR w/ the current LED output
; Input: 8-bit switch input from SWITCH_PORT
; Output: 8-bit led output from LED_PORT
.EQU LED_PORT = 0x42
.EQU SWITCH_PORT = 0x9A
.EQU BUTTON_PORT = 0x9B
.CSEG
.ORG 0x01
; Registers Used
;	R0 = LED TOGGLE
;	R1 = LED states
;	R2 = SWITCH states
;	R3 = Output
;	R4 = BUTTON TOGGLE
;	R5 = Button state
		MOV R0, 0x00
		MOV R1, 0x00
		MOV R2, 0x00
		MOV R3, 0x00
		MOV R4, 0x00
		SEI
loop:	OUT R3, LED_PORT			; Output LEDs
		BRN loop
;--------------------------------		
ISR:	IN R2, SWITCH_PORT
		CMP R4, R2					; Does current Switch input match previous?
		BREQ button
		EXOR R0, 0x01				; Toggle LED output
		EXOR R1, R2					; EXOR switches, leds
		CMP R0, 0x00
		BRNE tog_on
		MOV R3, R0					; LED toggle == OFF, output is 0x00
		BRN exit
tog_on:	MOV R3, R1					; LED toggle == ON, output is LED states
		BRN exit
button: IN R5, BUTTON_PORT			; Read button input until toggled
		CMP R5, 0x01
		BRNE button
		MOV R0, 0x01				; Enable LEDS
exit:	MOV R4, R2					; Previous Switch state = Current Switch State
		RETIE
;--------------------------------
.ORG 0x3FF
		BRN ISR
		
		