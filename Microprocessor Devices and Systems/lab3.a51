RG   0H
	AJMP INIT
		ORG   13H  
		AJMP   SUBR1
		ORG   1Bh   	
		AJMP  SUBR2
		ORG   30H
		INIT:
MOV DPH,#80H
MOV DPL,#00H

MOV     A,#10000111b
MOVX    @DPTR,  A
INC     DPTR       
MOV     A,      #11000100b	
MOVX    @DPTR,  A
INC     DPTR
MOV     A,      #10110011b		
MOVX    @DPTR,  A
INC     DPTR
MOV     A,      #11110111b
MOVX    @DPTR,  A

MOV R6,#04h 
MOV B,R6
MOV 0c0h, #00000000B
MOV	IE,#00001100B
MOV	IP,#00001000b
MOV	TMOD, #10000000b	;
MOV	TCON,#01000100b 		
SETB EA

START: 	
MOV DPH, #80h
MOV DPL, #00h
MOV R6,B

CYCLE:	
clr 0c0h.6 	
clr 0c0h.7  
movx A, @dptr
mov R5, A
anl A, #0f0h 
acall calc
acall write
ACALL T_mal
ACALL T_bol		
clr 0c0h.6 	 
setb 0c0h.7  
mov A, R5
anl A, #0fh		
swap A       		
acall calc   
acall write  
ACALL T_mal	 	;t
ACALL T_bol 	;T
cjne r6,#1,count		
AJMP START

COUNT:	
INC DPTR				
djnz r6, cycle

CALC:			
rlc A 			
mov 00,C
rlc A			
mov 01,C
rlc A			
mov 02,C		
rlc A			
mov 03,C	
MOV C, 0C0h.0				
ANL C, /0C0h.1				
ORL C, /0C0h.2
CPL C
jnb 03, false_check	
jc done				    

fail:                           
setb 0c0h.6           
cpl 25h.3

done:                       		              
rlc A							
ret				
		
false_check:               
jnc done		   
jmp fail           

WRITE: 	   
ANL A, #00001111b				
ANL 0c0h, #11110000b			
orl 0c0h,A					
ret

T_mal:
MOV R2,#5 ;2
DELAY:
;650/2=325;325/5=65; 65-(16/5)=62
MOV R3,#63 ;2*R3*R2
DJNZ R3,$
DJNZ R2,DELAY
MOV 0c0h,#00000000b
RET

T_bol:
		MOV    R4,#14     	
		DJNZ   R4,$				
		RET		

prav:
ANL	A,#01111111B
MOVX @DPTR, A      
jmp	OUT1

SUBR1: 								
MOVX A,@DPTR
jnb 0c0h.7, prav  		
ANL	A,#11110111B  
MOVX @DPTR, A
		
OUT1:  	RETI

prav1:
ANL	A,#01111111B
ORL	A,#10000000B   
MOVX @DPTR, A       
jmp OUT2          

SUBR2:
MOVX A,@DPTR
jnb 0c0h.7, prav1      
ANL	A,#11110111B
ORL	A,#00001000B   
MOVX @DPTR, A
			
OUT2: clr ri
clr ti
RETI
END
