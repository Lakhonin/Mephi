BUFF equ 21H

ORG 0H
AJMP START
ORG 03H
AJMP SUBR1
ORG 30H
	
START:
MOV IE,#00000001B
MOV TMOD,#00000001B
SETB EA
CLR	TR0

MOV DPH,#80H
MOV DPL,#00H
MOV 0C0h,#0
MOVX A,@DPTR
MOV R5,#2
ACALL CYCLE

M1:
INC DPTR
MOV R5,#2
MOVX A,@DPTR
AJMP CYCLE

M2:
SWAP A
MOV R6,A

CYCLE:
ACALL FUNC
ACALL SEND
ACALL CHECK
MOV A,R6
MOV R0,#65
MOV R1,#6

WAIT1:	
MOV	TH0,#0D8H ;255-216=39; 255*39=9945
MOV	TL0,#0C8H ;255-(10000-9945)=200
SETB TR0

WAIT2:	
JBC	TF0,EXIT1
SJMP WAIT2

EXIT1:	
CLR	TR0
DJNZ R0,WAIT1

MOV 0C0h,#00000000b

WAIT3:	
MOV	TH0,#0D8H ;255-216=39; 255*39=9945 ���
MOV	TL0,#0C8H ;255-(10000-9945)=200
SETB TR0

WAIT4:	
JBC	TF0,EXIT2
SJMP WAIT4

EXIT2:	
CLR	TR0
DJNZ R1,WAIT3


DJNZ R5,M2
AJMP M1

SUBR1:
ACALL UPDATE
RETI

UPDATE:
DJNZ R5,M3
MOV BUFF,A
SETB BUFF.0
MOV A, BUFF
SWAP A 
MOVX @DPTR,A
INC R5
RET

M3:
MOV BUFF,A
SETB BUFF.0
MOV A,BUFF
MOVX @DPTR,A
INC R5
RET

FUNC:
MOV BUFF,A
MOV R6,A
MOV C,BUFF.3
ORL C,/BUFF.2
ANL C,/BUFF.1
CPL C
MOV BUFF.0,C
RET

CHECK:
XRL A,BUFF
CLR 0C0h.6
JZ CHECKED
SETB 0C0h.6
RET

CHECKED:
RET

SEND:
MOV A,R6
ANL A,#00001111b
MOV 0C0h,A
MOV A,R6
RET

END