                AREA    |.text|, CODE, READONLY

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
				
				MOV 	R11, #0
                LDR     R2, =Calories_food
				LDR     R1, =Num_days
				LDRB	R1, [R1]
				
DAY_LOOP        LDR    	R4, [R2], #4	; giorno_cibo
                LDR    	R5, [R2], #4	; cal_cibo
				LDR     R3, =Calories_sport
				LDR 	R8, =Num_days_sport
				LDRB	R8, [R8]	
				
SPORT_LOOP		LDR		R6, [R3], #4	; giorno_sport
				CMP 	R4, R6			; confronto i 2 giorni
				BEQ		SUB_SPORT
				SUBS	R8, R8, #1
				ADDS	R3, R3, #4
				CMP		R8, #0
				BNE		SPORT_LOOP
				B		CONTINUE
				
SUB_SPORT		LDR		R7, [R3], #4	; cal_sport
				SUBS	R5, R5, R7
CONTINUE		PUSH    {R4, R5}
                SUBS    R1, R1, #1
                CMP     R1, #0
                BNE     DAY_LOOP
				
				LDR     R1, =Num_days
				LDRB	R1, [R1]
COUNT_LOOP		POP		{R4, R5}
				CMP		R5, #500
				IT		LT
				ADDSLT	R11, R11 ,#1
                SUBS    R1, R1, #1
                CMP     R1, #0
                BNE     COUNT_LOOP
        
STOP            B       STOP
                ENDP
                LTORG

 ; data section start -------------------------
                ALIGN 2
                SPACE 4096
Days			DCB 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07

Calories_food 	DCD 0x06, 1300, 0x03, 1700, 0x02, 1200, 0x04, 1900, 0x05, 1110, 0x01, 1670, 0x07, 1000

Calories_sport	DCD 0x02, 500, 0x05, 800, 0x06, 400

Num_days	    DCB 7
Num_days_sport	DCB 3
                