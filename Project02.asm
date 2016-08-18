TITLE Fibonnaci Numbers    (project02.asm)

; Author: Nipun Bathini
; Course / Project ID : Project #2                Date: 1/20/16
; Description: Take a users name and print, ask for number of fibonnaci terms to be displayed, validate and print

INCLUDE Irvine32.inc

; (insert constant definitions here)

UpperL = 46
LowerL = 1
.data

; (insert variable definitions here)
intro_1		BYTE	"Fibonacci Numbers",0
intro_2		BYTE    "Programmed by Nipun Bathini",0
instruct_1  BYTE    "Enter the number of Fibonacci terms to be displayed",0
instruct_2	BYTE	"Give the number as an integer in the range [1 .. 46].",0
error_1		BYTE	"Out of range. Enter a number in [1 .. 46]",0
bye_1		BYTE	"Results certified by Nipun Bathini",0
bye_2		BYTE	"Goodbye, ",0
Q_1			BYTE	"How many Fibonacci terms do you want?",0
Wname		BYTE	"What's your name?",0
Hello		BYTE	"Hello, ",0
Spaces		BYTE	"     ",0
userName	BYTE    33 DUP(0) ;for their name
Number1		DWORD	? ;int to be entered
PrevSum		DWORD	? ;previous sum for forloop adding
rows		DWORD	? ;to make sure 5 numbers per row
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

;Print Instructions
	mov		edx, OFFSET instruct_1
	call	WriteString
	call	CrLf

	mov		edx, OFFSET instruct_2
	call	WriteString
	call	CrLf
	call	CrLf

;Get User Data

	getUserData:
		mov		edx, OFFSET q_1
		call	WriteString
		call	ReadInt
		cmp		eax,LowerL ;compare to lower limit
		jl		ErrorMessage
		cmp		eax,UpperL ;compare to upper limit
		jg		ErrorMessage
		jmp		setVariable

	ErrorMessage:  ;print error message and restart
		mov		edx, OFFSET error_1
		call	WriteString
		call	CrLf
		jmp		getUserData

	setVariable:
		mov		Number1,eax
		call CrLf

;DisplayFibs

	mov		ecx, Number1 ;to ensure it runs number1 times
	mov		eax, 0 ;reset to 0 
	mov		ebx, 1 ; reset so its starts adding the 1 at start
	mov		rows, 1
	
	printingLoop:
		mov		PrevSum, eax
		add		eax, ebx ; adds to the previous sum
		call	WriteDec
		mov		edx,OFFSET spaces
		call	WriteString
		mov		ebx,PrevSum
		cmp		rows,5
		je		nextLine; if equal to
		jne		incrRows ; if not equal to

		nextLine:
			mov rows,0 ;reset rows to 0
			call CrLf
		incrRows:
			inc rows

	loop printingLoop

		
;Goodbye 
	call	CrLf
	call	CrLf
	mov		edx, OFFSET bye_1
	call	WriteString
	call	CrLf

	mov		edx, OFFSET bye_2
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	call	CrLf


; 

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
