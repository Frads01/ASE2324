                AREA    MyData, DATA, READWRITE
Calories_food_ordered	SPACE 28
Calories_sport_ordered	SPACE 12

                AREA    |.text|, CODE, READONLY
Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
				
				LDR		R10, =Calories_food_ordered
				LDR		R1, =Calories_food
				LDR		R2, =Num_days
				LDRB	R2, [R2]
				BL		ORDER_SUB
				
				LDR		R10, =Calories_sport_ordered
				LDR		R1, =Calories_sport
				LDR		R2, =Num_days_sport
				LDRB	R2, [R2]
				BL		ORDER_SUB
				
; --------------------------------------

				MOV		R9, #0			; flag: se 0 salvo max, se 1 salvo min
				MOV		R10, #0			; cals giorno meno calorico
				MOV 	R11, #0			; ID giorno meno calorico
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
				CMP		R9, #0
				BNE		SAVE_MIN
				
SAVE_FIRST		MOV		R11, R4
				MOV		R10, R5
				ADDS	R9, R9, #1
				B		CONTINUE
				
SAVE_MIN		CMP		R10, R5
				ITT		GT
				MOVGT	R11, R4
				MOVGT	R10, R5	
				
CONTINUE		SUBS    R1, R1, #1
                CMP     R1, #0
                BNE     DAY_LOOP
        
STOP            B       STOP
                ENDP

; ------------------- ;
;	ORDER PROCEDURE   ;
; ------------------- ;
					
ORDER_SUB 		PROC
				PUSH	{R10, R1, R2, LR}
				LDR		R0, =0
OUTER_LOOP		LDR		R4, [R1], #4			; day
				LDR		R5, [R1], #4			; cals
				LDR		R3, =0					; inner index
				ADDS	R6, R13, #16			
INN_LOOP		CMP		R3, R0
				BEQ		INSERT			
				LDR		R7, [R6]				; inner day
				ADDS	R6, R6, #4		
				LDR		R8, [R6]				; inner cals
				ADDS	R6, R6, #4		
				CMP		R5, R8
				BLE		CONT1
				STR		R4, [R6, #-8]
				STR		R5, [R6, #-4]
				MOV		R4, R7
				MOV		R5, R8
CONT1			ADDS	R3, R3, #1
				B		INN_LOOP
INSERT			STM 	R6, {R4, R5} 
				ADDS	R0, R0, #1
				CMP		R0, R2
				BNE 	OUTER_LOOP
				
				LDR		R0, =0					; outer index
				ADDS	R6, R13, #16				
ADD_LOOP		CMP		R0, R2
				BEQ		CONT2
				LDR		R3, [R6]
				ADDS	R6, R6, #8
				STR		R3, [R10]
				ADDS	R10, R10, #4
				ADDS	R0, R0, #1
				B		ADD_LOOP
				
CONT2			POP		{R10, R1, R2, PC}
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