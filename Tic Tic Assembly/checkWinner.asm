;/////////////////////////////////////////////////////////////////////////////////////////
;Author: Muhammed Muktar
;UMBC ID: mmuktar1@umbc.edu, Student ID: CV34619
;File Name: checkWinner.asm
;Description: Code takes board and checks if player or the computer won or if they tied
;
;/////////////////////////////////////////////////////////////////////////////////////////

	
	section .bss
checkSection:	resb 1 		;keeps track of section to check
	
        section .text
        global checkWinner


checkWinner:	

	xor r8, r8
	mov r8, rdi		;stores board

	xor r10, r10
        xor r9, r9
        xor rax, rax
	
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

	xor r10, r10
	jmp whileTie		;checks for tie game
tied:				;game is tied
	xor rax, rax
	mov al, byte 1		;1 = tie game
	ret
	
notTied:			;game is not tied
	
        xor rax, rax		;zero if no one won
	ret			



row1:
	
	inc byte [checkSection]	;tracks section

	mov r10, 1		;increase by 1 index, r8 starts at 0

	jmp while		;adds sum in r9

	
row2:
	inc byte [checkSection]	;tracks section
	
        mov r10, 1              ;increase by 1 index
	add r8, 4		;start index at 4

        jmp while		;adds sum in r9

	
row3:
	inc byte [checkSection]	;tracks section
	
        mov r10, 1              ;increase by 1 index
        add r8, 8               ;start index at 8

        jmp while               ;adds sum in r9

	
row4:	
	inc byte [checkSection] ;tracks section
	
        mov r10, 1              ;increase by 1 index
        add r8, 12              ;start index at 12

        jmp while               ;adds sum in r9

	
col1:
        inc byte [checkSection] ;tracks section
        mov r10, 4              ;increase by 4 index, index starts at 0

        jmp while               ;adds sum in r9


col2:
        inc byte [checkSection] ;tracks section
        mov r10, 4              ;increase by 4 index
        add r8, 1               ;start index at 1

        jmp while               ;adds sum in r9

	
col3:
        inc byte [checkSection] ;tracks section
	
        mov r10, 4              ;increase by 4 index
        add r8, 2               ;start index at 2

        jmp while               ;adds sum in r9
	

col4:
        inc byte [checkSection] ;tracks section

        mov r10, 4              ;increase by 4 index
        add r8, 3               ;start index at 3

        jmp while               ;adds sum in r9

	
diag1:
        inc byte [checkSection] ;tracks section 

        mov r10, 5              ;increase by 5 index, index starts at 0

        jmp while               ;adds sum in r9


diag2:	
        
        inc byte [checkSection] ;tracks section 

        mov r10, 3              ;increase by 3 index
        add r8, 3               ;start index at 3

        jmp while               ;adds sum in r9
	
	
while:

	cmp al, 3		;if rax is above 3, loops 4 times
	ja done			

	
	add r9, [r8]		;add to total sum (r9)
	add r8, r10		;updates index
	
	add al, 1

	jmp while 		;loops
	
	
done:

	sub r9, 360	
	cmp r9b, byte 120	;compare player won
	je won
	
	add r9, 360		;resets value
	
	sub r9, 333
	cmp r9b, byte 111	;compares computer won
	je won

	
	jmp checkWinner		;no winners

whileTie:			;loops 16 to check tie

	cmp r10b, 15		;loop ended game tied
        ja tied

	cmp [r8], byte 32	;empty space found, not tied
	je notTied
	
        inc r8			;updates index
	
        inc r10

        jmp whileTie

	
won:

	mov [checkSection], byte 0 ;resets value
	
	xor rax, rax
        mov al, r9b		;returns 120 or 111 for player won and computer won
	ret



	
