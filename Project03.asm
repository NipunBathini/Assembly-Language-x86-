TITLE  Integer Accumulator    (Project03.asm)

; Author: Nipun Bathini
; Course / Project ID  Project#3              Date: 1/29/16
;**EC: 1.Number the lines during user input
; Description: Ask user for numbers between -100 and -1, then calculate valid nums,sum, average, print goodbye


INCLUDE Irvine32.inc

; (insert constant definitions here)
UpperL = -1
LowerL = -100
.data

; (insert variable definitions here)
intro_1		BYTE	"Integer Accumulator ",0
intro_2		BYTE    "Programmed by Nipun Bathini",0
Wname		BYTE	"What's your name?",0
Hello		BYTE	"Hello, ",0
instruct_1  BYTE	"Please enter numbers in[-100,-1] ",0
instruct_2	BYTE	"Enter a non-negative number when you are finished to see results.",0
instruct_3  BYTE	"Enter number ",0
instruct_4	BYTE	":",0
error_1		BYTE	"ERROR: You entered a number less than -100",0
special_1	BYTE	"You didn't enter any negatives! Please enter atleast one negative integer",0
number		DWORD	? ;entered integer
sum			DWORD	?; to store the sum
turns		DWORD	? ;number of valid numbers
average		DWORD	?
linenum		DWORD	?
end_1		BYTE	"You entered ",0
end_2		BYTE	" valid numbers.",0
end_3		BYTE	"The sum of your valid numbers is ",0
end_4		BYTE	"The rounded average is ",0
bye_1		BYTE	"Thank you for playing Integer Accumulator! It's been a pleasure to meet you, ",0
userName	BYTE    33 DUP(0) ;for their name


.code
main PROC

; (insert executable instructions here)

; Introduce Myself and program name
	mov		edx, OFFSET intro_1
	call	WriteString
	call	CrLf

	mov		edx, OFFSET intro_2
	call	WriteString
	call	CrLf
	call	CrLf

; Get Users Name
	mov		edx, OFFSET Wname
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, 32
	call	ReadString

	mov		edx, OFFSET Hello
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	call	CrLf
	call	CrLf

; Give instructions

	mov		edx, OFFSET instruct_1
	call	WriteString
	call	CrLf	
	mov		edx, OFFSET instruct_2
	call	WriteString
	call	CrLf

; Get Data
	mov linenum, 1



	dataLoop:
		mov		edx,OFFSET instruct_3
		call	WriteString
		mov		eax, linenum
		call	writeDec
		mov		edx,OFFSET instruct_4
		call	WriteString
		call	ReadInt
		cmp		eax,UpperL
		jg		finishLoop ;if postive the loop will jump to finsih loop
		cmp		eax, LowerL
		jl		ErrorMessage ; if less than -100 error message
		jmp		calculate	;jumps to the calculating loop

	
	ErrorMessage:
		mov		edx,OFFSET error_1
		call	WriteString
		call	CrLf
		jmp		dataLoop ;will jump back to the loop

	Calculate:
		mov		number,eax ;sent entered int to number
		mov		eax, sum
		add		eax, number
		mov		sum,eax
		inc		turns
		inc		linenum
		jmp		dataLoop

	finishLoop:
		call	CrLf		

		;calculate average
		mov		edx,0
		mov		eax,sum
		mov		ebx,turns
		cdq
        idiv	    ebx
		mov		average,eax

		

	
		
;Display Data
	mov		edx, OFFSET end_1
	call	WriteString
	mov		eax,turns
	call	WriteDec
	mov		edx,OFFSET end_2
	call	WriteString
	call	CrLf

	mov		edx, OFFSET end_3
	call	WriteString
	mov		eax, sum
	call	WriteInt
	call	CrLf


	mov		edx, OFFSET end_4
	call	WriteString
	mov		eax, average
	call	WriteInt
	
		



; GoodBye
	call	CrLf
	call	CrLf
	mov		edx, OFFSET bye_1
	call	WriteString

	mov		edx, OFFSET username
	call	WriteString
	call	CrLf
	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
