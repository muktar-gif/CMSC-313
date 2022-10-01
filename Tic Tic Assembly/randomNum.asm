;/////////////////////////////////////////////////////////////////////////////////////////
;Author: Muhammed Muktar
;UMBC ID: mmuktar1@umbc.edu, Student ID: CV34619
;File Name: randomNum.asm
;Description: Code just generates a random number to be used in picking a board locations	
; for computer
;/////////////////////////////////////////////////////////////////////////////////////////

	section .bss
num:		resb 1 		;stores number
	
	section .text
	global randomNum


randomNum:

	xor rax, rax            ;clear rax
        rdrand ax               ;random 16-bit number

        xor edx, edx            ;clear edx for remainder
        mov ecx, 16             ;prepares to divide by 16
        div ecx
        mov eax, edx            ;remainder 0-15

        mov [num], eax		
	
	xor rax, rax		;returns a number for 0 to 15
	mov rax, [num]	

	ret
	
	
	
