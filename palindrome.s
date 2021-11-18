
@Made by Christopher Bennett, Cameron Thacker, Brennan Gallamoza


	main:
		mov r7, #0		@ initialize the length of the string
		mov r1, #0		@ load input type into r1, 0 as input
		ldr r0, =InFileName	@ load file name into r0
		swi 0x66		@ returns r0 <-- the file handle
		ldr r1, =InFileHandle	@ load pointer to in file handle into r1
		str r0, [ r1 ]		@ stored file handle returned in InFileHandle pointer
		ldr r1, =CharBuffer	@ loading CharBuffer pointer into r1
		
	reader:
		@@@ word.txt file handle initialization
		ldr r0, =InFileHandle	@ loading file handle into r0
		ldr r0, [r0]		@ dereferencing r0
		mov r2, #32		@ move max amount of bytes to be read into 
		@@@ before reading of string with only 1 byte being read
		swi 0x6a		@ read string into r1 addr, which is pre-allocated string
		@@ string is now in r1
		mov r4, #0		@ set loop i to 0
		
	get_len:
		ldrb r0, [r1,r4]	@ load thestring[r4] into r0
		cmp r0, #0		@ when r0 == 0, then we reached the null character at the end
		beq gl_end
		swi 0x00		@ print out character for sanity check
		add r4, r4, #1		@ increment the loop variable by 1		so basically what were doing is a while loop --> 	int len = 0; int i = 0;
		add r7, r7, #1		@ increment the length											while ( theString[i] != '\0' ) {
		b get_len		@ repeat loop until we reach null character									len++; i++;
	gl_end:				@ end of loop, when we reach null character								}
		@@ now, we can begin to start at the end, and see if the string is a palindrome

		mov r4, r7		@ set j = len-1 of string
		sub r4, r4, #1		@ decrement by 1 to be len-1
		mov r2, #0		@ set i = 0 index
		
	palinloop:
		cmp r2, r4		@@ end loop when i == j
		beq ipalin		@@ if they are equal, end loop, we found a palindrome
		ldrb r0, [r1,r2]	@@ load character at r1[i]
		ldrb r3, [r1,r4]	@@ load character at r1[j]
		cmp r0, r3		@@ compare the two, if they are not equal immediately branch to not palindrome
		bne npalin		@@ not a palindrome
		add r2, r2, #1		@@ increment i
		sub r4, r4, #1		@@ decrement j
		b palinloop		@@ repeat loop
		
	npalin:				@@ prints out that the string is not a palindrome
		ldr r0, =notpalin	@@ loads the string "Not Palindrome" into r0
		swi 0x02		@@ prints out the string above to stdout
		b exit
		
	ipalin:				@@ prints out that the string is a palindrome
		ldr r0, =ispalin	@@ loads string "Palindrome" into r0
		swi 0x02		@@ prints out string "Palindrome" to stdout
		b exit
		
	exit:
		swi 0x11


.data
.align
InFileName: .ascii "word.txt"
InFileHandle: .word 0
CharBuffer: .skip 99999999
notpalin: .ascii "\nNot Palindrome\0"
ispalin:  .ascii "\nPalindrome\0"
