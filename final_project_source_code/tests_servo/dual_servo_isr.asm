.EQU IR_SENSOR_ID = 0xA6
.EQU SERVO_PORT_H = 0x49
.EQU SERVO_PORT_V = 0x50
.EQU VGA_PORT	= 0x93
.EQU LED_PORT   = 0x40
.EQU SEG_PORT   = 0x81
.EQU IN_PORT = 0x9A
.EQU OUT_PORT = 0x42

.EQU VGA_HADD = 0x90
.EQU VGA_LADD = 0x91
.EQU VGA_COLOR = 0x92
.EQU BG_COLOR = 0xFF             ; Background:  white
.EQU BG_COLOR_2 = 0x00           ; Background:  black

.EQU COUNT = 0xFF	; 255
.EQU COUNT_3 = 0x5E	; 94
.EQU COUNT_5 = 0x9A	; 154
.EQU COUNT_6 = 0x4B	; 74

.CSEG
.ORG 0x01

;Register Uses:
;R6 - saves color obtained from the sensor digital value
;R7 - Y position
;R8 - X position
;R11- Vert Servo Counter
;R12- CW servo command
;R13- Horiz Servo Counter
;R14- Reset CCW servo command
;R15- Indicator LED
;---------------------------------------------------------------------
; Initial declarations
reset:
		MOV		R6,BG_COLOR
		CALL 	draw_background
		CALL	delay		
		MOV		R11,0x00
		MOV		R12,0x01
		MOV		R13,0x00
		MOV		R14,0x04
		MOV		R15,0x00
		OUT		R15,LED_PORT
		MOV 	R7, 0x00	
		MOV		R8, 0x00
		
		SEI
scan:
		CMP		R11,0x28
		BREQ	end
R:
		OUT		R13,SEG_PORT
		CMP		R13,0x50
		BREQ	L
		ADD		R13,0x01
		OUT		R12,SERVO_PORT_H
		CALL	delay
		BRN		R
L:
		MOV		R13,0x00
		OUT		R13,SEG_PORT
		OUT		R14,SERVO_PORT_H
		CALL	delay
		CALL	delay
		CALL	delay
D:
		ADD		R11,0x01
		OUT		R12,SERVO_PORT_V
		CALL	delay
		BRN		scan		
end:
		OUT		R15,LED_PORT
		BRN		reset

;--------------------------------------------------------------------
;-  Subroutine: draw_horizontal_line
;-
;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
;-
;-  Parameters:
;-   r8  = starting x-coordinate
;-   r7  = y-coordinate
;-   r9  = ending x-coordinate
;-   r6  = color used for line
;- 
;- Tweaked registers: r8,r9
;--------------------------------------------------------------------
draw_horizontal_line:
		ADD    R9,0x01			; go from r8 to r15 inclusive
		
draw_horiz1:
		CALL	draw_dot 
		ADD		R8,0x01
		CMP		R8,R9
		BRNE	draw_horiz1
		RET
;--------------------------------------------------------------------

;---------------------------------------------------------------------
;-  Subroutine: draw_background
;-
;-  Fills the 80x60 grid with one color using successive calls to 
;-  draw_horizontal_line subroutine. 
;- 
;-  Tweaked registers: r10,r7,r8,r9
;----------------------------------------------------------------------
draw_background:
		MOV		R10,0x00			;R10 keeps track of rows
start:	MOV		R7,R10              ;load current row count 
		MOV		R8,0x00             ;restart x coordinates
		MOV		9,0x4F 				;set to total number of columns

		CALL	draw_horizontal_line
		ADD		R10,0x01            ;increment row count
		CMP		R10,0x3C            ;see if more rows to draw
		BRNE	start               ;branch to draw more rows
		RET
;---------------------------------------------------------------------
    
;---------------------------------------------------------------------
;- Subrountine: draw_dot
;- 
;- This subroutine draws a dot on the display the given coordinates: 
;- 
;- (X,Y) = (r8,r7)  with a color stored in r6  
;-
;---------------------------------------------------------------------
draw_dot:
		OUT		R8,VGA_LADD  		;write bot 8 address bits to register
		OUT		R7,VGA_HADD   		;write top 5 address bits to register
		OUT		R6,VGA_COLOR  		;write color data to frame buffer
		RET
; --------------------------------------------------------------------

;---------------------------------------------------------------------
;- Subrountine: delay
;- 
;- This subroutine generates a ~1 second delay: 
;- 
;- Tweaked Registers, R0, R1, R2 

;---------------------------------------------------------------------
delay:
		MOV R0, COUNT
loop1:	MOV R1, COUNT
loop2:	MOV R2, COUNT_3
loop3:	SUB R2, 1		; count3--
		BRNE loop3
		SUB R1, 1		; count2--
		BRNE loop2
		SUB R0, 1		; count1--
		BRNE loop1
		MOV R0, COUNT
loop4:	MOV R1, COUNT_5
loop5:	SUB R1, 1		; count5--
		BRNE loop5
		SUB R0, 1		; count4--
		BRNE loop4
		MOV R0, COUNT_6
loop6:	SUB R0, 1		; count6--
		BRNE loop6
		RET
		
; --------------------------------------------------------------------
;- Interupt service routine
;-
;- Paints a pixel in the VGA when an interrupt is triggered according to
;- the 8 - bit value digital input from the sensor
;-
;- R4 - input port from the sensor
; --------------------------------------------------------------------
ISR: 	IN 		R4,IR_SENSOR_ID
		MOV		R6,R4          	    ;color from sensor
output:	OUT		R8,VGA_LADD  		;write bot 8 address bits to register
		OUT		R7,VGA_HADD   		;write top 5 address bits to register
		OUT		R6,VGA_COLOR  		;write color data to frame buffer

incr:	ADD R8, 0x01
		CMP R8, 0x50
		BRNE return 				;if equal to 0 go to next row
		CLC
		ADD R7, 0x01
		MOV R8, 0x00
		CMP	R7,0x3C
		BRNE return		
		MOV R7, 0x00
		CLC
return:	RETIE

		
.CSEG
.ORG 0x3FF
VECTOR:	BRN		ISR
