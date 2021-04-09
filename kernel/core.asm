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
