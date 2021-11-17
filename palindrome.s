


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






.data
InFileName: .ascii "word.txt"
InFileHandle: .word 0
CharBuffer: .word 0
