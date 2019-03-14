.CSEG
.ORG 0x10

.EQU IRSENSOR_ID = 0xA6
.EQU COUNT = 0xFF
.EQU COUNT_3 = 0x5E	; 94
.EQU COUNT_5 = 0x9A	; 154
.EQU COUNT_6 = 0x4B	; 74

.EQU VGA_HADD = 0x90
.EQU VGA_LADD = 0x91
.EQU VGA_COLOR = 0x92
.EQU BG_COLOR = 0xFF             ; Background:  white
.EQU BG_COLOR_2 = 0xFF           ; Background:  black

;Register Uses:
;R6 - saves color obtained from the sensor digital value
;R7 - Y position
;R8 - X position

;---------------------------------------------------------------------
; Initial declarations
		CALL 	draw_background
		MOV 	R7, 0x00	
		MOV		R8, 0x00
		SEI
main:
		MOV 	R0, R0			;line for infinite loop
		OUT		R0, 0x40
		BRN 	main

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
;		CMP 	R0,0x00
;		BRNE	color2
		MOV		R6,BG_COLOR_2		;use default color
;		BRN		setup
;color2:	MOV		R6,BG_COLOR_2	
setup:	MOV		R10,0x00			;R10 keeps track of rows
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

;---------------------------------------------------------------------
draw_dot:
		OUT		R8,VGA_LADD  		;write bot 8 address bits to register
		OUT		R7,VGA_HADD   		;write top 5 address bits to register
		OUT		R6,VGA_COLOR  		;write color data to frame buffer
		RET
; --------------------------------------------------------------------

; --------------------------------------------------------------------
; Interupt service routine
; Paints a pixel in the VGA when an interrupt is triggered according to
; the 8 - bit value digital input from the sensor
; Tweaked registers
; R4 - input port from the sensor
; --------------------------------------------------------------------
ISR: 	IN 		R4, IRSENSOR_ID
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


