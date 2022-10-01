;/////////////////////////////////////////////////////////////////////////////////////////
;Author: Muhammed Muktar
;UMBC ID: mmuktar1@umbc.edu, Student ID: CV34619
;File Name: compHard.asm
;Description: This is the hard version of the computer. If player is about to win it chooses
; an index to stop the player from winning, else it plays like computerEasy
;/////////////////////////////////////////////////////////////////////////////////////////

	extern compEasy
	
        section .bss
checkSection:   resb 1 		;keeps track of section to check
index:		resb 1		;holds index

	
        section .text
        global compHard


compHard:

        xor r8, r8
        mov r8, rdi		;stores board

        xor r10, r10
        xor r9, r9
        xor rax, rax

	xor r11, r11		;used to store empty index
	
        cmp [checkSection], byte 0 ;row 1
        je row1
        cmp [checkSection], byte 1 ;row 2
        je row2
        cmp [checkSection], byte 2 ;row 3
        je row3
        cmp [checkSection], byte 3 ;row 4
        je row4
        cmp [checkSection], byte 4 ;col 1 
        je col1
        cmp [checkSection], byte 5 ;col 2
        je col2
        cmp [checkSection], byte 6 ;col 3
        je col3
        cmp [checkSection], byte 7 ;col 4
        je col4
        cmp [checkSection], byte 8 ;diag 1
        je diag1
        cmp [checkSection], byte 9 ;diag 2
        je diag2

        mov [checkSection], byte 0 ;clears
	mov [index], byte 0	   ;clears
	
        xor rax, rax            ;zero if no potential wins
	call compEasy
	
        ret



row1:
        inc byte [checkSection] ;tracks section

        mov r10, 1              ;increase by 1 index, r8 starts at 0
	mov [index], byte 0	;holds index
	
        jmp while               ;adds sum in r9


row2:
        inc byte [checkSection] ;tracks section

        mov r10, 1              ;increase by 1 index
        add r8, 4               ;start index at 4
	mov [index], byte 4	;holds index
	
        jmp while               ;adds sum in r9


row3:
        inc byte [checkSection] ;tracks section

        mov r10, 1              ;increase by 1 index
        add r8, 8               ;start index at 8
	mov [index], byte 8     ;holds index
	
        jmp while               ;adds sum in r9


row4:
        inc byte [checkSection] ;tracks section

        mov r10, 1              ;increase by 1 index
        add r8, 12              ;start index at 12
	mov [index], byte 12    ;holds index
	
        jmp while               ;adds sum in r9



col1:
        inc byte [checkSection] ;tracks section
        mov r10, 4              ;increase by 4 index, index starts at 0
	mov [index], byte 0     ;holds index
	
        jmp while               ;adds sum in r9


col2:
        inc byte [checkSection] ;tracks section
        mov r10, 4              ;increase by 4 index
        add r8, 1               ;start index at 1
	mov [index], byte 1     ;holds index

        jmp while               ;adds sum in r9



col3:
        inc byte [checkSection] ;tracks section

        mov r10, 4              ;increase by 4 index
        add r8, 2               ;start index at 2
	mov [index], byte 2     ;holds index
	
        jmp while               ;adds sum in r9


col4:
        inc byte [checkSection] ;tracks section

        mov r10, 4              ;increase by 4 index
        add r8, 3               ;start index at 3
	mov [index], byte 3     ;holds index
	
        jmp while               ;adds sum in r9


diag1:
        inc byte [checkSection] ;tracks section

        mov r10, 5              ;increase by 5 index, index starts at 0
	mov [index], byte 5     ;holds index
	
        jmp while               ;adds sum in r9


diag2:

        inc byte [checkSection] ;tracks section

        mov r10, 3              ;increase by 3 index
        add r8, 3               ;start index at 3
	mov [index], byte 3     ;holds index
	
        jmp while               ;adds sum in r9


while:

	cmp al, 3               ;if rax is above 3
        ja done
	

        add r9, [r8]    	;add to total sum (r9)
	
	cmp byte [r8], byte 32	;if there is an empty space
	je saveIndex		;saves index

	jmp continueWhile	;goes back to while loop

saveIndex:
	mov r11, [index]	;stores index in r11

continueWhile:	
	
        add r8, r10		;updates index
	add [index], r10	;stores new index

	
        add al, 1

        jmp while               ;loops


done:

        sub r9, 360
        cmp r9b, byte 32	;player in near winning 
        je getIndex		;gets specific index

        jmp compHard 		;loops, no potential wins for now

getIndex:

        mov [checkSection], byte 0 ;clears
	mov [index], byte 0	   ;clears
		
	xor rax, rax	
        mov al, r11b		;returns stored empty index
        ret


