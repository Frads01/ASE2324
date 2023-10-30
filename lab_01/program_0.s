.data
v1:  	.byte    	2, 6, -3, 11, 9, 11, -3, 6, 2
v2:  	.byte    	4, 7, -10,3, 11, 9, 7, 6, 4, 7
v3:  	.byte    	9, 22, 5, -1, 9, -1, 5, 22, 9
flag1: 	.space      1
flag2: 	.space      1
flag3: 	.space      1
v4:  	.space      9    

.text
main:   daddi R1, R0, 0     ; indice vettore
        daddi R9, R0, 9

iset:   daddi R3, R0, 0     ; indice iniziale Vn
        daddi R2, R0, 8     ; indice finale Vn
        daddi R6, R0, 0     ; registro per salvare stato palindromo
        daddi R8, R0, 0

        daddi R7, R0, 0
        beq R1, R7, v1
        daddi R7, R0, 1
        beq R1, R7, v2
        daddi R7, R0, 2
        beq R1, R7, v3
        j end

v1:     lb R4, v1(R3)
        lb R5, v1(R2)
        j loop
        sb R6, flag1(R0)
        j iset
v2:     lb R4, v2(R3)
        lb R5, v2(R2)
        j loop
        sb R6, flag2(R0)
        j iset
v3:     lb R4, v3(R3)
        lb R5, v3(R2)
        j loop
        sb R6, flag3(R0)
        j iset

loop:   beq R4, R5, strue

sfalse: daddi R6, R0, 0
        j return

strue:  daddi R6, R0, 1
        daddi R3, R3, 1
        daddi R2, R2, -1
        beq R2, R3, sum ;; se palindromo somma

        daddi R7, R0, 0
        beq R1, R7, v1
        daddi R7, R0, 1
        beq R1, R7, v2
        daddi R7, R0, 2
        beq R1, R7, v3
        
sum:    beq R8, R9, return

        daddi R7, R0, 0
        beq R1, R7, s1
        daddi R7, R0, 1
        beq R1, R7, s2
        daddi R7, R0, 2
        beq R1, R7, s3

s1:     lb R2, v1(R8)
        daddi R3, R0, 0
        j cont
s2:     lb R2, v2(R8)
        lb R3, v4(R8)
        j cont
s3:     lb R2, v3(R8)
        lb R3, v4(R8)

cont:   dadd R3, R3, R2
        sb R3, v4(R8)
        daddi R8, R8, 1
        j sum

return: daddi R1, R1, 1
        j iset

end:    halt

