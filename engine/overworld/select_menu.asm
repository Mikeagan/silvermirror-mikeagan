DEF SELECT_HOLD_FRAMES EQU 25 ; ~0.4 seconds at 60 FPS

CheckSelectHold::
	ldh a, [hJoyDown]
	and SELECT
	jr z, .released

	; SELECT is being held down
	ld a, [wSelectHoldCounter]
	cp $ff
	jr z, .idle ; Already triggered hold action; wait until player releases SELECT

	inc a
	ld [wSelectHoldCounter], a
	cp SELECT_HOLD_FRAMES
	jr c, .idle

	; Hold threshold reached -> trigger Slot 2 (fall back to Slot 1 if empty)
	ld a, $ff
	ld [wSelectHoldCounter], a
	ld a, [wRegisteredItem2]
	and a
	jr z, .use_slot1
	ld a, 2
	ld [wScriptVar], a
	scf
	ret

.released
	ld a, [wSelectHoldCounter]
	and a
	ret z ; SELECT wasn't held (carry is cleared by `and a`)

	ld c, a
	xor a
	ld [wSelectHoldCounter], a
	ld a, c
	cp $ff
	ret z ; Hold action already fired; ignore release (carry cleared by `cp $ff`)

.use_slot1
	; Short tap -> trigger Slot 1
	ld a, 1
	ld [wScriptVar], a
	scf
	ret

.idle
	and a
	ret

SelectMenu2::
	ld a, [wRegisteredItem2]
	ld hl, wKeyItems
	ld de, 1
	call IsInArray
	jr nc, .NotRegistered2
	ld a, [wRegisteredItem2]
	ld [wCurItem], a
	jp UseRegisteredItem

.NotRegistered2:
	xor a
	ld [wRegisteredItem2], a
	jp SelectMenu.NotRegistered

SelectMenu::
	call CheckRegisteredItem
	jr c, .NotRegistered
	jp UseRegisteredItem

.NotRegistered:
	call OpenText
	ld b, BANK(MayRegisterItemText)
	ld hl, MayRegisterItemText
	call MapTextbox
	call WaitButton
	jp CloseText

MayRegisterItemText:
	text_far _MayRegisterItemText
	text_end

CheckRegisteredItem:
	ld a, [wWhichRegisteredItem]
	and a
	jr z, .NoRegisteredItem
	and REGISTERED_POCKET
	rlca
	rlca
	ld hl, .Pockets
	rst JumpTable
	ret

.Pockets:
; entries correspond to *_POCKET constants
	dw .CheckItem
	dw .CheckBall
	dw .CheckKeyItem
	dw .CheckTMHM
	dw .CheckBerry

.CheckItem:
	ld hl, wNumItems
.StandardCheck:
	call .CheckRegisteredNo
	jr c, .NoRegisteredItem
	inc hl
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	call .IsSameItem
	jr c, .NoRegisteredItem
	and a
	ret

.CheckBerry:
	ld hl, wNumBerries
	jr .StandardCheck

.CheckKeyItem:
	ld a, [wRegisteredItem]
	ld hl, wKeyItems
	ld de, 1
	call IsInArray
	jr nc, .NoRegisteredItem
	ld a, [wRegisteredItem]
	ld [wCurItem], a
	and a
	ret

.CheckBall:
	ld hl, wNumBalls
	call .CheckRegisteredNo
	jr nc, .NoRegisteredItem
	inc hl
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	call .IsSameItem
	jr c, .NoRegisteredItem
	ret

.CheckTMHM:
	jr .NoRegisteredItem

.NoRegisteredItem:
	xor a
	ld [wWhichRegisteredItem], a
	ld [wRegisteredItem], a
	scf
	ret

.CheckRegisteredNo:
	ld a, [wWhichRegisteredItem]
	and REGISTERED_NUMBER
	dec a
	cp [hl]
	jr nc, .NotEnoughItems
	ld [wCurItemQuantity], a
	and a
	ret

.NotEnoughItems:
	scf
	ret

.IsSameItem:
	ld a, [wRegisteredItem]
	cp [hl]
	jr nz, .NotSameItem
	ld [wCurItem], a
	and a
	ret

.NotSameItem:
	scf
	ret

UseRegisteredItem:
	farcall CheckItemMenu
	ld a, [wItemAttributeValue]
	ld hl, .SwitchTo
	rst JumpTable
	ret

.SwitchTo:
; entries correspond to ITEMMENU_* constants
	dw .CantUse
	dw .NoFunction
	dw .NoFunction
	dw .NoFunction
	dw .Current
	dw .Party
	dw .Overworld

.NoFunction:
	call OpenText
	call CantUseItem
	call CloseText
	and a
	ret

.Current:
	call OpenText
	call DoItemEffect
	call CloseText
	and a
	ret

.Party:
	call RefreshScreen
	call FadeToMenu
	call DoItemEffect
	call CloseSubmenu
	call CloseText
	and a
	ret

.Overworld:
	call RefreshScreen
	ld a, 1
	ld [wUsingItemWithSelect], a
	call DoItemEffect
	xor a
	ld [wUsingItemWithSelect], a
	ld a, [wItemEffectSucceeded]
	cp 1
	jr nz, ._cantuse
	scf
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	ret

.CantUse:
	call RefreshScreen

._cantuse
	call CantUseItem
	call CloseText
	and a
	ret
