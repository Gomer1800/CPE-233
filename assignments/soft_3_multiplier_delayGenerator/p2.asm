; Luis Gomez
; CPE 2333
;
; Program which reads in a value, and generates a delay of .5 seconds, then outputs value
;
; Given that each instruction ~ 40 ns, RAT MCU ~ 25MHZ. Let T = 40ns, such that:
;
;	T*{2+
;	[1+ 255(255*(94*2)+255* 3)+255*3] 			(loop1(loop2(loop3)))
;	[1+ 255(154*2)+255* 3]						(loop4(loop5))
;	[1+  75(2)]}								(loop6)
;	= .5 secs

; Registers Used:
;	R0- input value
;	R1- count 1, count 4, count 6
;	R2- count 2, count 5
;	R3- count 3

.EQU IN_PORT = 0x9A
.EQU OUT_PORT = 0x42
.EQU COUNT = 0xFF
.EQU COUNT_3 = 0x5E	; 94
.EQU COUNT_5 = 0x9A	; 154
.EQU COUNT_6 = 0x4B	; 74

.CSEG
.ORG 0x01

			IN R0, IN_PORT	; Start, read input
			MOV R1, COUNT
	loop1:	MOV R2, COUNT
	loop2:	MOV R3, COUNT_3
	loop3:	SUB R3, 1		; count3--
			BRNE loop3
			SUB R2, 1		; count2--
			BRNE loop2
			SUB R1, 1		; count1--
			BRNE loop1
			MOV R1, COUNT
	loop4:	MOV R2, COUNT_5
	loop5:	SUB R2, 1		; count5--
			BRNE loop5
			SUB R1, 1		; count4--
			BRNE loop4
			MOV R1, COUNT_6
	loop6:	SUB R1, 1		; count6--
			BRNE loop6
			OUT R0, OUT_PORT; end
			
			