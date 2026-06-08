.include "m328pdef.inc"      ; ATmega328P register definitions

.org 0x0000
rjmp MAIN

MAIN:
    ; Configure D13 as output
    sbi DDRB, 5

    ; Configure D2, D3, D4 as inputs
    cbi DDRD, 2
    cbi DDRD, 3
    cbi DDRD, 4

    ; Enable internal pull-up resistors
    sbi PORTD, 2
    sbi PORTD, 3
    sbi PORTD, 4

LOOP:

    ; Read inputs from PORTD
    in  r16, PIND

    ; U = !D2
    mov r17, r16
    lsr r17
    lsr r17
    andi r17, 0x01
    eor r17, 0x01

    ; V = !D3
    mov r18, r16
    lsr r18
    lsr r18
    lsr r18
    andi r18, 0x01
    eor r18, 0x01

    ; W = !D4
    mov r19, r16
    lsr r19
    lsr r19
    lsr r19
    lsr r19
    andi r19, 0x01
    eor r19, 0x01

    ; Compute W'
    mov r20, r19
    eor r20, 0x01

    ; Compute (V + W')
    or  r18, r20

    ; Compute I = U(V + W')
    and r17, r18

    ; Output result on D13
    tst r17
    breq LED_OFF

LED_ON:
    sbi PORTB, 5
    rjmp LOOP

LED_OFF:
    cbi PORTB, 5
    rjmp LOOP