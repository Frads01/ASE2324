                AREA    |.text|, CODE, READONLY
; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]            
				LDR 	R0, =stop					
                
				MOV 	R2, #0xB271
				; MOV	  R3, #0xC3A8
				MOV 	R3, #0xB271
				CMP 	R2, R3
				
				IT 		GT
				MOVGT 	R5, R3
				
				IT 		LT
				MOVLT 	R5, R2
				
				IT 		EQ
				LSLEQ 	R4, R3, #1
				ADDSEQ 	R4, R4, R2
				
stop            BX 		R0
                ENDP