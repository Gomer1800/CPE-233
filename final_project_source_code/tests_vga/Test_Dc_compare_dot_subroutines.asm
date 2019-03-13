;---------------------------------------------------------------------
; An expanded "draw_dot" program that includes subrountines to draw
; vertical lines, horizontal lines, and a full background. 
; 
; As written, this programs does the following: 
;   1) draws a the background blue (draws all the tiles)
;   2) draws a red dot
;   3) draws a red horizontal lines
;   4) draws a red vertical line
;
; Author: SHANE KENT
; Modifications: Brett Glidden, Paul Hummel, Bridget Benson
;---------------------------------------------------------------------

.CSEG
.ORG 0x10

;.EQU COUNT = 0xFF
;.EQU COUNT_3 = 0x5E	; 94
;.EQU COUNT_5 = 0x9A	; 154
;.EQU COUNT_6 = 0x4B	; 74

.EQU VGA_HADD = 0x90
.EQU VGA_LADD = 0x91
.EQU VGA_COLOR = 0x92

.EQU BG_COLOR = 0xFF             ; Background:  white
.EQU BG_COLOR_2 = 0x00             ; Background:  black
;r6 is used for color
;r7 is used for Y
;r8 is used for X

;---------------------------------------------------------------------
		SEI
		MOV		r0,0x00			
init:	CALL	draw_background         ; draw using default color
		
		MOV		r1,0x02                ; color blue
		MOV		r2,0x00                ; generic Y coordinate
		MOV		r3,0x28                ; generic X coordinate
		CALL	draw_dot_2
		
		MOV		r6,0xE0                ; color red
		MOV		r7,0x1E                ; generic Y coordinate
		MOV		r8,0x28                ; generic X coordinate
		CALL	draw_dot              ; draw red square
		
		BRN		init                    ; continuous loop 
;--------------------------------------------------------------------

;--------------------------------------------------------------------
;-  Subroutine: half delay
;-
;-  generates half second delay
;-
;-  Parameters:
;-   r1  = count 1, 4, 6
;-   r2  = count 2, 5
;-   r3  = count 3
;- 
;- Tweaked registers: r1,r2,r3
;--------------------------------------------------------------------
;half_delay:
;			MOV R1, COUNT
;	loop1:	MOV R2, COUNT
;	loop2:	MOV R3, COUNT_3
;	loop3:	SUB R3, 1		; count3--
;			BRNE loop3
;			SUB R2, 1		; count2--
;			BRNE loop2
;			SUB R1, 1		; count1--
;			BRNE loop1
;			MOV R1, COUNT
;	loop4:	MOV R2, COUNT_5
;	loop5:	SUB R2, 1		; count5--
;			BRNE loop5
;			SUB R1, 1		; count4--
;			BRNE loop4
;			MOV R1, COUNT_6
;	loop6:	SUB R1, 1		; count6--
;			BRNE loop6
;			RET
;--------------------------------------------------------------------

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
		ADD    r9,0x01          ; go from r8 to r15 inclusive
		
draw_horiz1:
		CALL	draw_dot 
		ADD		r8,0x01
		CMP		r8,r9
		BRNE	draw_horiz1
		RET
;--------------------------------------------------------------------


;---------------------------------------------------------------------
;-  Subroutine: draw_vertical_line
;-
;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
;-
;-  Parameters:
;-   r8  = x-coordinate
;-   r7  = starting y-coordinate
;-   r9  = ending y-coordinate
;-   r6  = color used for line
;- 
;- Tweaked registers: r7,r9
;--------------------------------------------------------------------
draw_vertical_line:
		ADD		r9,0x01

draw_vert1:
		CALL	draw_dot
		ADD		r7,0x01
		CMP		r7,R9
		BRNE	draw_vert1
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
		CMP 	r0,0x00
		BRNE	color2
		MOV		r6,BG_COLOR              ; use default color
		BRN		setup
color2:	MOV		r6,BG_COLOR_2	
setup:	MOV		r10,0x00                 ; r10 keeps track of rows
start:	MOV		r7,r10                   ; load current row count 
		MOV		r8,0x00                  ; restart x coordinates
		MOV		r9,0x4F 					; set to total number of columns

		CALL	draw_horizontal_line
		ADD		r10,0x01                 ; increment row count
		CMP		r10,0x3C                 ; see if more rows to draw
		BRNE	start                    ; branch to draw more rows
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
		OUT		r8,VGA_LADD   ; write bot 8 address bits to register
		OUT		r7,VGA_HADD   ; write top 5 address bits to register
		OUT		r6,VGA_COLOR  ; write color data to frame buffer
		RET
; --------------------------------------------------------------------

;---------------------------------------------------------------------
;- Subrountine: draw_dot
;- 
;- This subroutine draws a dot on the display the given coordinates: 
;- 
;- (X,Y) = (r6,r5)  with a color stored in r6  

;---------------------------------------------------------------------
draw_dot_2:
		OUT		r3,VGA_LADD   ; write bot 8 address bits to register
		OUT		r2,VGA_HADD   ; write top 5 address bits to register
		OUT		r1,VGA_COLOR  ; write color data to frame buffer
		RET
; --------------------------------------------------------------------
ISR:
		EXOR	r0,0x01
		RETIE
	
.CSEG
.ORG 0x3FF
VECTOR:	BRN		ISR






