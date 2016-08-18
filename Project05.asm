TITLE Sorting Random Integers     (Project05.asm)

; Author: Nipun Bathini
; Course / Project ID  Project05           Date: 2/24/16
; Description: This program will ask the user for a number of random numbers, make a unsorted list, print it, find median and then sort and print


INCLUDE Irvine32.inc

; (insert constant definitions here)
min = 10
max = 200
lo = 100
hi = 999
.data

; (insert variable definitions here)
intro_1		BYTE	"Sorting Random Integers     Programmed by Nipun Bathini",0
intro_2		BYTE	"**EC: Uses recursvie sorting algorithm",0
instruct_1	BYTE	"This Program generates randome numbers in the range[100 .. 999],",0
instruct_2	BYTE	"displays the orginal list, sorts the list, and calculates the ",0
instruct_3	BYTE	"median value. Finally, it displays the list sorted in descending order.",0
instruct_4	BYTE	"How many numbers should be generated?[10 .. 200]: ",0
error_1		BYTE	"Invalid input",0
unsortmsg_1	BYTE	"The unsorted random numbers: ",0
sortmsg_1	BYTE	"The sorted list: ",0
medmsg_1	BYTE	"The median is ",0
medmsg_2	BYTE	". ",0
spaces		BYTE	"     ",0


pNum		DWORD	?; to pass by value
totNum		DWORD	? ; will hold the user entered how many numbers
sortCheck	DWORD	?;used to check if unsorter or sorted message is printed
steps		DWORD	?
pList		DWORD	max		DUP(?)
address		DWORD	?
medcount	DWORD	?
median		DWORD	?
.code
main PROC

; (insert executable instructions here)
	call	introduction
	push	OFFSET pNum
	call	getData

	call	Randomize

	push	OFFSET pList
	push	pNum
	call	fillArray

	push	OFFSET plist
	push	pNum
	push	OFFSET unsortmsg_1
	call	DisplayList

	push	OFFSET plist
	push	pNum
	call	sortList

	push	OFFSET plist
	push	pNum
	call	displayMedian

	push	OFFSET plist
	push	pNum
	push	OFFSET sortmsg_1
	call	DisplayList

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

introduction PROC
;Description:  This section introduces the program to the user

	;mov		sortCheck,1 ; list has not been sorted
  
	mov		edx, OFFSET intro_1
	call	WriteSTring		;print intro messages
	call	CrLf
	;mov		edx, OFFSET intro_2 
	;call	WriteSTring
	call	CrLf
	call	CrLf

	mov		edx, OFFSET instruct_1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET instruct_2
	call	WriteString
	call	CrLf
	mov		edx, OFFSET instruct_3
	call	WriteString
	call	CrLf
	call	CrLf

				ret
introduction	ENDP


getData		PROC
;description: this section gets the user range of numbers and validates that number
	push	ebp
	mov		ebp, esp


	verify:
		mov		edx, OFFSET instruct_4
		call	WriteString
		mov		ebx ,[ebp+8] ;get address into ebx
		call	ReadInt
		mov		[ebx],eax
		pop		ebp ;pop the ebp register
		mov		totNum, eax

		cmp		totNum,max
		jg		errormsg  ;if greater than will jump to error messages
		cmp		totNum,min
		jl		errormsg  
		jmp		validated

	errormsg:
		mov		edx, OFFSET error_1
		call	WriteString
		call	CrLf
		jmp		verify ;rerun verify

	validated:
		ret	4

getData		ENDP


fillArray	PROC
;description:this section will fill the array wiht random numbers 

	push	ebp
	mov		ebp, esp
	mov		edi,[ebp+12] ; set to point at  first index of the array
	mov		ecx,[ebp+8] ; the loop starts with what the user entered earlier

	fillUp:
		mov		eax,hi
		sub		eax, lo
		inc	eax
		call	RandomRange  ;this will generate random values between the high and the low 
		add		eax,lo
		mov		[edi], eax ;to save the values
		add		edi, 4
		loop	fillUp
		
	
	finish:
			pop		ebp
			ret 8
fillArray	ENDP


sortList	PROC
;description: this section will sort the array in descending order
	
	push	ebp
	mov		ebp,esp
	;mov		esi,[ebp+12]
	mov		ecx,[ebp+8]
	dec		ecx		;so it loops one less time
	

	start:
		push	ecx
		mov		esi,[ebp+12]
	
	compare:
		mov		eax,[esi] ;puts value of array into eax
		cmp		[esi+4],eax
		jl		nextNum
		xchg	eax,[esi+4] ; xchg is used to swap the numbers
		mov		[esi], eax

	nextNum:
		add		esi,4
		loop	compare
	
	pop		ecx
	loop	start

	finish:
		;mov		sortCheck,3
		pop		ebp
		ret 8
sortList	ENDP

displayMedian	PROC
;description: this will calculate and display the median, sepertaed into two incase you have an even number

	push	ebp
	mov		ebp,esp
	mov		esi,[ebp+12]
	mov		eax,[ebp+8]
	mov		edx,0
	
	mov		ebx,2
	div		ebx
	cmp		edx,0
	je		calc ;if you have an even number

	mov		ebx,4
	mul		ebx
	add		esi,eax
	mov		eax,[esi]

	call	Crlf
	call	Crlf
	mov		edx,OFFSET medmsg_1
	call	WriteString
	mov		median,eax
	call	WriteDec
	mov		edx,OFFSET medmsg_2
	call	WriteString
	call	CrLf
	jmp		finish

	calc:  
		mov		ebx,4
		mul		ebx
		add		esi,eax
		mov		edx,[esi] ;stores higher

		mov		eax,esi
		sub		eax,4
		mov		esi,eax
		mov		eax,[esi] ;store lower

		add		eax,edx
		mov		edx,0
		mov		ebx,2
		cdq
		div		ebx ;gives average

		call	Crlf
		call	Crlf
		mov		edx,OFFSET medmsg_1
		call	WriteString
		;mov		median,eax
		call	WriteDec
		mov		edx,OFFSET medmsg_2
		call	WriteString
		call	CrLf
	
	finish:
		pop		ebp
		ret 8

displayMedian	ENDP

displayList		PROC
;description: this section is going to display the list unsorted/sorted
	

	push	ebp
	mov		ebp,esp
	mov		esi,[ebp+16]
	mov		ecx,[ebp+12]; once again the user entered num to loop
	mov		ebx,1
	

	call	CrLf
	call	CrLf
	

	mov		edx,[ebp+8]
	call	WriteString
	call	CrLf

	

	show:

		cmp		ebx,10
		jg		nextLine
		mov		eax,[esi] ;move current number to eax to print
		call	WriteDec
		mov		edx,OFFSET spaces ;places the spaces
		call	WriteSTring 
		add		esi,4   ;move to the nxt number
		add		ebx,1
		loop	show ;loop to print next number
		jmp		complete

		nextLine:
			call	CrLf
			mov		ebx,1
			jmp		show
		
		complete:
				call	CrLf
				pop	ebp
				ret 12
displayList		ENDP



END main
