TITLE Composite Numbers   (Project04.asm)

; Author: Nipun Bathini
; Course / Project ID Project04                Date: 2/8/16
; Description: Ask the user to enter a number between 0-400 and print that many composite numbers, while error checking for wrong numbers.

INCLUDE Irvine32.inc

; (insert constant definitions here)
UpperL = 400
LowerL = 1

.data

; (insert variable definitions here)
intro_1		BYTE	"Composite Numbers     Programmed by Nipun Bathini",0
intro_2		BYTE	"**EC: Align the output columns ",0
instruct_1	BYTE	"Enter the number of compostite numbers you would like to see.",0
instruct_2	BYTE	"I'll accept orders for up to 400 composites.",0
instruct_3	BYTE	"Enter the number of composites to display [1 .. 400]: ",0
error_1		BYTE	"Out of range. Try again. ",0
Spaces		BYTE	"      ",0 ; to align with 5 spaces

num1		DWORD	? ; the number the user will enter
compNum		DWORD	? ; to hold the current composite number
rows		DWORD	? ; to organize the rows
fact1		DWORD	? ; first number to be factored starting with 2
fact2		DWORD	? ; 
bye_1		BYTE	"Results certified by Nipun Bathini.  Goodbye."
.code
main PROC

; (insert executable instructions here)
		call	introduction
		call	GetUserData
		call	showComposites

		call	farewell

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

introduction	PROC
; Description: This section will print the introduction information explaining the program

		mov		edx, OFFSET intro_1
		call	WriteString
		call	CrLf
		mov		edx, OFFSET intro_2
		call	WriteSTring
		call	CrLf
		call	CrLf

		mov		edx, OFFSET instruct_1
		call	WriteString
		call	CrLf
		mov		edx,OFFSET instruct_2
		call	WriteString
		call	CrLf
		call	CrLf

				ret
introduction	ENDP

getUserData		PROC
;Description: this section will ask user to enter a value and reads the value, then moves on to validate
		mov		edx, OFFSET instruct_3
		call	WriteString
		call	ReadInt ;gets the users input
		mov		num1, eax

		call	validate


				ret
getUserData		ENDP

	validate		PROC
	;Description: This section will make sure the limits are within the bounds

		cmp		num1,UpperL
		jg		errormsg
		cmp		num1,LowerL
		jl		errormsg
		jmp		validated

		errormsg:
			
			mov		edx, OFFSET error_1
			call	WriteString
			call	Crlf
			call	getUserData

		validated:
					ret



	validate		ENDP

showComposites		PROC
;Description: this section will print out the composite numbers after going through check
		;call	CrLf
		mov		ecx,num1
		mov		compNum, 4 ; the first composite number is 4
		mov		rows, 0


		isCompLoop:
			call	isComposite

		printComps:
				mov		eax,compNum
				call	WriteDec
				mov		edx, OFFSET spaces ; 5 spaces betwen nums
				call	WriteString
				inc		compNum
				cmp		rows, 10
				je		nextLine
				inc		rows
				jmp		continue
			
			nextLine:
				call	CrLf
				mov		rows,1 ;sets rows back to one

			continue:
				loop	isCompLoop

			ret
showComposites		ENDP
	
	isComposite			PROC
	;description: this section verifies whether a number is composite if not it will increase the composite number and try again
		
		startFactor:
			mov		eax,compnum
			dec		eax	;decreases eax by one
			mov		fact2, eax ; move the current decreased value into fact2
			mov		fact1,2 ; the first number that will be factored is 2

		doFactor:
			mov		eax, compnum
			cdq
			div		fact1 
			cmp		edx, 0 ;This compares the REMainder to 0
			je		finish ;if it is equal to 0 then it is comp so leave this section
			inc		fact1 ;if its not then increase the factor
			mov		eax, fact1
			cmp		eax,fact2
			jle		doFactor
			inc		compnum ;increase the number and test the next
			jmp		startFactor ;restart process with new number

		finish:
					ret
	isComposite			ENDP

farewell		PROC
;description: this section simply says good bye
		call	CrLf
		mov		edx,OFFSET bye_1
		call	WriteString
		call	CrLf
		call	CrLf

				ret
farewell		ENDP

END main
