TITLE Designing low-level I/O procedures     (Project06.asm)

; Author: Nipun Bathini
; Course / Project ID  Project06               Date: 3/7/16
; Description:   This program will ask 10 unsigned decimal integers. Each validatede to meet the needs to be small enough to fit inside a 32 bit register. After finished inputting the raw numbers display a list of the integers, their sum, and their average value.

INCLUDE Irvine32.inc

getString	MACRO	instruct, input_1, input_count
	
	push	edx
	push	ecx
	push	eax
	push	ebx

	mov		edx, OFFSET instruct_5  ; to print the instruction
	call	WriteSTring


	mov		edx,OFFSET input_1  ; moves second parameter into edx
	mov		ecx,SIZEOF	input_1 ;move size of second parameter into ecx
	call	ReadString

	mov		input_count,0 ;clear input count
	mov		input_count,eax ;move eax into input count

	pop		ebx
	pop		eax
	pop		ecx
	pop		edx

ENDM

displayString	MACRO	string_1
	
	push	edx
	mov		edx, string_1
	call	WriteSTring
	pop		edx

ENDM

; (insert constant definitions here)

.data

; (insert variable definitions here)
intro_1		BYTE		"PROGRAMMING ASSIGNMENT 6: Designing low-level I/O procedures",0
intro_2		BYTE		"Written by: Nipun Bathini",0
instruct_1	BYTE		"Please provide 10 unsigned decimal integers.",0
instruct_2	BYTE		"Each number needs to be small enough to fit inside a 32 bit register.",0
instruct_3	BYTE		"After you finished inputting the raw numbers I will display a list",0
instruct_4	BYTE		"of the integers, their sum, and their average value. ",0
instruct_5	BYTE		"Please enter unsigned number: ",0
;colon_1		BYTE		":",0
error_1		BYTE		"ERROR: You did not enter a unsigned number or your number was too big.",0
;error_2		BYTE		"Please try again: ",0
;disp		BYTE		"You entered the following numbers: ",0
disp_1		BYTE		"You entered the following numbers: ",0
disp_2		BYTE		"The sum of these numbers is: ",0
disp_3		BYTE		"The average is: ",0
bye_1		BYTE		"Thanks for playing!",0
comma_1		BYTE		", ",0

input_1		DWORD		10 DUP(0)
input_count	DWORD		?
string_1	db			16  DUP(0)  ;db Page 75 of textbook, direcctive  try WORD or SWORD
array_1		DWORD		10  DUP(?)

commaCount		DWORD		1


.code
main PROC

; (insert executable instructions here)

	push	OFFSET intro_1
	push	OFFSET intro_2
	call	introduction

	push	OFFSET	instruct_1
	push	OFFSET	instruct_2
	push	OFFSET	instruct_3
	push	OFFSET	instruct_4
	call	instruction

	push	OFFSET array_1
	push	OFFSEt	input_1
	push	OFFSET	input_count
	call	ReadVal

	push	OFFSET string_1
	push	OFFSET array_1
	call	writeVal

	push	OFFSET	disp_2
	push	OFFSET  disp_3
	push	OFFSET  array_1
	call	displayCalc

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

introduction	PROC
;Description: This section will introduce the program to the user 

	pushad   ;pushes all general purpose registers
	mov		ebp,esp
	displayString [ebp+40] ;print intro_1
	call	CrLf
	displayString [ebp+36] ;print intro_2
	call	CrLf
	call	CrLf

	popad
	ret 8
introduction	ENDP


instruction		PROC
;Description: This section will print the instructions to the user

	pushad
	mov		ebp,esp
	displayString [ebp+48]
	call	CrLf
	displayString [ebp+44]
	call	CrLf
	displayString [ebp+40]
	call	CrLf
	displayString [ebp+36]
	call	CrLf
	call	CrLf
	
	popad
	ret	16

instruction		ENDP



ReadVal		PROC
;Description: This section will ask the user for a number 
	
	;pushad
	push	ebp
	mov		ebp,esp
	mov		ecx,10 ;loop 10 times for 10 inputs
	mov		edi,[ebp+16]
	;mov		linenum,1
	


	getNum:

		getString	instruct_5,input_1,input_count
		push	ecx
		mov		esi,[ebp+12]
		mov		ecx,[ebp+8]
		mov		ecx,[ecx]  ;copy teh current value of ecx

		cld		;clear direction flag
		mov		eax,0 ;clear eax
		mov		ebx,0 ;clear ebx

		convert:
			lodsb

			cmp		eax,30h ;ascii 
			jb		error   ;jump if below used for strings
			cmp		eax,39h
			ja		error	;jump if above

			sub		eax,30h
			push	eax
			mov		eax,ebx
			mov		ebx,10
			mul		ebx     ;adjust digits
			mov		ebx,eax
			pop		eax
			add		ebx,eax
			mov		eax,ebx
			mov		eax,0 
			loop	convert
		
		mov		eax,ebx
		stosd
		add		esi,4
		pop		ecx
		loop	getNum
		jmp		done

		error:
			pop		ecx
			displayString	OFFSET error_1
			call	CrLf
			jmp		getNum

		done:
			pop		ebp
			ret		12
ReadVal		ENDP


WriteVal	PROC
;Description: This section will convert and write the values
	
	push	ebp
	mov		ebp,esp
	mov		edi,[ebp+8]
	mov		ecx,10

	call	CrLf
	displayString OFFSET disp_1

	printNums:
		push	ecx
		mov		eax,[edi]
		mov		ecx,10
		xor		bx,bx  ;are bx and bx not equal

		divide:
			xor		edx,edx ;are edx and edx not equal set0
			div		ecx
			push	dx
			inc		bx
			test		eax,eax ; (page 196 in text book)
			jnz		divide
			mov		cx,bx
			lea		esi,string_1 ;load effective address (Page 298 in textbook)


		nextNum:
			pop		ax
			add		ax,'0' ;convert ascii
			mov		[esi],ax  ; move to string_1
			displayString	OFFSET string_1 ;print string_1
			loop	nextNum
		
	pop		ecx

	dispComma:
	inc		commaCount
	cmp		commaCount,11
	je		afterComma
	displayString OFFSET comma_1

	afterComma:
	mov		edx,0 ;clear
	mov		ebx,0;ckear
	add		edi,4
	loop	printNums
	jmp		done

	done:
	pop		ebp
	call	CrLf
	ret		8
WriteVal	ENDP



displayCalc	PROC
;description: this section will do the simple calculations and display them also the end message

	push	ebp
	mov		ebp,esp
	mov		esi,[ebp+8]
	mov		eax,10
	mov		edx,0
	mov		ecx,eax

	;call	CrLf

	sumLoop:
		mov		eax,[esi]
		add		ebx,eax
		add		esi,4
		loop	sumLoop

		mov		edx,0;clear
		mov		eax,ebx
		displayString	OFFSET disp_2
		call	WriteDec
		call	CrLf

	avgLoop:

		mov		edx,0;clear
		mov		ebx,10
		div		ebx
		displayString	OFFSET disp_3
		call	WriteDec
		call	CrLf
		
	done:
	call	CrLf
	displayString	OFFSET bye_1
	call	CrLf
	pop		ebp
	ret		12
displayCalc	ENDP

END main
