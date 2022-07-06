org $6000
ld d,5
ld e,3
call GIVE_ADR
push hl
ld hl,theUdg
ld b,8
loop:
ld a,(hl)
ld (de),a
inc hl
inc d
djnz loop
ld a,(hl)
;ld (22528),a
pop hl
ld (hl),a
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