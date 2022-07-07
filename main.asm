;   7    6    5    4    3    2    1    0
;+----+----+----+----+----+----+----+-----+
;|  F |  B |  P |  P |  P |  I |  I |  I  |
;+----+----+----+----+----+----+----+-----+
; F - FLASH ON/OFF
; B - BRIGHT ON/OFF
; P - PAPER COLOR (background)
; I - INK COLOR (pen)
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
call DRAW_SPRITE_8X8

ld d,12
ld e,8
call DRAW_SPRITE_8X8

ld d,13
ld e,12
call DRAW_SPRITE_8X8

ret
theudg:
defb 24,36,114,249,251,126,126,60,20

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
pop AF
ret

DRAW_SPRITE_8x8:
call GIVE_ADR
LD D,H ;HL -> DE -> OFFSET ON SCREEN in MEMORY
LD E,L
ld hl,theUdg
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
