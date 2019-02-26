.EQU IN_PORT = 0x30
.EQU OUT_PORT = 0x42

.CSEG
.ORG 0x01
	
	  IN R1, IN_PORT
	  TEST R1, 0x03	; z == 1, R1 is a multiple of 4
	  BREQ four:	; multiple of four branch	
	  TEST R1, 0x01	; z == 0, R1 is odd 
	  BRNE ODD
	  SUB R1, 1
	  BRN END
four: ADD R3, 0xFF
	  EXOR R1, R3
	  BRN END
 ODD: ADD R1, 17
	  LSR R1
 END: BRN END