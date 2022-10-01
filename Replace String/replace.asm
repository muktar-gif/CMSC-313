;/////////////////////////////////////////////////////////////////////////////////////////
;Author: Muhammed Muktar
;UMBC ID: mmuktar1@umbc.edu, Student ID: CV34619
;Description: Code asks user for a location between 1-16 then changes a random string in
;that location to a random character
;/////////////////////////////////////////////////////////////////////////////////////////
	
	section .data
askLocation:	db "Enter a location you want to replace", 10
askLen:		equ $ - askLocation

orignalStrMsg1:	db "Here is the original string", 10
msg1Len:	equ $ - orignalStrMsg1
	
updatedStrMsg2	db "Here is the string with the random character updated", 10
msg2Len:	equ $ - updatedStrMsg2
	
new_line:	db 10

	section .bss
	
loc1:		resb 1		;location entered, first two bytes for number last for 'enter'
loc2:		resb 2
	
randomString:	resb 16		;random string to be generated

ranChar:	resb 1		;single character to be generated

	section .text

	global main

main:	

	mov rax, 1		;print askLocation
	mov rdi, 1
	mov rsi, askLocation
	mov rdx, askLen
	syscall

	mov rax, 0		;request input from user for first loc
        mov rdi, 0
        mov rsi, loc1
	mov rdx, 1
	syscall

	mov rax, 0              ;request input from user for second loc
        mov rdi, 0
        mov rsi, loc2
        mov rdx, 2
        syscall

	mov rax, 1              ;print msg1
        mov rdi, 1
        mov rsi, orignalStrMsg1
        mov rdx, msg1Len
        syscall


	call createString
	
	mov rax, 1              ;print random string
        mov rdi, 1
        mov rsi, randomString
        mov rdx, 16
        syscall

	mov rax, 1              ;print newline
        mov rdi, 1
        mov rsi, new_line
        mov rdx, 1
        syscall

	
	mov r8, randomString	;copies address for string to r8
	
	xor r9, r9		;clears registers
        xor r10, r10

	mov r9b, byte [loc1]	;puts loc values  into register 9 and 10
	mov r10b, byte [loc2]
	
	sub r9, 48 		;converts to integer
	sub r10, 48
	
	xor rax, rax		;clears rax
	mov al, r9b		;prepares tenth digit number to be multiplied by 10

	xor rbx, rbx		
	mov bl, 10		
	mul bl			;tenth digit gets multiplied by 10
	
	add r10b, al		;adds results to r10(loc2)
	sub r10b, 1		;realigns address to be updated
	add r8, r10		;moves r8 to specific address

	call randomGen		;updates random character
	xor rcx, rcx
	mov cl, [ranChar]
	mov [r8], cl		;changes location to new random character

	

	mov rax, 1              ;print msg2
        mov rdi, 1
        mov rsi, updatedStrMsg2
        mov rdx, msg2Len
        syscall

	mov rax, 1              ;print updateed random string
        mov rdi, 1
        mov rsi, randomString
        mov rdx, 16
        syscall

	mov rax, 1              ;print newline
        mov rdi, 1
        mov rsi, new_line
        mov rdx, 1
        syscall

	
	mov rax, 60		;sys call exit
	xor rdi, rdi
	syscall
	
createString:

        xor r8, r8
        xor rcx, rcx
        mov r8, randomString	;copies to random string adress

        call randomGen		;creates first random character
        mov cl, [ranChar]
        mov [r8], cl

        call addRandomChar	;generates the rest of the string
        call addRandomChar
        call addRandomChar
        call addRandomChar
        call addRandomChar
        call addRandomChar
        call addRandomChar
        call addRandomChar
        call addRandomChar
        call addRandomChar
        call addRandomChar
        call addRandomChar
        call addRandomChar
        call addRandomChar
        call addRandomChar

addRandomChar:

        inc r8			;goes to next address

        call randomGen		;creates random character
        mov cl, [ranChar]	
        mov [r8], cl		;adds character at address

	
randomGen:

	xor rax, rax 		;clear rax
        rdrand ax		;random 16-bit number

        xor edx, edx		;clear edx for remainder
        mov ecx, 25		;prepares to divide by 25
        div ecx			
        mov eax, edx		;remainder 0-25

        mov [ranChar], eax
        add [ranChar], word 97	;converts int to char
	
	
