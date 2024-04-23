	object_const_def
	const GOLDENRODPOKECENTER1F_NURSE
	const GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST
	const GOLDENRODPOKECENTER1F_SUPER_NERD ; $04
	const GOLDENRODPOKECENTER1F_LASS2 ; $05
	const GOLDENRODPOKECENTER1F_YOUNGSTER
	const GOLDENRODPOKECENTER1F_TEACHER ; $07
	const GOLDENRODPOKECENTER1F_ROCKER ; $08
	const GOLDENRODPOKECENTER1F_GAMEBOY_KID
	const GOLDENRODPOKECENTER1F_GRAMPS ; $0A
	const GOLDENRODPOKECENTER1F_LASS
	const GOLDENRODPOKECENTER1F_POKEFAN_F

GoldenrodPokecenter1F_MapScripts:
	def_scene_scripts
	scene_script .Scene0, SCENE_GOLDENRODPOKECENTER1F_DEFAULT
	scene_script .Scene0, SCENE_GOLDENRODPOKECENTER1F_DEFAULT2

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .prepareMap

.Scene0: ; stuff to handle the player turning his gb off without saving after a trade
	setval BATTLETOWERACTION_10 ; 5671d checks if a trade was made
	special BattleTowerAction
	iffalse .noTrade ; $2967
	prioritysjump scenejmp01 ; $6F68 received pokemon from trade corner dialogue
	end

.noTrade
	setval BATTLETOWERACTION_EGGTICKET ; check if player received the odd egg or still has the egg ticket
	special BattleTowerAction ; 5672b
	iffalse .notReceivedOddEgg ; $3467 still has egg ticket
	prioritysjump scenejmp02 ; $B568 received odd egg dialogue
.notReceivedOddEgg
	end

.prepareMap
	special Mobile_DummyReturnFalse
	iftrue .mobile ; $5067
	moveobject GOLDENRODPOKECENTER1F_LASS2, 16, 9 ; this is 71 in jp crystal???
	moveobject GOLDENRODPOKECENTER1F_GRAMPS, 0, 7
	moveobject GOLDENRODPOKECENTER1F_SUPER_NERD, 8, 13
	moveobject GOLDENRODPOKECENTER1F_TEACHER, 27, 13
	moveobject GOLDENRODPOKECENTER1F_ROCKER, 21, 6
	return ; this is 8f in jp crystal
.mobile
	setevent EVENT_33F
	return

GoldenrodPokecenter1FNurseScript:
	setevent EVENT_WELCOMED_TO_POKECOM_CENTER
	jumpstd PokecenterNurseScript

GoldenrodPokecenter1FTradeCornerAttendantScript:
	special SetBitsForLinkTradeRequest
	opentext
	writetext GoldenrodPokecomCenterWelcomeToTradeCornerText ; $2d6a
	buttonsound ; 54 in jp crystal?
	checkitem EGG_TICKET ; 56762 in jp crystal
	iftrue PlayerHasEggTicket ; $7c68
	special Function11b879 ; check save file?
	ifequal $01, PokemonInTradeCorner ; $F667
	ifequal $02, LeftPokemonInTradeCornerRecently ; $6968
	readvar $01
	ifequal $01, .onlyHaveOnePokemon ; $CF67 ; 56772
	writetext GoldenrodPokecomCenterWeMustHoldYourMonText ; $726A
	yesorno
	iffalse PlayerCancelled ; $D567

	writetext GoldenrodPokecomCenterSaveBeforeTradeCornerText ; $756E
	yesorno
	iffalse PlayerCancelled ; $D567
	special TryQuickSave
	iffalse PlayerCancelled ; $D567
	writetext GoldenrodPokecomCenterWhichMonToTradeText ; $8F6E
	waitbutton ; 53 in jp crystal?
	special BillsGrandfather ; 56792
	ifequal $00, PlayerCancelled ; $D567
	ifequal $FD, CantAcceptEgg ; $EA67
	ifgreater $FB, PokemonAbnormal ; $F067
	special Function11ba38 ; check party pokemon fainted
	ifnotequal $00, CantTradeLastPokemon ; $E467
	writetext GoldenrodPokecomCenterWhatMonDoYouWantText ; $9E6A
	waitbutton
	special Function11ac3e
	ifequal $00, PlayerCancelled ; $D567
	ifequal $02, .tradePokemonNeverSeen ; $BB67
	writetext GoldenrodPokecomCenterWeWillTradeYourMonForMonText ; $B96A ; 567B5
	sjump  .tradePokemon ; $BE67
.tradePokemonNeverSeen
	writetext GoldenrodPokecomCenterWeWillTradeYourMonForNewText ; $1E6B
.tradePokemon
	special TradeCornerHoldMon ; create data to send?
	ifequal $0A, PlayerCancelled ; $D567
	ifnotequal $00, MobileError ; $DB67
	writetext GoldenrodPokecomCenterYourMonHasBeenReceivedText ; $A86B
	waitbutton
	closetext
	end

.onlyHaveOnePokemon
	writetext GoldenrodPokecomCenterYouHaveOnlyOneMonText ; $D76B
	waitbutton
	closetext
	end

PlayerCancelled:
	writetext GoldenrodPokecomCenterWeHopeToSeeYouAgainText ; $0F6C
	waitbutton
	closetext
	end

MobileError:
	special BattleTowerMobileError
	writetext GoldenrodPokecomCenterTradeCanceledText ; $AA6E
	waitbutton
	closetext
	end

CantTradeLastPokemon:
	writetext GoldenrodPokecomCenterCantAcceptLastMonText ; $2C6C
	waitbutton
	closetext
	end

CantAcceptEgg:
	writetext GoldenrodPokecomCenterCantAcceptEggText ; $516C
	waitbutton
	closetext
	end

PokemonAbnormal:
	writetext GoldenrodPokecomCenterCantAcceptAbnormalMonText ; $6F6C
	waitbutton
	closetext
	end

PokemonInTradeCorner:
	writetext GoldenrodPokecomCenterSaveBeforeTradeCornerText ; $756E
	yesorno
	iffalse PlayerCancelled ; $D567
	special TryQuickSave
	iffalse PlayerCancelled ; $D567 ; 56800
	writetext GoldenrodPokecomCenterAlreadyHoldingMonText ; $896C
	buttonsound
	readvar $01
	ifequal $06, PartyFull ; $3868
	writetext GoldenrodPokecomCenterCheckingTheRoomsText ; $A56C
	special Function11b5e8 ; connect
	ifequal $0A, PlayerCancelled ; $D567
	ifnotequal $00, MobileError ; $DB67
	setval $0F
	special BattleTowerAction
	ifequal $00, NoTradePartnerFound ; $3E68 ; 56820
	ifequal $01, .receivePokemon ; $2B68
	sjump PokemonInTradeCornerForALongTime ; $5668

.receivePokemon
	writetext GoldenrodPokecomCenterTradePartnerHasBeenFoundText ; $C46C
	buttonsound
	special Function11b7e5 ; receive a pokemon animation?
	writetext GoldenrodPokecomCenterItsYourNewPartnerText ; $E66C
	waitbutton
	closetext
	end

PartyFull:
	writetext GoldenrodPokecomCenterYourPartyIsFullText ; $216D ; 56838
	waitbutton
	closetext
	end

NoTradePartnerFound:
	writetext GoldenrodPokecomCenterNoTradePartnerFoundText ; $576D ; 5683E
	yesorno
	iffalse ContinueHoldingPokemon ; $6368
	special Function11b920 ; something with mobile
	ifequal $0A, PlayerCancelled ; $D567
	ifnotequal $00, MobileError ; $DB67
	writetext GoldenrodPokecomCenterReturnedYourMonText ; $8A6D
	waitbutton
	closetext
	end

PokemonInTradeCornerForALongTime:
	writetext GoldenrodPokecomCenterYourMonIsLonelyText ; $9A6D ; 56856
	buttonsound
	special Function11b93b ; something with mobile
	writetext GoldenrodPokecenter1FWeHopeToSeeYouAgainText_2 ; $016E
	waitbutton
	closetext
	end

ContinueHoldingPokemon:
	writetext GoldenrodPokecomCenterContinueToHoldYourMonText ; $176E ; 56863
	waitbutton
	closetext
	end

LeftPokemonInTradeCornerRecently:
	writetext GoldenrodPokecomCenterRecentlyLeftYourMonText ; $306E ; 56869
	waitbutton
	closetext
	end

scenejmp01: ; ???
	setscene $01 ; 5686F
	refreshscreen
	writetext GoldenrodPokecomCenterTradePartnerHasBeenFoundText ; $C46C
	buttonsound
	writetext GoldenrodPokecomCenterItsYourNewPartnerText ; $E66C
	waitbutton
	closetext
	end

PlayerHasEggTicket:
	writetext GoldenrodPokecomCenterEggTicketText ; $CD6E ; 5687C
	waitbutton
	readvar $01
	ifequal $06, PartyFull ; $3868
	writetext GoldenrodPokecomCenterOddEggBriefingText ; $106F
	waitbutton
	writetext GoldenrodPokecomCenterSaveBeforeTradeCornerText ; $756E
	yesorno
	iffalse PlayerCancelled ; $D567
	special TryQuickSave
	iffalse PlayerCancelled ; $D567
	writetext GoldenrodPokecomCenterPleaseWaitAMomentText ; $CC6F
	special GiveOddEgg
	ifequal $0B, .eggTicketExchangeNotRunning ; $AF68
	ifequal $0A, PlayerCancelled ; $D567
	ifnotequal $00, MobileError ; $DB67
.receivedOddEgg
	writetext GoldenrodPokecomCenterHereIsYourOddEggText ; $E66F
	waitbutton
	closetext
	end

.eggTicketExchangeNotRunning
	writetext GoldenrodPokecomCenterNoEggTicketServiceText ; $2270 ; 568AF
	waitbutton
	closetext
	end

scenejmp02: ; 568B5
	opentext
	sjump PlayerHasEggTicket.receivedOddEgg ; $A968

GoldenrodPokecenter1F_NewsMachineScript:
	special Mobile_DummyReturnFalse ; 568B9
	iftrue .mobileEnabled ; $C268
	jumptext GoldenrodPokecomCenterNewsMachineNotYetText ; $1F76
.mobileEnabled
	opentext
	writetext GoldenrodPokecomCenterNewsMachineText ; $4D70
	buttonsound
	setval $14 ; (get battle tower save file flags if save is yours?)
	special BattleTowerAction
	ifnotequal $00, .skipExplanation ; $D968
	setval $15  ; (set battle tower save file flags?)
	special BattleTowerAction
	writetext GoldenrodPokecomCenterNewsMachineExplanationText ; $6370
	waitbutton
.skipExplanation
	writetext GoldenrodPokecomCenterSaveBeforeNewsMachineText ; $C371
	yesorno
	iffalse .cancel ; $FF68
	special TryQuickSave
	iffalse .cancel ; $FF68
	setval $15 ; (set battle tower save file flags?)
	special BattleTowerAction
.showMenu
	writetext GoldenrodPokecomCenterWhatToDoText ; $5970
	setval $00
	special Menu_ChallengeExplanationCancel ; show news machine menu
	ifequal $01, .getNews 		  ; $0869
	ifequal $02, .showNews 		  ; $1D69
	ifequal $03, .showExplanation ; $0169
.cancel
	closetext
	end

.showExplanation
	writetext GoldenrodPokecomCenterNewsMachineExplanationText ; $6370 ; 56901
	waitbutton
	sjump .showMenu; $EB68

.getNews
	writetext GoldenrodPokecomCenterWouldYouLikeTheNewsText ; $3E71 ; 56908
	yesorno
	iffalse .showMenu;$EB68
	writetext GoldenrodPokecomCenterReadingTheLatestNewsText ; $5471
	special Function17d2b6 ; download news?
	ifequal $0A, .showMenu ; $EB68
	ifnotequal $00, .mobileError ; $3569
.showNews
	special Function17d2ce ; show news?
	iffalse .quitViewingNews ; $3269
	ifequal $01, .noOldNews ; $2E69
	writetext GoldenrodPokecomCenterCorruptedNewsDataText ; $8971
	waitbutton
	sjump .showMenu ; $EB68

.noOldNews
	writetext GoldenrodPokecomCenterNoOldNewsText ; $7971 ; 5692E
	waitbutton
.quitViewingNews
	sjump .showMenu ; $EB68

.mobileError
	special BattleTowerMobileError ; 56935
	closetext
	end

Unreferenced:
	writetext GoldenrodPokecomCenterMakingPreparationsText ; ??? $AA71 ; 5693A no jump to here?
	waitbutton
	closetext
	end

GoldenrodPokecenter1F_GSBallSceneLeft:
	setval $0B ; 56940 (load mobile event index)
	special BattleTowerAction
	iffalse GoldenrodPokecenter1F_GSBallSceneRight.nogsball ; $9769
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER ; 340
	iftrue GoldenrodPokecenter1F_GSBallSceneRight.nogsball ; $9769
	moveobject GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST, 12, 11
	sjump GoldenrodPokecenter1F_GSBallSceneRight.gsball ; 6769

GoldenrodPokecenter1F_GSBallSceneRight:
	setval $0B ; 56955 (load mobile event index)
	special BattleTowerAction
	iffalse .nogsball ; $9769
	checkevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER ; 340
	iftrue .nogsball ; $9769
	moveobject GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST, 13, 11

.gsball ; 56769
	disappear GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST
	appear GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST
	playmusic MUSIC_SHOW_ME_AROUND
	applymovement GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST, GoldenrodPokeCenter1FLinkReceptionistApproachPlayerMovement ; $0F6A
	turnobject PLAYER, UP
	opentext
	writetext GoldenrodPokeCenter1FLinkReceptionistPleaseAcceptGSBallText
	waitbutton
	verbosegiveitem GS_BALL
	setevent EVENT_GOT_GS_BALL_FROM_POKECOM_CENTER
	setevent EVENT_CAN_GIVE_GS_BALL_TO_KURT
	writetext GoldenrodPokeCenter1FLinkReceptionistPleaseDoComeAgainText
	waitbutton
	closetext
	applymovement GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST, GoldenrodPokeCenter1FLinkReceptionistWalkBackMovement ; $196A
	special RestartMapMusic
	moveobject GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST, 16,  8
	disappear GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST
	appear GOLDENRODPOKECENTER1F_LINK_RECEPTIONIST

.nogsball
	end

GoldenrodPokecenter1FSuperNerdScript:
	special Mobile_DummyReturnFalse ; 56998
	iftrue .mobile ; $A169
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffSuperNerdText  ; $E071

.mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnSuperNerdText ; $1E72

GoldenrodPokecenter1FLass2Script:
	special Mobile_DummyReturnFalse ; 569A4
	iftrue .mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffLassText ; $AD72

.mobile
	checkevent EVENT_33F
	iftrue .alreadyMoved ; $D369
	faceplayer
	opentext
	writetext GoldenrodPokecenter1FMobileOnLassText1 ; $EB72
	waitbutton
	closetext
	readvar $09
	ifequal $02, .talkedToFromRight ; $C769
	applymovement GOLDENRODPOKECENTER1F_LASS2, GoldenrodPokeCenter1FLass2WalkRightMovement ; $236A
	sjump .skip ; $CB69
.talkedToFromRight
	applymovement GOLDENRODPOKECENTER1F_LASS2, GoldenrodPokeCenter1FLassWalkRightAroundPlayerMovement ; $276A
.skip
	setevent EVENT_33F
	moveobject GOLDENRODPOKECENTER1F_LASS2, $12, $09
	end

.alreadyMoved
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnLassText2 ; $2373

GoldenrodPokecenter1FYoungsterScript:
	special Mobile_DummyReturnFalse ; 569D6
	iftrue .mobile ; $DF69
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffYoungsterText ; $5473

.mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnYoungsterText ; $1074

GoldenrodPokecenter1FTeacherScript:
	special Mobile_DummyReturnFalse ; 569E2
	iftrue .mobile ; $EB69
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffTeacherText ; $8273

.mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnTeacherText ; $3274

GoldenrodPokecenter1FRockerScript:
	special Mobile_DummyReturnFalse ; 569EE
	iftrue .mobile ; $F769
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffRockerText ; $D073

.mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnRockerText ; $5474

GoldenrodPokecenter1FGrampsScript:
	special Mobile_DummyReturnFalse ; 569FD
	iftrue .mobile ; $066A
	jumptextfaceplayer GoldenrodPokecenter1FMobileOffGrampsText ; $D674

.mobile
	jumptextfaceplayer GoldenrodPokecenter1FMobileOnGrampsText ; $1875

PokeComCenterInfoSign:
	jumptext GoldenrodPokecomCenterSignText

GoldenrodPokecenter1FGameboyKidScript:
	jumptextfaceplayer GoldenrodPokecenter1FGameboyKidText

GoldenrodPokecenter1FLassScript:
	jumptextfaceplayer GoldenrodPokecenter1FLassText

;GoldenrodPokecenter1FPokefanF:
;	faceplayer
;	opentext
;	writetext GoldenrodPokecenter1FPokefanFDoYouHaveEonMailText
;	waitbutton
;	writetext GoldenrodPokecenter1FAskGiveAwayAnEonMailText
;	yesorno
;	iffalse .NoEonMail
;	takeitem EON_MAIL
;	iffalse .NoEonMail
;	writetext GoldenrodPokecenter1FPlayerGaveAwayTheEonMailText
;	waitbutton
;	writetext GoldenrodPokecenter1FPokefanFThisIsForYouText
;	waitbutton
;	verbosegiveitem REVIVE
;	iffalse .NoRoom
;	writetext GoldenrodPokecenter1FPokefanFDaughterWillBeDelightedText
;	waitbutton
;	closetext
;	end
;
;.NoEonMail:
;	writetext GoldenrodPokecenter1FPokefanFTooBadText
;	waitbutton
;	closetext
;	end
;
;.NoRoom:
;	giveitem EON_MAIL
;	writetext GoldenrodPokecenter1FPokefanFAnotherTimeThenText
;	waitbutton
;	closetext
;	end

GoldenrodPokeCenter1FLinkReceptionistApproachPlayerMovement:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step_end

GoldenrodPokeCenter1FLinkReceptionistWalkBackMovement:
	step UP
	step UP
	step UP
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

GoldenrodPokeCenter1FLass2WalkRightMovement:
	slow_step RIGHT ; db $0B
	slow_step RIGHT ; db $0B
	turn_head UP    ; db $01
	step_end        ; db $47

GoldenrodPokeCenter1FLassWalkRightAroundPlayerMovement:
	slow_step DOWN  ; db $08
	slow_step RIGHT ; db $0B
	slow_step RIGHT ; db $0B
	slow_step UP    ; db $09
	turn_head UP    ; db $01
	step_end        ; db $47

GoldenrodPokecomCenterWelcomeToTradeCornerText:
	text "Hallo! Willkommen"
	line "in der #KOM-"
	cont "CENTER-TAUSCHECKE."

	para "Du kannst hier"
	line "mit wildfremden"
	para "und weit entfern-"
	line "ten Trainern"
	cont "#MON tauschen."
	done

GoldenrodPokecomCenterWeMustHoldYourMonText:
	text "Zum Tauschen"
	line "bewahren wir dein"
	para "#MON bei uns"
	line "auf."
	para "Möchtest du gerne"
	line "tauschen?"
	done

GoldenrodPokecomCenterWhatMonDoYouWantText:
	text "Welches #MON"
	line "erhoffst du dir"
	cont "im Gegenzug?"
	done

GoldenrodPokecomCenterWeWillTradeYourMonForMonText:
	text "Gut, wir werden"
	line "versuchen dein"

	para "@"
	text_ram wStringBuffer3
	text " gegen"
	line "@"
	text_ram wStringBuffer4
	text ""
	cont "zu tauschen."

	para "Wir nehmen dein"
	line "#MON jetzt"
	cont "entgegen."

	para "Der Raum wird"
	line "nun vorbereitet…"
	done

GoldenrodPokecomCenterWeWillTradeYourMonForNewText:
	text "Gut, wir werden"
	line "versuchen dein"

	para "@"
	text_ram wStringBuffer3
	text ""

	line "gegen ein #MON"
	para "zu tauschen, dem"
	line "du bisher noch"
	para "nicht begegnet"
	line "bist."

	para "Wir nehmen dein"
	line "#MON jetzt"
	cont "entgegen."

	para "Der Raum wird"
	line "nun vorbereitet…"
	done

GoldenrodPokecomCenterYourMonHasBeenReceivedText:
	text "Dein #MON wurde"
	line "entgegengenommen."
	para "Einen Tausch-"
	line "partner zu finden"
	para "kann ein wenig"
	line "dauern, also"
	para "komm später wieder"
	line "vorbei."
	done

GoldenrodPokecomCenterYouHaveOnlyOneMonText:
	text "Oh? Du hast nur"
	line "ein #MON in"
	cont "deinem Team."

	para "Bitte komm wieder,"
	line "wenn du dein Team"
	cont "vergrößert hast."
	done

GoldenrodPokecomCenterWeHopeToSeeYouAgainText:
	text "Komm jederzeit"
	line "wieder vorbei!"
	done

GoldenrodPokecomCenterCommunicationErrorText: ; unreferenced
	text "Übertragungs-"
	line "fehler."
	done

GoldenrodPokecomCenterCantAcceptLastMonText:
	text "Würden wir dieses"
	line "#MON entgegen-"
	cont "nehmen, hättest"
	para "du keine #MON"
	line "mehr zum Kämpfen"
	cont "übrig."
	done

GoldenrodPokecomCenterCantAcceptEggText:
	text "Tut mir Leid, aber"
	line "wir können kein EI"
	cont "annehmen."
	done

GoldenrodPokecomCenterCantAcceptAbnormalMonText:
	text "Mit diesem #MON"
	line "scheint etwas"
	cont "nicht in Ordnung"
	cont "zu sein."

	para "Wir können es"
	line "daher nicht"
	cont "entgegennehmen."
	done


GoldenrodPokecomCenterAlreadyHoldingMonText:
	text "Oh? Haben wir"
	line "nicht schon eines"
	para "deiner #MON"
	line "entgegengenommen?"
	done

GoldenrodPokecomCenterCheckingTheRoomsText:
	text "Wir überprüfen die"
	line "Räume für dich."

	para "Bitte warte einen"
	line "Moment…"
	done

GoldenrodPokecomCenterTradePartnerHasBeenFoundText:
	text "Danke, dass du"
	line "gewartet hast."

	para "Ein Tauschpartner"
	line "wurde gefunden!"
	done

GoldenrodPokecomCenterItsYourNewPartnerText:
	text "Hier ist dein"
	line "neuer Freund!"

	para "Kümmere dich gut"
	line "um ihn."

	para "Komm jederzeit"
	line "wieder vorbei."
	done

GoldenrodPokecomCenterYourPartyIsFullText:
	text "Oh, oh. Dein Team"
	line "ist schon voll"
	cont "besetzt."

	para "Schaffe Platz in"
	line "deinem Team und"
	cont "komm dann wieder."
	done

GoldenrodPokecomCenterNoTradePartnerFoundText:
	text "Leider konnte"
	line "bisher kein"
	para "Tauschpartner"
	line "gefunden werden."

	para "Möchtest du dein"
	line "#MON zurück?"
	done

GoldenrodPokecomCenterReturnedYourMonText:
	text "Hier hast du dein"
	line "#MON zurück."
	done

GoldenrodPokecomCenterYourMonIsLonelyText:
	text "Leider konnte"
	line "bisher kein"
	para "Tauschpartner"
	line "gefunden werden."

	para "Da wir dein"
	line "#MON bereits"
	para "sehr lange aufbe-"
	line "wahren, fühlt es"
	para "sich mittlerwile"
	line "ziemlich einsam."

	para "Wir geben es dir"
	line "vorerst zurück…"
	done

GoldenrodPokecenter1FWeHopeToSeeYouAgainText_2:
	text "Komm jederzeit"
	line "wieder vorbei!"
	done

GoldenrodPokecomCenterContinueToHoldYourMonText:
	text "In Ordnung, wir"
	line "werden dein"
	para "#MON noch eine"
	line "Weile aufbewahren."
	done

GoldenrodPokecomCenterRecentlyLeftYourMonText:
	text "Oh? Du hast uns"
	line "dein #MON erst"
	para "kürzlich"
	line "anvertraut."

	para "Komm bitte später"
	line "wieder."
	done

GoldenrodPokecomCenterSaveBeforeTradeCornerText:
	text "Das Spiel wird"
	line "gesichert, ehe"
	para "die Verbindung zum"
	line "MOBILEN CENTER"
	cont "aufgebaut wird."
	done

GoldenrodPokecomCenterWhichMonToTradeText:
	text "Welches deiner"
	line "#MON bietest"
	cont "du zum Tausch an?"
	done

GoldenrodPokecomCenterTradeCanceledText:
	text "Tut mir Leid, aber"
	line "der Tausch wurde"
	cont "abgebrochen."
	done

GoldenrodPokecomCenterEggTicketText:
	text "Oh! Wie ich sehe,"
	line "besitzt du ein EI-"
	cont "TICKET!"

	para "Dieser Coupon kann"
	line "gegen ein besonde-"
	para "res #MON"
	line "eingelöst werden"
	para "und ist nur für"
	line "besondere Leute"
	para "bestimmt!"
	done

GoldenrodPokecomCenterOddEggBriefingText:
	text "Lass mich dir eine"
	line "kurze Einweisung"
	cont "geben!"

	para "In der TAUSCHECKE"
	line "kannst du über"
	para "größere Entfer-"
	line "nungen tauschen,"
	para "weshalb dieser"
	line "Vorgang etwas"
	para "Zeit in Anspruch"
	line "nehmen kann."

	para "Das KURIOS-EI"
	line "hingegen wurde"
	para "extra nur für dich"
	line "hinterlegt und"
	para "kann dir sofort"
	line "übersendet werden."

	para "Einer der vielen"
	line "Räume im CENTER"
	para "wird ausgewählt,"
	line "um dir von dort"
	para "das KURIOS-EI"
	line "zu übersenden."
	done

GoldenrodPokecomCenterPleaseWaitAMomentText:
	text "Bitte warte"
	line "einen Moment."
	done

GoldenrodPokecomCenterHereIsYourOddEggText:
	text "Danke, dass du"
	line "gewartet hast."

	para "Wir haben dein"
	line "KURIOS-EI"
	cont "empfangen!"

	para "Bitte schön!"

	para "Bitte ziehe es in"
	line "liebevoller Pflege"
	cont "auf."
	done

GoldenrodPokecomCenterNoEggTicketServiceText:
	text "Tut mir Leid, aber"
	line "der EI-TICKET-Aus-"
	cont "tausch-Dienst ist"
	
	para "momentan nicht"
	line "verfügbar."
	done

GoldenrodPokecomCenterNewsMachineText:
	text "Das ist eine #-"
	line "MON-NACHRICHTEN-"
	cont "MASCHINE!"
	done

GoldenrodPokecomCenterWhatToDoText:
	text "Was möchtest du"
	line "tun?"
	done

GoldenrodPokecomCenterNewsMachineExplanationText:
	text "#MON-NACHRICH-"
	line "TEN werden aus"
	para "den SPIELSTÄNDEN"
	line "verschiedener"
	para "Trainer zusammen-"
	line "gestellt."

	para "Dein SPIELSTAND"
	line "kann übertragen"
	para "werden, wenn du"
	line "neue NACHRICHTEN"
	cont "abrufst."

	para "Der SPIELSTAND"
	line "enthält Aufzeich-"
	para "nungen deines"
	line "Abenteuers und"
	cont "dein Mobilprofil."
	
	para "Deine Rufnummer"
	line "wird dabei nicht"
	cont "übertragen."

	para "Der Inhalt der"
	line "NACHRICHTEN hängt"
	para "von den SPIELSTÄN-"
	line "DEN aller Teil-"
	cont "nehmer ab."

	para "Vielleicht taucht"
	line "auch dein Name"
	para "eines Tages in"
	line "den NACHRICHTEN"
	cont "auf!"
	done

GoldenrodPokecomCenterWouldYouLikeTheNewsText:
	text "Möchtest du die"
	line "neusten NACH-"
	cont "RICHTEN abrufen?"
	done

GoldenrodPokecomCenterReadingTheLatestNewsText:
	text "Die neusten"
	line "NACHRICHTEN"
	cont "werden empfangen…"
	done

GoldenrodPokecomCenterNoOldNewsText:
	text "Noch wurden keine"
	line "NACHRICHTEN"
	cont "empfangen."
	done

GoldenrodPokecomCenterCorruptedNewsDataText:
	text "Die NACHRICHTEN"
	line "sind beschädigt."

	para "Bitte lade die"
	line "NACHRICHTEN erneut"
	cont "herunter."
	done

GoldenrodPokecomCenterMakingPreparationsText:
	text "Wir treffen noch"
	line "Vorbereitungen."

	para "Komm bitte später"
	line "wieder."
	done

GoldenrodPokecomCenterSaveBeforeNewsMachineText:
	text "Ehe du die"
	line "NACHRICHTEN-"
	para "MASCHINE bedienst,"
	line "wird dein Spiel-"
	cont "stand gesichert."
	done

GoldenrodPokecenter1FMobileOffSuperNerdText:
	text "Dieses #MON-"
	line "CENTER ist riesig."

	para "Es wurde soeben"
	line "fertig. Es gibt"

	para "auch viele neue"
	line "Maschinen."
	done

GoldenrodPokecenter1FMobileOnSuperNerdText:
	text "Ich habe mir etwas"
	line "lustiges für die"
	cont "TAUSCHECKE aus-"
	cont "gedacht!"

	para "Ich gebe TAUBSI"
	line "einen BRIEF und"

	para "tausche es gegen"
	line "ein anderes!"

	para "Wenn das jeder"
	line "tut, könnte man"

	para "mit allen mög-"
	line "lichen Leuten"
	cont "BRIEFE tauschen!"

	para "Ich nenne das"
	line "TAUBSI-BRIEF!"

	para "Setzt es sich"
	line "durch, schließe"

	para "ich viele neue"
	line "Freundschaften!"
	done

GoldenrodPokecenter1FMobileOffLassText:
	text "Sie sagen, dass"
	line "man dort sogar mit"

	para "Fremden tauschen"
	line "kann."

	para "Aber sie arbeiten"
	line "noch daran."
	done

GoldenrodPokecenter1FMobileOnLassText1:
	text "Ein mir fremdes"
	line "Mädchen schickte"

	para "mir ihr"
	line "HOPPSPROSS."

	para "Tausche #MON,"
	line "die du möchtest."
	done

GoldenrodPokecenter1FMobileOnLassText2:
	text "Ich erhielt ein"
	line "weibliches"
	cont "HOPPSPROSS, das"
	cont "SEAMUS heißt!"

	para "So heißt mein"
	line "Vater!"
	done

GoldenrodPokecenter1FMobileOffYoungsterText:
	text "Welches ist die"
	line "NACHRICHTEN-"
	cont "MASCHINE?"

	para "Bezieht sie die"
	line "Nachrichten"
	cont "nur vom Radio?"
	done

GoldenrodPokecenter1FMobileOffTeacherText:
	text "Das #KOM-CENTER"
	line "ist drahtlos mit"
	para "allen #MON-"
	line "CENTERN verbunden."

	para "Das bedeutet wohl,"
	line "dass ich mich mit"
	para "allen möglichen"
	line "Leuten verbinden"
	cont "kann!"
	done

GoldenrodPokecenter1FMobileOffRockerText:
	text "Die Maschinen sind"
	line "noch nicht ein-"
	cont "satzbereit."

	para "Dennoch ist es"
	line "toll, solch einen"

	para "modernen Ort vor"
	line "allen anderen zu"
	cont "besuchen."
	done

GoldenrodPokecenter1FMobileOnYoungsterText:
	text "Mein Freund war"
	line "neulich in den"

	para "NACHRICHTEN. Das"
	line "hat mich"
	cont "überrascht!"
	done

GoldenrodPokecenter1FMobileOnTeacherText:
	text "Ich werde unruhig,"
	line "wenn ich nicht"

	para "die neusten"
	line "NACHRICHTEN"

	para "bekomme!"
	done

GoldenrodPokecenter1FMobileOnRockerText:
	text "Wenn ich in die"
	line "NACHRICHTEN komme,"

	para "werde ich berühmt"
	line "und verehrt."

	para "Wie kann ich es"
	line "bloß in die NACH-"
	cont "RICHTEN schaffen?"
	done

GoldenrodPokecenter1FGameboyKidText:
	text "Im oberen Stock-"
	line "werk findest du"

	para "das KOLOSSEUM."
	line "Hier kannst du"

	para "gegen Freunde"
	line "antreten."

	para "Kampfergebnisse"
	line "werden an der Wand"

	para "ausgehängt. Ich"
	line "kann es mir nicht"

	para "erlauben, zu ver-"
	line "lieren."
	done

GoldenrodPokecenter1FMobileOffGrampsText:
	text "Ich bin sofort"
	line "hierher gekommen,"

	para "als ich hörte,"
	line "dass das #MON-"
	cont "CENTER in DUKATIA"

	para "neue Maschinen"
	line "hat."

	para "Aber es scheint,"
	line "als seien sie noch"

	para "mitten in den"
	line "Vorbereitungen…"
	done

GoldenrodPokecenter1FMobileOnGrampsText:
	text "Allein das Be-"
	line "trachten dieser"

	para "neuen Errungen-"
	line "schaften macht"
	cont "mich jünger!"
	done

GoldenrodPokecenter1FLassText:
	text "Ein starkes #-"
	line "MON muss nicht"
	cont "zwingend gewinnen."

	para "Meist entscheidet"
	line "der Vor- oder"
	cont "Nachteil des Typs."

	para "Ich glaube nicht,"
	line "dass es ein #-"
	cont "MON gibt, das al-"
	cont "len anderen über-"
	cont "legen ist."
	done

GoldenrodPokeCenter1FLinkReceptionistPleaseAcceptGSBallText:
	text "<PLAYER>, oder?"

	para "Glückwunsch!"

	para "Nur für dich wurde"
	line "ein GS-BALL"
	cont "geschickt!"

	para "Nimm ihn bitte!"
	done

GoldenrodPokeCenter1FLinkReceptionistPleaseDoComeAgainText:
	text "Beehre uns bald"
	line "wieder!"
	done

GoldenrodPokecomCenterSignText:
	text "#KOM-CENTER"

	para "EG INFORMATIONEN"

	para "Links: VERWALTUNG"

	para "Mitte: TAUSCHECKE"

	para "Rechts: #MON-"
	line "NACHRICHTEN"
	done

GoldenrodPokecomCenterNewsMachineNotYetText:
	text "Das ist eine #-"
	line "MON NACHRICHTEN-"
	cont "MASCHINE!"

	para "Sie ist noch nicht"
	line "in Betrieb…"
	done

GoldenrodPokecenter1FPokefanFDoYouHaveEonMailText:
	text "Oh, dein Beutel"
	line "sieht schwer aus!"

	para "Oh! Hast du zufäl-"
	line "lig etwas, das man"
	cont "ANARA-BRIEF nennt?"

	para "Meine Tochter"
	line "sucht danach."

	para "Du gibst mir doch"
	line "einen, nicht wahr?"
	done

GoldenrodPokecenter1FAskGiveAwayAnEonMailText:
	text "ANARA-BRIEF"
	line "weggeben?"
	done

GoldenrodPokecenter1FPokefanFThisIsForYouText:
	text "Oh, großartig!"
	line "Danke, Schatz!"

	para "Hier, als Aus-"
	line "gleich sollst"
	cont "du das haben!"
	done

GoldenrodPokecenter1FPokefanFDaughterWillBeDelightedText:
	text "Meine Tochter wird"
	line "entzückt sein!"
	done

GoldenrodPokecenter1FPokefanFTooBadText:
	text "Oh? Du hast"
	line "keinen? Schade."
	done

GoldenrodPokecenter1FPokefanFAnotherTimeThenText:
	text "Oh… Ein anderes"
	line "Mal vielleicht."
	done

GoldenrodPokecenter1FPlayerGaveAwayTheEonMailText:
	text "<PLAYER> gibt den"
	line "ANARA-BRIEF weg."
	done

GoldenrodPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6, 15, GOLDENROD_CITY, 15
	warp_event  7, 15, GOLDENROD_CITY, 15
	warp_event  0,  6, POKECOM_CENTER_ADMIN_OFFICE_MOBILE, 1
	warp_event  0, 15, POKECENTER_2F, 1

	def_coord_events
	coord_event  6, 15, SCENE_DEFAULT, GoldenrodPokecenter1F_GSBallSceneLeft
	coord_event  7, 15, SCENE_DEFAULT, GoldenrodPokecenter1F_GSBallSceneRight

	def_bg_events
	bg_event 24,  5, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript ; 57666
	bg_event 24,  6, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 24,  7, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 24,  9, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 24, 10, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 25, 11, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 26, 11, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 27, 11, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 28, 11, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29,  5, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29,  6, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29,  7, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29,  8, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29,  9, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event 29, 10, BGEVENT_READ, GoldenrodPokecenter1F_NewsMachineScript
	bg_event  2,  9, BGEVENT_READ, PokeComCenterInfoSign

	def_object_events
	object_event  7,  7, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FNurseScript, -1
	 ; 576C4
	object_event 16,  8, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FTradeCornerAttendantScript, -1
	 ; boy left of trade corner 576D1
	object_event 13,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_UP_DOWN, 16, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FSuperNerdScript, -1
	 ; girl in front of trade corner 576DE
	object_event 18,  9, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FLass2Script, -1
	 ; boy left of news machine 576EB
	object_event 23, 08, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FYoungsterScript, -1
	 ; girl right of news machine 576F8
	object_event 30, 09, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FTeacherScript, -1
	 ; boy right of news machine 57705
	object_event 30, 05, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FRockerScript, -1
	 ; 57712
	object_event 11, 12, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FGameboyKidScript, -1
	 ; old man 5771F
	object_event 19, 14, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FGrampsScript, -1
	 ; 5772C
	object_event  4, 11, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FLassScript, -1
	;object_event 15, 12, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FPokefanF, -1
