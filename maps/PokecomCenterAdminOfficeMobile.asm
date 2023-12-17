	object_const_def
	const POKECOMCENTERADMINOFFICEMOBILE_SCIENTIST1
	const POKECOMCENTERADMINOFFICEMOBILE_SCIENTIST2
	const POKECOMCENTERADMINOFFICEMOBILE_SCIENTIST3

PokecomCenterAdminOfficeMobile_MapScripts:
	def_scene_scripts

	def_callbacks

PokecomCenterAdminOfficeMobileScientist1Script:
	jumptextfaceplayer PokecomCenterAdminOfficeMobileScientist1Text

PokecomCenterAdminOfficeMobileScientist2Script:
	jumptextfaceplayer PokecomCenterAdminOfficeMobileScientist2Text

PokecomCenterAdminOfficeMobileScientist3Script:
	jumptextfaceplayer PokecomCenterAdminOfficeMobileScientist3Text

PokecomCenterAdminOfficeMobileComputer1:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer1Text
	waitbutton
.loop:
	reloadmappart
	loadmenu .Computer1MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .PokeComClub
	ifequal 2, .MobileCenter
	sjump .Quit

.PokeComClub:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer1Text_PokeComClub
	waitbutton
	sjump .loop

.MobileCenter:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer1Text_MobileCenter
	waitbutton
	sjump .loop

.Quit:
	closetext
	end

.Computer1MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 15, 8
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
	db "#KOM-CLUB@" ; # COM CLUB
	db "MOBILE-CENTER@" ; MOBILE CENTER
	db "ZURÜCK@" ; QUIT

PokecomCenterAdminOfficeMobileComputer2:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer2Text
	waitbutton
.loop:
	reloadmappart
	loadmenu .Computer2MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .UsePhone
	ifequal 2, .DontUsePhone
	sjump .Quit

.UsePhone:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer2Text_UsePhone
	waitbutton
	sjump .loop

.DontUsePhone:
	opentext
	writetext PokecomCenterAdminOfficeMobileComputer2Text_DontUsePhone
	waitbutton
	sjump .loop

.Quit:
	closetext
	end

.Computer2MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 18, 8
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
	db "HANDY-NUTZUNG@" ; Use phone
	db "BEI PROBLEMEN@" ; Don't use phone
	db "ZURÜCK@" ; QUIT

PokecomCenterAdminOfficeMobileComputer3:
	jumptext PokecomCenterAdminOfficeMobileComputer3Text

PokecomCenterAdminOfficeMobileScientist1Text:
	text "#KOM-CENTER und"
	line "MOBILE-CENTER"
	para "wurden errichtet,"
	line "um das Tauschen"
	para "und Kämpfen mit"
	line "weit entfernten"
	para "Freunden und sogar"
	line "wildfremden"
	para "Trainern zu"
	line "ermöglichen."
	done

PokecomCenterAdminOfficeMobileScientist2Text:
	text "Warst du nicht"
	line "auch beeindruckt,"
	para "als du dich das"
	line "erste Mal über"
	para "dein Handy mit"
	line "jemandem verbunden"
	cont "hast?"

	para "Bei meinem ersten"
	line "erfolgreichen"
	para "Versuch war ich"
	line "so beeindruckt,"
	para "dass ich sogar"
	line "Gänsehaut bekam!"
	done

PokecomCenterAdminOfficeMobileScientist3Text:
	text "Dank Fortschritten"
	line "auf dem Gebiet der"
	para "Funktechnologie,"
	line "konnten sie diese"
	cont "Stätte bauen."
	done

PokecomCenterAdminOfficeMobileComputer1Text:
	text "Eine Notiz über"
	line "die Einsatzzwecke"
	para "des MOBILE"
	line "ADAPTER…"
	done

PokecomCenterAdminOfficeMobileComputer1Text_PokeComClub:
	text "Es gibt in jedem"
	line "#MON-CENTER im"
	para "Obergeschoss den"
	line "#KOM-CLUB."
	para "Mit einem MOBILE"
	line "ADAPTER kannst du"
	para "dort mit weit"
	line "entfernten"
	para "Freunden kämpfen"
	line "oder tauschen."

	para "Um sich verbinden"
	line "zu können, benö-"
	para "tigen dein Freund"
	line "und du die gleiche"
	para "Art von MOBILE"
	line "ADAPTER."
	done

PokecomCenterAdminOfficeMobileComputer1Text_MobileCenter:
	text "TAUSCHECKE und"
	line "#MON-NACHRICH-"
	para "TEN werden über"
	line "eine Verbindung"
	para "zum MOBILE-CENTER"
	line "bereitgestellt."
	para "Hierfür musst du"
	line "dich zunächst beim"
	para "MOBILE-CENTER"
	line "registrieren."
	done

PokecomCenterAdminOfficeMobileComputer2Text:
	text "Eine Notiz über"
	line "die Handy-Nutzung…"
	done

PokecomCenterAdminOfficeMobileComputer2Text_UsePhone:
	text "Verbinde Handy"
	line "und MOBILE ADAPTER"
	para "sicher miteinander"
	line "und achte auf"
	cont "guten Netzempfang."

	para "Berühre während"
	line "der Übertragung"
	para "nicht dein Handy"
	line "und trenne nicht"
	cont "die Verbindung."
	done

PokecomCenterAdminOfficeMobileComputer2Text_DontUsePhone:
	text "Wenn der Server"
	line "überlastet ist,"
	para "könnte ein Ver-"
	line "bindungsversuch"
	cont "scheitern."

	para "Versuche es dann"
	line "später erneut."

	para "Wenn du dich"
	line "weiterhin nicht"
	para "verbinden kannst"
	line "oder die Fehler-"
	cont "meldungen nicht"
	para "verständlich sind,"
	line "wende dich an den"
	para "Kundendienst oder"
	line "erfahre mehr in"
	para "der Bedienungs-"
	line "anleitung."
	done

PokecomCenterAdminOfficeMobileComputer3Text:
	text "Eine E-Mail an das"
	line "VERWALTUNGS-BÜRO…"

	para "<……> <……> <……>"

	para "An die #KOM-"
	line "CENTER-Beleg-"
	cont "schaft…"

	para "Dank der Funktech-"
	line "nologie können"
	para "Trainer jetzt lan-"
	line "desweit miteinan-"
	cont "der interagieren."
	
	para "Lasst uns auch"
	line "weiterhin unser"
	para "Bestes geben,"
	line "damit sich Trainer"
	para "eines Tages auch"
	line "über Ländergrenzen"
	para "hinweg miteinander"
	line "verbinden können!"

	para "<……> <……> <……>"
	done

PokecomCenterAdminOfficeMobile_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0, 31, GOLDENROD_POKECENTER_1F, 3
	warp_event  1, 31, GOLDENROD_POKECENTER_1F, 3

	def_coord_events

	def_bg_events
	bg_event  6, 26, BGEVENT_UP, PokecomCenterAdminOfficeMobileComputer1
	bg_event  6, 28, BGEVENT_UP, PokecomCenterAdminOfficeMobileComputer2
	bg_event  3, 26, BGEVENT_UP, PokecomCenterAdminOfficeMobileComputer3

	def_object_events
	object_event  4, 28, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PokecomCenterAdminOfficeMobileScientist1Script, -1
	object_event  7, 27, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PokecomCenterAdminOfficeMobileScientist2Script, -1
	object_event  7, 29, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PokecomCenterAdminOfficeMobileScientist3Script, -1
