HealParty:
    xor a
    ld [wCurPartyMon], a
    ld hl, wPartySpecies
.loop
    ld a, [hli]
    cp -1
    jr z, .done
    cp EGG
    jr z, .next
    push hl
    
    ; Check if the Pokémon currently has or previously had Pokérus
    push bc
    ld a, [wCurPartyMon]
    ld bc, PARTYMON_STRUCT_LENGTH
    ld hl, wPartyMon1 + MON_POKERUS  ; <-- FIXED HERE
    call AddNTimes
    ld a, [hl]
    pop bc
    and a ; Check if the byte is non-zero
    jr nz, .skip_pokerus ; If non-zero, they already had or have it, so skip
    
    ; Check if holding a Nugget
    push bc
    ld a, [wCurPartyMon]
    ld bc, PARTYMON_STRUCT_LENGTH
    ld hl, wPartyMon1 + MON_ITEM     ; <-- FIXED HERE
    call AddNTimes
    ld a, [hl]
    cp NUGGET
    pop bc
    jr nz, .skip_pokerus ; Skip if not holding a Nugget
    
    ; 25% chance check
    call Random
    cp 25 percent
    jr nc, .skip_pokerus
    
    ; Give Pokérus
    push bc
    ld a, [wCurPartyMon]
    ld bc, PARTYMON_STRUCT_LENGTH
    ld hl, wPartyMon1 + MON_POKERUS  ; <-- FIXED HERE
    call AddNTimes
    ld [hl], $11 ; Give active Pokérus strain
    pop bc

.skip_pokerus
    call HealPartyMon
    pop hl
.next
    ld a, [wCurPartyMon]
    inc a
    ld [wCurPartyMon], a
    jr .loop
.done
    ret

HealPartyMon:
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld d, h
	ld e, l

	ld hl, MON_STATUS
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a

	ld hl, MON_MAXHP
	add hl, de

	; bc = MON_HP
	ld b, h
	ld c, l
	dec bc
	dec bc

	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hl]
	ld [bc], a

	farcall RestoreAllPP
	ret

ComputeHPBarPixels:
; e = bc * HP_BAR_LENGTH_PX / de
	ld a, b
	or c
	jr z, .zero
	push hl
	xor a
	ldh [hMultiplicand + 0], a
	ld a, b
	ldh [hMultiplicand + 1], a
	ld a, c
	ldh [hMultiplicand + 2], a
	ld a, HP_BAR_LENGTH_PX
	ldh [hMultiplier], a
	call Multiply
	; We need de to be under 256 because hDivisor is only 1 byte.
	ld a, d
	and a
	jr z, .divide
	; divide de and hProduct by 4
	srl d
	rr e
	srl d
	rr e
	ldh a, [hProduct + 2]
	ld b, a
	ldh a, [hProduct + 3]
	srl b
	rr a
	srl b
	rr a
	ldh [hDividend + 3], a
	ld a, b
	ldh [hDividend + 2], a
.divide
	ld a, e
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 3]
	ld e, a
	pop hl
	and a
	ret nz
	ld e, 1
	ret

.zero
	ld e, 0
	ret

AnimateHPBar:
	call WaitBGMap
	call _AnimateHPBar
	call WaitBGMap
	ret
