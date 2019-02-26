;-----------------------------------------------------------------
; Peripheral_one
; by Luis Gomez, Jared Roscha
; date : 1/28/19
;
;	Drunken Sailor:	  A,    A,    A,   A,    A,    A,   A,   D,   F,  A
;			 Beats:	.25, .125, .125, .25, .125, .125, .25, .25, .25. 25
;	"What shall we do with the Drunken Sailor..."
;-----------------------------------------------------------------
.EQU INPUT = 0x02			; input value corresponding to note
.EQU SPEAKER_OUT = 0x03		; speaker port on fpga
.CSEG
.ORG 0x01

OUT 0x0A, SPEAKER_OUT			; A, 1/4 note
;DELAY FUNCTION .25 sec
OUT 0x0A, SPEAKER_OUT			; A, 1/8 note
;DELAY FUNCTION .125 sec
OUT 0x0A, SPEAKER_OUT			; A, 1/8 note
;DELAY FUNCTION .125 sec
OUT 0x0A, SPEAKER_OUT			; A, 1/4 note
;DELAY FUNCTION .25 sec
OUT 0x0A, SPEAKER_OUT			; A, 1/8 note
;DELAY FUNCTION .125 sec
OUT 0x0A, SPEAKER_OUT			; A, 1/8 note
;DELAY FUNCTION .125 sec
OUT 0x0A, SPEAKER_OUT			; A, 1/4 note
;DELAY FUNCTION .25 sec
OUT 0x03, SPEAKER_OUT			; D, 1/4 note
;DELAY FUNCTION .25 sec
OUT 0x06, SPEAKER_OUT			; F, 1/4 note
;DELAY FUNCTION .25 sec
OUT 0x0A, SPEAKER_OUT			; A, 1/4 note
;DELAY FUNCTION .25 sec

