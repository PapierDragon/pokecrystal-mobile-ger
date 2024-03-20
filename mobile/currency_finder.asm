; Input: DE = the memory address were the string should be written. Also, wPrefecture should be set to the prefecture of the user.
; Output: it edits the bytes pointed by DE.
WriteCurrencyName::
	call DetermineCurrencyName
	call CopyCurrencyString
	ret

; Input: none. wPrefecture should be set to the prefecture of the user.
; Output: HL = the address of the string to use for the currency.
DetermineCurrencyName:
	ld a, [wPrefecture] ; Loads the Prefectures index (starts at 0) selected by the player. The Prefectures list is stored into mobile_12.asm
	dec a ; Beware: it the value is 0, dec will underflow and default to the default value
	
	ld hl, String_Currency_Rappen
	cp 25  ; Aargau
	ret z	
	cp 26  ; Appenzell Innerrhoden
	ret z	
	cp 27  ; Appenzell Ausserrhoden
	ret z	
	cp 28  ; Berne
	ret z	
	cp 29  ; Basel-Landschaft
	ret z	
	cp 30  ; Basel-Stadt
	ret z	
	cp 31  ; Fribourg
	ret z	
	cp 32  ; Genève
	ret z	
	cp 33  ; Glarus
	ret z	
	cp 34  ; Graubünden
	ret z	
	cp 35  ; Jura
	ret z	
	cp 36  ; Luzer
	ret z	
	cp 37  ; Neuchâtel
	ret z	
	cp 38  ; Nidwalden
	ret z	
	cp 39  ; Obwalden
	ret z	
	cp 40  ; Sankt Gallen
	ret z	
	cp 41  ; Schaffhausen
	ret z	
	cp 42  ; Solothurn
	ret z	
	cp 43  ; Schwyz
	ret z	
	cp 44  ; Thurgau
	ret z	
	cp 45  ; Ticino
	ret z	
	cp 46  ; Uri
	ret z	
	cp 47  ; Vaud
	ret z	
	cp 48  ; Valais
	ret z	
	cp 49  ; Zug
	ret z	
	cp 50  ; Zürich
	ret z	
	

	ld hl, String_Currency_Cents ; Default case. Anything that uses Cents doesn't need to be added into this check list.
	ret

; Input: HL = the address to copy from.
; Output: DE = the address to copy into.
; Stops the copy when the EOL char is found ($50 or '@').
CopyCurrencyString: ; I know this is ugly, I copied and pasted this function from mobile_46.asm
.loop
	ld a, [hli]
	cp $50
	ret z
	ld [de], a
	inc de
	jr .loop



String_Currency_Cents: ; Note that this is unoptimized, as the string "Is this OK?@" is repeted.
	db   " Cent";"えん"
	next "In Ordnung?@";"かかります　よろしい　ですか？@"

String_Currency_Rappen:
	db   " Rp.";"えん"
	next "In Ordnung?@";"かかります　よろしい　ですか？@"	
	
	