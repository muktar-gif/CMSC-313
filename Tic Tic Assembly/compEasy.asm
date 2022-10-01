;/////////////////////////////////////////////////////////////////////////////////////////
;Author: Muhammed Muktar
;UMBC ID: mmuktar1@umbc.edu, Student ID: CV34619
;File Name: computerEasy.asm
;Description: Code uses randomNum to generate an index  and check if index is not empty
;
;/////////////////////////////////////////////////////////////////////////////////////////

	extern randomNum
	
	section .text
	global compEasy


compEasy:


	xor r8, r8
	mov r8, rdi		;hold board address

	call randomNum
	
	xor r9, r9
	mov r9w, ax		;stores random number 0-15

	add r8, r9		;goes to index

	cmp [r8], byte 32	;makes sure there is an empty space
	jne compEasy
		
	xor rax, rax		;returns index
	mov rax, r9
	
	ret
	
	
	
