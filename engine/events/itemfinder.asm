ItemFinder:
	farcall CheckForHiddenItems
	jr c, .found_something
	ld hl, .Script_FoundNothing
	jr .resume

.found_something
	ld hl, .Script_FoundSomething

.resume
	call QueueScript
	ld a, $1
	ld [wItemEffectSucceeded], a
	ret

.SetDirectionTowardItem:
	; Horizontal delta: d = |ItemX - PlayerX|, b = LEFT or RIGHT
	ld a, [wXCoord]
	ld c, a
	ld a, [wStringBuffer1] ; Saved Item X
	sub c
	jr nc, .east_or_same
	cpl
	inc a
	ld d, a
	ld b, LEFT
	jr .check_y
.east_or_same
	ld d, a
	ld b, RIGHT

.check_y
	; Vertical delta: e = |ItemY - PlayerY|, c = UP or DOWN
	ld a, [wYCoord]
	ld l, a
	ld a, [wStringBuffer1 + 1] ; Saved Item Y
	sub l
	jr nc, .south_or_same
	cpl
	inc a
	ld e, a
	ld c, UP
	jr .compare
.south_or_same
	ld e, a
	ld c, DOWN

.compare
	; If standing directly on top of the item (dx == 0 and dy == 0), set $ff for spin
	ld a, d
	or e
	jr z, .on_item

	; Face whichever axis has the larger distance
	ld a, d
	cp e
	jr nc, .done_dir ; |dx| >= |dy| -> keep b (LEFT or RIGHT)
	ld b, c          ; |dy| > |dx|  -> use c (UP or DOWN)
.done_dir
	ld a, b
	ld [wScriptVar], a
	ret

.on_item
	ld a, $ff
	ld [wScriptVar], a
	ret

.ItemfinderSound:
	ld c, 4
.sfx_loop
	push bc
	ld de, SFX_SECOND_PART_OF_ITEMFINDER
	call WaitPlaySFX
	ld de, SFX_TRANSACTION
	call WaitPlaySFX
	pop bc
	dec c
	jr nz, .sfx_loop
	ret

.Script_FoundSomething:
	reloadmappart
	special UpdateTimePals
	callasm .SetDirectionTowardItem
	ifequal $ff, .spin
	ifequal DOWN, .face_down
	ifequal UP, .face_up
	ifequal LEFT, .face_left
	turnobject PLAYER, RIGHT
	sjump .play_sound
.spin
	applymovement PLAYER, .SpinMovement
	sjump .play_sound
.face_down
	turnobject PLAYER, DOWN
	sjump .play_sound
.face_up
	turnobject PLAYER, UP
	sjump .play_sound
.face_left
	turnobject PLAYER, LEFT
.play_sound
	callasm .ItemfinderSound
	writetext .ItemfinderItemNearbyText
	closetext
	end

.SpinMovement:
	turn_step DOWN
	turn_step LEFT
	turn_step UP
	turn_step RIGHT
	turn_step DOWN
	turn_step LEFT
	turn_step UP
	turn_step RIGHT
	turn_step DOWN
	step_end

.Script_FoundNothing:
	reloadmappart
	special UpdateTimePals
	writetext .ItemfinderNopeText
	closetext
	end

.ItemfinderItemNearbyText:
	text_far _ItemfinderItemNearbyText
	text_end

.ItemfinderNopeText:
	text_far _ItemfinderNopeText
	text_end
