.data
K:      .word       240

i:      .double     9.87,   8.56,   2.81,   7.34,   9.05,   6.16
        .double     6.89,   2.36,   5.18,   16.13,  18.2,   10.82
        .double     16.36,  4.22,   11.62,  5.51,   2.82,   17.43
        .double     9.78,   13.14,  6.44,   17.74,  14.01,  12.55
        .double     11.73,  7.5,    5.13,   5.57,   2.86,   10.65

W:      .double     19.2,   9.9,    15.3,   19.8,   8.3,    12.3
        .double     18.5,   11.1,   5.9,    10.4,   19.0,   7.7
        .double     8.4,    15.7,   1.6,    13.6,   2.3,    9.7
        .double     6.9,    14.3,   2.5,    5.1,    13.7,   15.7
        .double     14.1,   4.7,    12.2,   11.3,   9.5,    16.1

b:      .double     171.0           ;0xab in decimale
lim:    .double     2047.0          ;0x7ff in decimale

y:      .double     0.00

.text
main:
    lw R1, K(R0)
    daddi R2, R0, 0

loop:
    l.d F1, i(R2)
    l.d F2, W(R2)
    mul.d F3, F1, F2
    add.d F4, F4, F3
    daddi R2, R2, 8
    bne R1, R2, loop

    l.d F3, b(R0)
    add.d F4, F4, F3

    mfc1 R3, F4
    dsll R3, R3, 1
    dsrl R3, R3, 31
    dsrl R3, R3, 22

    ld R4, lim(R0)
    beq R3, R4, NaN

    s.d F4, y(R0)
    j end

NaN:
    sd R0, y(R0)

end:

    halt