org $6000
ld de,16384
ld hl,theUdg
ld b,8
loop:
ld a,(hl)
ld (de),a
inc hl
inc d
djnz loop
ld a,(hl)
ld (22528),a
ret
theudg:
defb 24,36,114,249,251,126,126,60,20
