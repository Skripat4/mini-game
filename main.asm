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

DRAW_RECT:;function!
call GIVE_ADR
push de
ld b,3
l2:
ld c,32
ld a,e
add a,c
ld e,a
push de
djnz l2

;---------------------------------
ld hl,leftAngleTopRect
call draw_symb
pop de
ld a,e
add a,3
ld e,a
ld hl,rightAngleTopRect
call draw_symb
;------------------------------------
ld b,2
l3:
pop de
push de
ld hl,leftRect
push bc
call draw_symb
pop bc

pop de
ld a,e
add a,3
ld e,a
ld hl,rightRect
push bc
call draw_symb
pop bc
djnz l3
;-------------------------
pop de
push de
ld hl,leftAngleBottomRect
call draw_symb
pop de
push de
ld a,e
add a,3
ld e,a
ld hl,rightAngleBottomRect
call draw_symb
;-------------------------------
ld b,2
l4:
pop de
inc de
push de
ld hl,bottomRect
push bc
call draw_symb
pop bc

pop de
push de
ld a,e
add a,32*3
ld e,a
ld hl,topRect
push bc
call draw_symb
pop bc
djnz l4
pop bc
ret