                AREA    |.text|, CODE, READONLY
; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]            
				LDR     R0, =stop					
                
				MOV R1, #(valR1)
				MOV R3, #(valR3)
				MOV R4, #(valR4)
				
				ADDS	R2, R1, R3
				SUBS	R5, R4, R2
				
stop            BX 		R0
                ENDP