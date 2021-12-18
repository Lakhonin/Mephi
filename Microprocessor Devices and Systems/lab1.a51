;Вариант 16
;F = ^(X v ^Y & ^Z)
;Сигнал разрешения - высокий
;Сигнал потверждения - высокий

ORG 0000h
	BEGIN: MOV 00h, #60d
	MOV 08h, #20d
	MOV 10h, #40d
	MOV 18h, #50d
	MOV 0C0h, #00111111b
	metka: JNB 0C0h.3,$
		MOV A, 0C0h
		MOV C, 0C0h.5
		MOV psw.4, C
		MOV C, 0C0h.4
		MOV psw.3, C
		MOV C, 0C0h.0
		ORL C, /0C0h.1
		ANL C, /0C0h.2
		CPL C
			MOV 0C0h.7,C
			SETB 0C0h.6
			JB 0C0h.3, $
			ANL A, #7h
			RLC A
			MOV @R0, A
			INC R0
			CLR 0C0h.6
			AJMP metka
	END
