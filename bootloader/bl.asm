bits 32

MBALIGN equ 1 << 0
MEMINFO equ 1 << 1
MBFLAGS equ MBALIGN | MEMINFO
MBMAGIC equ 0x1BADB002
MBCHECKSUM equ -(MBMAGIC + MBFLAGS)

KERNELSTACKSIZE equ 0x4000


;; Kernel stack
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

;; Start function
global KernelStart
KernelStart:
        mov esp, KERNELSTACK + KERNELSTACKSIZE

	extern KernelMain
        call KernelMain

        cli
        hlt
