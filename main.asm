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
call FUNC_DRAW_RECT

ld d,12
ld e,8
call DRAW_SPRITE_8X8

ld d,13
ld e,12
call DRAW_SPRITE_8X8


ld a,2
call 5633
ld de,string
ld bc,eostr-string
call 8252

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
leftRect:
defb 128,128,128,128,128,128,128,128

variable:
defw 5

string defb 16,4,17,1,22,3,11,"THE GAME"
eostr defb 0

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
;DE -> OFFSET ON SCREEN in MEMORY

ld hl,theUdg
DRAW_SYMB:
ld b,8
loop:
ld a,(hl)
ld (de),a
inc hl
inc d
djnz loop
ret
FUNC_DRAW_RECT:
ld d,3;x
ld e,1 ;y
push de
call give_adr
ld hl,leftAngleBottomRect
call draw_symb
ld b,3
hoho:
pop de
inc d
push de
push bc
call give_adr
ld hl,bottomRect
call draw_symb
pop bc
djnz hoho

pop de
inc d
push de
call give_adr
ld hl,rightAngleBottomRect
call draw_symb
ld b,7
hoho2:
pop de
inc e
push de
push bc
call give_adr
ld hl,rightRect
call draw_symb
pop bc
djnz hoho2
pop de
inc e
push de
call give_adr
ld hl,rightAngleTopRect
call draw_symb
ld b,3
hoho3:
pop de
dec d
push de
push bc
call give_adr
ld hl,topRect
call draw_symb
pop bc
djnz hoho3
pop de
dec d
push de
call give_adr
ld hl,leftAngleTopRect
call draw_symb
ld b,7
hoho4:
pop de
dec e
push de
push bc
call give_adr
ld hl,leftRect
call draw_symb
pop bc
djnz hoho4
pop de 
exit:
RET


;               0     1     2    3     4     5     6      7     8    9     10    11    12    13    14    15    16    17   18     19     20    21      
tableY: defw 16384,16416,16448,16480,16512,16544,16576,16608,18432,18464,18496,18528,18560,18592,18624,18656,20480,20512,20544,20576,20608,20640