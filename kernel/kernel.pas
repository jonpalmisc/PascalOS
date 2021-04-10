// PascalOS
// Copyright (c) 2021 Jon Palmisciano
//
// kernel.pas - Pascal-side kernel core

unit kernel;

interface

uses gdt, idt, isr, vga;

procedure KernelMain; cdecl;

implementation

{ Print a welcome banner to the VGA buffer }
procedure PrintBanner;
begin
  VGAPrintLine('====================================');
  VGAPrintLine(' PascalOS v0.1.0');
  VGAPrintLine(' Copyright (c) 2021 Jon Palmisciano');
  VGAPrintLine('====================================');
  VGAPrintLine('');
end;

procedure KernelMain; cdecl; [public, alias: 'KernelMain'];
begin
  VGAClear;
  PrintBanner;

  VGAPrintLine('[PascalOS/KernelMain] Kernel entrypoint reached.');

  VGAPrint('[PascalOS/KernelMain] Initializing GDT... ');
  GDTInit;
  VGAPrintLine('Done.');

  VGAPrint('[PascalOS/KernelMain] Initializing IDT...');
  IDTInit;
  VGAPrintLine('Done.');

  VGAPrint('[PascalOS/KernelMain] IDT created in region at 0x');
  VGAPrintHex(IDTHandle.FBase);
  VGAPrint(' to 0x');
  VGAPrintHex(IDTHandle.FBase + IDTHandle.FLimit);
  VGAPrintLine('.');

  VGAPrint('[PascalOS/KernelMain] Creating core ISRs... ');
  ISRInit;
  VGAPrintLine('Done.');

  asm
    int 3
  end;
end;

end.
