;/////////////////////////////////////////////////////////////////////////////////////////
;Author: Muhammed Muktar
;UMBC ID: mmuktar1@umbc.edu, Student ID: CV34619
;File Name: main.asm	
;Description: Code is a 4 by 4 tic tac game that has differnt modes. The player plays
;against a comuters that has two difficulties easy mode and hard. 
;/////////////////////////////////////////////////////////////////////////////////////////

	extern printf
	extern scanf
	extern randomNum
	extern drawBoard
	extern compEasy
	extern compHard
	extern checkWinner

	
	section .data

welcome:	db "Welcome to TIC-TIC-ASSEMBLY", 0
listOptions:	db "Pick an option from the menu below:", 0
compOptions:	db "a - Easy", 10, "b - Hard", 0
quitOption:	db "q - quit", 0

invalid:	db "Invalid Input!", 0
win:		db "YOU WIN!", 0
lose:		db "COMPUTER WINS!", 0
draw:		db "It's a draw!", 0
enterLoc: 	db "Enter a location on the board 1-16", 0
emptySpace:	db "This is not an empty space. Try again!", 0

	
fmtPrint:	db "%s", 10, 0
fmtOptions:	db "%s", 10, "%s", 10, "%s", 10, 0

fmtChar:	db "%c", 0
fmtNum:		db "%d", 0
fmtChk:		db "%c", 10, 0
	
ticBoard:	db "                " ;16 spaces

	section .bss
menuInput:	resb 1		;takes input for menu
boardLoc:	resb 2		;takes input for board location
enterInput:	resb 1		;takes the enter input from user


	section .text
	
	global main


main:
	
        mov rdi, fmtPrint	;prints welcome
        mov rsi, welcome
        xor rax, rax
        call printf
	
	call menu		;runs menu

	mov rax, 60             ;syscall exit
        xor rdi, rdi
        syscall



menu:
      
        mov rdi, fmtOptions	;prints options
        mov rsi, listOptions
        mov rdx, compOptions
        mov rcx, quitOption
        xor rax, rax
        call printf
	
	
	mov rdi, fmtChar	;request menu input
	mov rsi, menuInput
	xor rax, rax
	call scanf

	mov rdi, fmtChar	;takes care of enter input
        mov rsi, enterInput
        xor rax, rax
        call scanf
	
        cmp [menuInput], byte 113 ;player quits game
	je done
	
	cmp [menuInput], byte 97 ;continues game if player enters a
	je askLocation

        cmp [menuInput], byte 98 ;continues game if player enters b
        je askLocation

	
	mov rdi, fmtPrint	;prints invalid, goes back to menu
	mov rsi, invalid
	xor rax, rax
	call printf

	
	jmp menu		;restarts

askLocation:

        mov rdi, fmtPrint	;prints enter location
        mov rsi, enterLoc
        mov rax, 0
        call printf


        mov rdi, fmtNum		;request a number from player
        mov rsi, boardLoc
        xor rax, rax
        call scanf

        mov rdi, fmtChar	;takes care of enter input
        mov rsi, enterInput
        xor rax, rax
        call scanf

	
	cmp [boardLoc], byte 1	;checks lower bound for input
	jb validateLoc

	cmp [boardLoc], byte 16	;check higher bound for input
        ja validateLoc

	xor r8, r8
        mov r8, ticBoard        ;gets address of board

        xor r9, r9
        mov r9b, [boardLoc]
        sub r9b, 1              ;aligns index
        add r8, r9              ;moves r8 to desired index

	
	cmp [r8], byte 32	;makes sure index is empty
        jne notEmpty
	
	
        jmp playGame		;continues games


notEmpty:

	mov rdi, fmtPrint       ;prints not empty
        mov rsi, emptySpace
        mov rax, 0
        call printf

	jmp askLocation		;restarts ask location


validateLoc:

	mov rdi, fmtPrint	;prints invalid
        mov rsi, invalid
        mov rax, 0
        call printf

	jmp askLocation		;restarts ask location
	

playGame:

	xor r8, r8
	mov r8, ticBoard	;gets address of board
	
	xor r9, r9
	mov r9b, [boardLoc]
	sub r9b, 1		;aligns index
	add r8, r9		;moves r8 to desired index
		
	mov [r8], byte 120	;updates board

	mov rdi, ticBoard	;draw board
	call drawBoard		

	mov rdi, ticBoard	;check for winner
        call checkWinner

        mov r10b, al	
        cmp r10b, byte 120	;player won
        je wonGame
	
	cmp [menuInput], byte 97 ;computer difficulty easy
	je compEasyTurn 	

	cmp [menuInput], byte 98 ;computer difficulty hard
	je compHardTurn
       
	jmp done
	
compEasyTurn:

	mov rdi, ticBoard	
	call compEasy		;call to get easy index

	xor r9, r9
	mov r9w, ax

	mov r8, ticBoard
        add r8, r9              ;moves r8 to desired index

	mov [r8], byte 111      ;updates board

	mov rdi, ticBoard
        call drawBoard		;draw board

	mov rdi, ticBoard
        call checkWinner	;check for winner

        mov r10b, al
        cmp r10b, byte 111
        je loseGame		;computer wins

	cmp r10b, byte 1	;1 = tie game
        je tieGame		;game is tied

	
	jmp askLocation		;loops game
	
compHardTurn:	


	mov rdi, ticBoard	
	call compHard		;call to get hard index

	xor r9, r9
        mov r9w, ax

        mov r8, ticBoard
        add r8, r9              ;moves r8 to desired index

        mov [r8], byte 111      ;updates board
	
        mov rdi, ticBoard
        call drawBoard		;draw board
	
        mov rdi, ticBoard
        call checkWinner	;checks for winner

        mov r10b, al
        cmp r10b, byte 111
        je loseGame		;computer wins

	cmp r10b, byte 1	;1 - tie game
	je tieGame		;game is tied
	

	jmp askLocation


wonGame:

	mov rdi, fmtPrint       ;prints won
        mov rsi, win
        mov rax, 0
        call printf

	jmp clearBoard		;clears board
	

loseGame:

	mov rdi, fmtPrint       ;prints lose
        mov rsi, lose
        mov rax, 0
        call printf

	
	jmp clearBoard		;clears board
	
tieGame:

	mov rdi, fmtPrint       ;prints tie
        mov rsi, draw
        mov rax, 0
        call printf

	jmp clearBoard		;clears board


clearBoard:
	
	xor r8, r8
	mov r8, ticBoard

	xor r10, r10

while:				;loops 16 times
	cmp r10b, 15
	ja doneClear

	mov [r8], byte 32	;clears board
	inc r8

	inc r10

	jmp while
	
doneClear:

	jmp menu		;restart game
	
	
done:				;player quit

	

