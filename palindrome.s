
@Made by Bababooey, Cameron Thacker, Brennan Gallamoza


	main:
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
		mov r2, #2		@ move max amount of bytes to be read into 
		@@@ before reading of string with only 1 byte being read
		swi 0x6a
		ldrb r4, [r1]
		mov r0, r4
		swi 0x00
		cmp r0, #0
		bne reader




.data
.align
InFileName: .ascii "word.txt"
InFileHandle: .word 0
CharBuffer: .skip 1
length: .4byte 0
