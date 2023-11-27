                AREA    |.text|, CODE, READONLY
; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]            
				LDR 	R0, =stop					
                
				MOV 	R1, #0x00A0
				MOV 	R2, #0x0D00
				MOV 	R3, #0x0010
				MOV 	R5, #0x0000
				
loop			AND 	R4, R1, #1
				CMP 	R4, #0
				BNE		continue
				ADDS	R5, R5, #1
				LSR		R1, R1, #1
				B 		loop
				
continue		AND		R5, R5, #1
				CMP		R5, #0
				ITE		EQ
				SUBSEQ	R4, R2, R3
				ADDSNE	R4, R2, R3
				
stop            BX 		R0
                ENDP