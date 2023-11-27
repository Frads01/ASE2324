                AREA    |.text|, CODE, READONLY
; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]            
				LDR 	R0, =stop					
                
				MOV 	R2, #0xB271
				MOV 	R3, #0xC3A8
				; MOV 	  R3, #0xB271
				CMP 	R2, R3
				BNE		Not_Equal
				BEQ 	Equal

Not_Equal		BGT 	Assign_R3
				MOV 	R5, R2
				BX 		R0
				
Assign_R3		MOV 	R5, R3
				BX 		R0

Equal			LSL 	R4, R3, #1
				ADDS 	R4, R4, R2
				BX 		R0
				
stop            BX 		R0
                ENDP