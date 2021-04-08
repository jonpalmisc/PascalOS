ENTRY(KernelStart)

SECTIONS
{
  . = 1M;

  .text BLOCK(4K) : ALIGN(4K)
  {
    *(.text)
  }

  .data BLOCK(4K) : ALIGN(4K)
  {
    *(.data)
  }

  .bss BLOCK(4K) : ALIGN(4K)
  {
    *(.bss)
  }
}
