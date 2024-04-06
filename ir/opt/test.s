    AREA MyProg, CODE, READONLY
    Entry
_start:
    ldr r0, =StartOR
    ldr r1, =Start
    ldrb r2, [r0]
    strb r2, [r1]
    add r0, r0, #1
    add r1, r1, #1
    mov r3, r2

copy:
    ldrb r4, [r0]
    strb r4, [r1]
    add r0, r0, #1
    add r1, r1, #1
    subs r3, r3, #1
    bne copy

    ldr r0, =Start
    ldrb r3, [r0]
    add r0, r0, #1

sort:
    mov r1, r0
    mov r2, r0
    add r2, r2, r3
    subs r4, r3, #1

inner_loop:
    ldrb r5, [r1]
    ldrb r6, [r1, #1]
    cmp r5, r6
    blt swap
    add r1, r1, #1
    subs r4, r4, #1
    bne inner_loop
    subs r3, r3, #1
    bne sort
    b exit

swap:
    strb r6, [r1]
    strb r5, [r1, #1]
    b inner_loop

exit:
    mov r7, #1
    swi 0

StartOR
    DCB 8, 0x3B, 0x5A, 0x51, 0x2F, 0xD1, 0x01, 0x2A, 0x12

    AREA mydata, DATA
Start DCB 1, 2, 3, 4, 5, 6, 7, 8, 9
    END


