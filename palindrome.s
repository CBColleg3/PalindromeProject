
@Made by Christopher Bennett, Cameron Thacker, Brennan Gallamoza


	main:
		mov r1, #0		@ load input type into r1, 0 as input
		ldr r0, =InFileName	@ load file name into r0
		swi 0x66		@ returns r0 <-- the file handle
		ldr r1, =InFileHandle	@ load pointer to in file handle into r1
		str r0, [ r1 ]		@ stored file handle returned in InFileHandle pointer
		mov r0, #1		@ before malloc
		swi 0x12		@ return r0 <-- addr of block
		ldr r1, =CharBuffer	@ loading CharBuffer pointer into r1
		str r0, [r1]		@ store 1 byte block in CharBuffer
	reader:
		ldr r0, =InFileHandle	@ loading file handle into r0
		ldr r0, [r0]		@ rereferencing r0
		ldr r1, [r1]		@ dereferencing char buffer
		mov r2, #1		@ move max amount of bytes to be read into 





.data
InFileName: .ascii "word.txt"
InFileHandle: .word 0
CharBuffer: .word 0
length: .4byte 0
