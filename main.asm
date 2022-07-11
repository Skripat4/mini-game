;   7    6    5    4    3    2    1    0
;+----+----+----+----+----+----+----+-----+
;|  F |  B |  P |  P |  P |  I |  I |  I  |
;+----+----+----+----+----+----+----+-----+
; F - FLASH ON/OFF
; B - BRIGHT ON/OFF
; P - PAPER COLOR (background)
; I - INK COLOR (pen)



;  15   14   13   12   11   10    9    8     7   6   5  4   3   2   1   0
;+----+----+----+----+----+----+----+-----0---+---+---+---+---+---+---+---+
;|  0 |  1 |  0 |  1 |  1 |  0 |  X |  X  0 X | X | X | X | X | X | X | X |
;+----+----+----+----+----+----+----+-----0---+---+---+---+---+---+---+---+
;  |____________________|    |______________________|   |________________|
;   Attributes adress begin    Number Rows                Number Column
;        22528                       0..23                   0..31
;


org $6000
ld hl,22528
ld a,12
loop1:
ld b,16
row1:
inc hl
ld (hl),120
inc hl
djnz row1
ld b,16
row2:
ld (hl),120; (248) <- its flash on
inc hl
inc hl
djnz row2
dec a
jr nz,loop1



ld d,0
ld e,1
call DRAW_SPRITE_8X8

ld d,5
ld e,2
call DRAW_RECT

ld d,12
ld e,8
call DRAW_SPRITE_8X8

ld d,13
ld e,12
call DRAW_SPRITE_8X8

ret
theudg:
defb 24,36,114,249,251,126,126,60,20

leftAngleBottomRect:
defb 255,128,128,128,128,128,128,128
bottomRect:
defb 255,0,0,0,0,0,0,0 
rightAngleBottomRect:
defb 255,1,1,1,1,1,1,1
topRect:
defb 0,0,0,0,0,0,0,255
rightRect:
defb 1,1,1,1,1,1,1,1
rightAngleTopRect:
defb 1,1,1,1,1,1,1,255
leftAngleTopRect:
defb 128,128,128,128,128,128,128,255 

variable:
defw 5

GIVE_ADR:
PUSH AF

LD a,e
and $18
or $40
LD h,a
ld a,e
and 7
or a
RRA
RRA
RRA
RRA
add a,d
ld l,a
push hl ; ld de,hl
pop de
pop AF
ret

DRAW_SPRITE_8x8:
call GIVE_ADR
ld hl,theUdg
DRAW_SYMB:
ld b,8
loop:
ld a,(hl)
ld (de),a
inc hl
inc d
djnz loop
ld a,(hl)
ld (hl),a
ret
DRAW_RECT:;function draw rect on the screen (thank's cap)
call GIVE_ADR
PUSH HL
ld hl,leftAngleBottomRect
call DRAW_SYMB
CYCLE_FOR:
POP HL
inc HL
push hl
pop de
PUSH HL
ld hl,bottomRect
call DRAW_SYMB
PUSH HL
ld hl,variable
ld a,(HL)
dec a
jr nz,haha
ld (HL),a
POP HL
jp gogo
haha:
ld (HL),a
POP HL
jp CYCLE_FOR
gogo:
pop HL
inc HL
push hl
pop de
push hl
ld hl,rightANgleBottomRect
call DRAW_SYMB
ld hl,variable
ld (hl),4

CYCLE_FOR2:
pop hl

ld de,32
adc hl,de
push HL
pop DE
push hl
ld hl,rightRect
call DRAW_SYMB
push hl
ld hl,variable
ld a,(HL)
dec a
jr nz,haha2
ld (HL),a
POP HL
jp gogo2
haha2:
ld (HL),a
POP HL
jp CYCLE_FOR2
gogo2:
pop HL
ld de,32
adc hl,de
push HL
pop DE
push hl
ld hl,rightAngleTopRect
call DRAW_SYMB
pop hl


ret