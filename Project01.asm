TITLE Elementary Arithmetic    (Project01.asm)

; Author: Nipun Bathini
; Course / Project ID: Project #1                 Date: 1/6/16
; Description: Displays name and program title, with instructions to prompt 2 numbers and will calculate simple arithmetic

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

; (insert variable definitions here)

Number1	   DWORD	?	;int to be entered for number 1
Number2    DWORD	?	;int to be entered for num 2
MultAns	   DWORD	?	;answer to multiplication
DivAns	   DWORD	?	;ans to division
AddAns	   DWORD	?	;answer to addition
DiffAns	   DWORD	?	;differnece
RemAns	   DWORD	?	;remainder			
intro_1    BYTE	    "Elementary Arithmetic     by Nipun Bathini",0
intro_2    BYTE	    "Enter 2 numbers, and I'll return the sum, difference, quotient, and remainder.",0
prompt_1   BYTE		"First Number: ",0
prompt_2   BYTE		"Second Number: ",0
addit		   BYTE		" + ",0	
subtract   BYTE		" - ",0
multiply   BYTE		" x ",0
divide     BYTE		" / ",0
rem		   BYTE		" remainder ",0
equal	   BYTE		" = ",0			 
goodBye	   BYTE		"Impressed?  Bye!"
		

.code
main PROC

; (insert executable instructions here)

; Introduce everything
	mov		edx, OFFSET intro_1
	call	WriteSTring
	call	CrLf
	call	CrLf

	mov		edx, OFFSET intro_2
	call	WriteString
	call	CrLf
	call	CrLf

; get data 
	mov		edx, OFFSET prompt_1
	call	WriteString
	call	ReadInt
	mov		Number1, eax

	mov		edx, OFFSET prompt_2
	call	WriteString
	call	ReadInt
	mov		Number2, eax


; calculate values
	mov		eax,Number1
	mov		ebx,Number2
	add		eax,ebx
	mov		Addans, eax

	mov		eax,Number1
	mov		ebx,Number2
	sub		eax,ebx
	mov		DiffAns, eax

	mov		eax,Number1
	mov		ebx,Number2
	mul		ebx
	mov		MultAns, eax

	mov		eax,Number1
	mov		ebx,Number2
	div		ebx
	mov		DivAns, eax
	mov		RemAns, edx

	


;display data
	mov		eax, Number1
	call	WriteDec
	mov	    edx, OFFSET addit
	call	WriteString
	mov		eax, Number2
	call	WriteDec
	mov		edx, OFFSET equal
	call	WriteString
	mov		eax, Addans
	call	WriteDec

	call CrLf
	 
	mov		eax, Number1
	call	WriteDec
	mov	    edx, OFFSET subtract
	call	WriteString
	mov		eax, Number2
	call	WriteDec
	mov		edx, OFFSET equal
	call	WriteString
	mov		eax, DiffAns
	call	WriteDec

	call CrLf
	 
	mov		eax, Number1
	call	WriteDec
	mov	    edx, OFFSET multiply
	call	WriteString
	mov		eax, Number2
	call	WriteDec
	mov		edx, OFFSET equal
	call	WriteString
	mov		eax, MultAns
	call	WriteDec

    call CrLf
	 
	mov		eax, Number1
	call	WriteDec
	mov	    edx, OFFSET divide
	call	WriteString
	mov		eax, Number2
	call	WriteDec
	mov		edx, OFFSET equal
	call	WriteString
	mov		eax, DivAns
	call	WriteDec
    mov		edx, OFFSET rem
	call    WriteString
	mov		eax, RemAns
	call	WriteDec




;say bye
	call CrLf
	mov		edx,OFFSET goodBye
	call	WriteSTring
	call	CrLf
	
	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main

