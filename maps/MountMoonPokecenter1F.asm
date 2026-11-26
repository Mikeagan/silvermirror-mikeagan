	object_const_def
	const MOUNTMOONPOKECENTER1F_NURSE
	const MOUNTMOONPOKECENTER1F_RECEPTIONIST
	const MOUNTMOONPOKECENTER1F_BENCH_GUY
	const MOUNTMOONPOKECENTER1F_YOUNGSTER
	const MOUNTMOONPOKECENTER1F_GENTLEMAN

MountMoonPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

MtMoonPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

MtMoonPokecenter1FReceptionistScript:
	jumpstd PokecenterReceptionistScript

MtMoonPokecenter1FBenchGuyScript:
	jumptext MtMoonPokecenter1FBenchGuyText
MtMoonPokecenter1FBenchGuyText:
	ntag "GUY:"
	text "If you have too"
	line "many #MON, you"
	cont "should store them"
	roll "via PC!"
	done

MtMoonPokecenter1FYoungsterScript:
	jumptextfaceplayer MtMoonPokecenter1FYoungsterText
MtMoonPokecenter1FYoungsterText:
	ntag "YOUNGSTER:"
	text "I have six #-"
	line "BALLs on my belt."

	para "You can carry six"
	line "#MON at once."
	done

MtMoonPokecenter1FGentlemanScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_EXP_SHARE
	iftrue .GotExpShare
	checkevent EVENT_BOUGHT_MAGIKARP
	iftrue .GiveExpShare
	writetext MtMoonPokecenter1FGentlemanText
	waitbutton
	closetext
	end

.GiveExpShare
	writetext MtMoonPokecenter1FGentlemanPityText
	promptbutton
	verbosegiveitem EXP_SHARE
	iffalse .BagFull
	setevent EVENT_GOT_EXP_SHARE
.GotExpShare
	writetext MtMoonPokecenter1FGentlemanAfterText
	waitbutton
	closetext
	end

.BagFull
	writetext MtMoonPokecenter1FGentlemanBagFullText
	waitbutton
	closetext
	end

MtMoonPokecenter1FPaperScript:
	jumptext MtMoonPokecenter1FPaperText
	
MtMoonPokecenter1FPaperText:
	text "It's a newspaper!"

	para "There's a front-"
	line "page story about"
	cont "TEAM ROCKET!"
	
	para "“TEAM ROCKET"
	line "attacks CERULEAN"
	cont "citizens…”"
	done
	
MtMoonPokecenter1FGentlemanText:
	ntag "GENTLEMAN:"
	text "TEAM ROCKET"
	line "attacks CERULEAN"
	cont "citizens…"

	para "TEAM ROCKET is"
	line "always in the"
	cont "news!"
	done

MtMoonPokecenter1FGentlemanCalloutText:
	ntag "GENTLEMAN:"
	text "Ahem! Excuse me,"
	line "young trainer!"
	cont "Come over here a"
	roll "moment!"
	done

MtMoonPokecenter1FGentlemanPityText:
	ntag "GENTLEMAN:"
	text "Oh, dear… Did that"
	line "salesman swindle"
	cont "you into buying a"
	roll "MAGIKARP?"

	para "It's hopelessly"
	line "weak right now."
	cont "Here, take this"
	roll "to help train it!"
	done

MtMoonPokecenter1FGentlemanBagFullText:
	ntag "GENTLEMAN:"
	text "Oh, your BAG is"
	line "completely full!"

	para "Clear some space"
	line "and speak to me"
	cont "again."
	done

MtMoonPokecenter1FGentlemanAfterText:
	ntag "GENTLEMAN:"
	text "When a #MON is"
	line "holding EXP.SHARE,"
	cont "it receives EXP."
	roll "from battles, even"
	cont "if it doesn't"
	roll "fight!"
	done

MtMoonPokecenter1FSalesmanScript:
	faceplayer
	opentext
	checkevent EVENT_BOUGHT_MAGIKARP
	iftrue .NoRefunds
	writetext MtMoonPokecenterSalesmanDealText
	special PlaceMoneyTopRight
	yesorno
	iffalse .Refused
	checkmoney YOUR_MONEY, 500
	ifequal HAVE_LESS, .NotEnoughMoney
	waitsfx

	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull

	playsound SFX_TRANSACTION
	takemoney YOUR_MONEY, 500
	special PlaceMoneyTopRight
	writetext MtMoonPokecenterGotMagikarpText
	promptbutton
;	givepoke MAGIKARP, 5, HEART_SCALE
	givepoke MAGIKARP, 5, NO_ITEM, GiftMagikarpName, GiftMagikarpOTName
	givepokemail GiftMagikarpMail
	setevent EVENT_BOUGHT_MAGIKARP
	writetext MtMoonPokecenterSalesmanNoRefundsText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, MOUNTMOONPOKECENTER1F_GENTLEMAN, 15
	turnobject MOUNTMOONPOKECENTER1F_GENTLEMAN, DOWN
	opentext
	writetext MtMoonPokecenter1FGentlemanCalloutText
	waitbutton
	closetext
	end

.NoRefunds
	writetext MtMoonPokecenterSalesmanNoRefundsText
	waitbutton
	closetext
	end

.Refused
	writetext MtMoonPokecenterSalesmanNoText
	waitbutton
	closetext
	end

.NotEnoughMoney
	writetext MtMoonPokecenterSalesmanNoMoneyText
	waitbutton
	closetext
	end

.PartyFull
	writetext MountMoonPokecenter_NoRoomInPartyText
	waitbutton
	closetext
	end

GiftMagikarpName:
	db "MAGIKARP@"

GiftMagikarpOTName:
	db "UNKNOWN@"

GiftMagikarpMail:
	db FLOWER_MAIL
	db   "No refunds.@"

MtMoonPokecenterSalesmanDealText:
	ntag "SALESMAN:"
	text "Hello, there!"
	line "Have I got a deal"
	cont "just for you!"

	para "I'll let you have"
	line "a swell MAGIKARP"
	cont "for just ¥500!"
	roll "What do you say?"
	done

MtMoonPokecenterGotMagikarpText:
	text "<PLAYER> bought"
	line "a MAGIKARP!"
	done

MtMoonPokecenterSalesmanNoText:
	ntag "SALESMAN:"
	text "No?"
	line "I'm only doing"
	cont "this as a favor"
	roll "to you!"
	done
;
;	text "No? I'm only"
;	line "doing this as a"
;	cont "favor to you!"
;	done

MtMoonPokecenterSalesmanNoMoneyText:
	ntag "SALESMAN:"
	text "You'll need more"
	line "money than that!"
	done

MountMoonPokecenter_NoRoomInPartyText:
	ntag "SALESMAN:"
	text "You have no room"
	line "in your party!"
	done

MtMoonPokecenterSalesmanNoRefundsText:
	ntag "SALESMAN:"
	text "I don't give"
	line "refunds!"
	done

MountMoonPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ROUTE_3, 2
	warp_event  4,  7, ROUTE_3, 2

	def_coord_events

	def_bg_events
	bg_event  8,  2, BGEVENT_READ, MtMoonPokecenter1FPaperScript

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MtMoonPokecenter1FNurseScript, -1
	object_event 11,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MtMoonPokecenter1FReceptionistScript, -1
	object_event  0,  4, SPRITE_BENCH_GUY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MtMoonPokecenter1FBenchGuyScript, -1
	object_event  4,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MtMoonPokecenter1FYoungsterScript, -1
	object_event  7,  3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MtMoonPokecenter1FGentlemanScript, -1
	object_event 10,  5, SPRITE_PHARMACIST, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 2, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MtMoonPokecenter1FSalesmanScript, -1
	object_event  8,  2, SPRITE_PAPER, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MtMoonPokecenter1FPaperScript, -1
