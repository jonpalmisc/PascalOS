;; PascalOS
;; Copyright (c) 2021 Jon Palmisciano
;;
;; core.asm - Kernel core assembly, jump-to-Pascal

bits 32

;; Multiboot-related constants, etc.
MBALIGN equ 1 << 0
MEMINFO equ 1 << 1
MBFLAGS equ MBALIGN | MEMINFO
MBMAGIC equ 0x1BADB002
MBCHECKSUM equ -(MBMAGIC + MBFLAGS)

;; Default kernel stack size
KERNELSTACKSIZE equ 0x4000


;; Kernel stack region
section .bss
align 16 
KERNELSTACK:
        resb KERNELSTACKSIZE
 
section .text

;; Multiboot header
align 4
dd MBMAGIC
dd MBFLAGS
dd MBCHECKSUM

;; ISR shenanigans

;; Macro for ISR handlers with no error codes
%macro ISRStandard 1
global ISR%1
ISR%1:
	cli
	push byte 0
	push byte %1
	jmp ISRCommon

%endmacro

;; Macro for ISR handlers WITH error codes
%macro ISRSpecial 1
global ISR%1
ISR%1:
	cli
	push byte %1
	jmp ISRCommon

%endmacro

ISRStandard 0 ; Divide by zero
ISRStandard 1 ; Debug
ISRStandard 2 ; Non-maskable interrupt
ISRStandard 3 ; Breakpoint
ISRStandard 4 ; Into detected overflow
ISRStandard 5 ; Out of bounds
ISRStandard 6 ; Invalid opcode
ISRStandard 7 ; No coprocessor
ISRSpecial 8 ; Double fault
ISRStandard 9 ; Coprocessor segment overrun
ISRSpecial 10 ; Bad TSS
ISRSpecial 11 ; Segment not present
ISRSpecial 12 ; Stack fault
ISRSpecial 13 ; General protection fault
ISRSpecial 14 ; Page fault
ISRStandard 15 ; Unknown interrupt
ISRStandard 16 ; Coprocessor fault
ISRStandard 17 ; Alignment check
ISRStandard 18 ; Machine check
ISRStandard 19 ; Reserved
ISRStandard 20 ; Reserved
ISRStandard 21 ; Reserved
ISRStandard 22 ; Reserved
ISRStandard 23 ; Reserved
ISRStandard 24 ; Reserved
ISRStandard 25 ; Reserved
ISRStandard 26 ; Reserved
ISRStandard 27 ; Reserved
ISRStandard 28 ; Reserved
ISRStandard 29 ; Reserved
ISRStandard 30 ; Reserved
ISRStandard 31 ; Reserved

extern ISRKernelCommon
ISRCommon:
	pusha

	push ds
	push es
	push fs
	push gs

	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov eax, esp
	push eax

	mov eax, ISRKernelCommon
	call eax

	pop eax
	pop gs
	pop fs
	pop es
	pop ds

	popa
	add esp,8
	iret

;; Start function
global KernelStart
KernelStart:
        mov esp, KERNELSTACK + KERNELSTACKSIZE

        extern KernelMain
        call KernelMain

        cli
        hlt

extern GDTHandle
global GDTFlush
GDTFlush:
        push eax
        lgdt [GDTHandle]


        mov ax, 0x10
        mov ds, ax
        mov es, ax
        mov fs, ax
        mov gs, ax
        mov ss, ax

        jmp 0x08:.flush

.flush:
        pop eax
        ret
