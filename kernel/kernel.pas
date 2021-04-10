{*
 * PascalOS
 * Copyright (c) 2021 Jon Palmisciano
 *
 * kernel.pas - Pascal-side kernel core
 *}

unit kernel;

interface

uses gdt, idt, isr, vga;

procedure KernelMain; cdecl;

implementation

{ Print a welcome banner to the VGA buffer }
procedure PrintBanner;
begin
  VGA.PrintLine('====================================');
  VGA.PrintLine(' PascalOS v0.1.0');
  VGA.PrintLine(' Copyright (c) 2021 Jon Palmisciano');
  VGA.PrintLine('====================================');
  VGA.PrintLine('');
end;

procedure KernelMain; cdecl; [public, alias: 'KernelMain'];
begin
  VGA.Clear;
  PrintBanner;

  VGA.PrintLine('[PascalOS/KernelMain] Kernel entrypoint reached.');

  VGA.Print('[PascalOS/KernelMain] Initializing GDT... ');
  GDT.Init;
  VGA.PrintLine('Done.');

  VGA.Print('[PascalOS/KernelMain] Initializing IDT...');
  IDTInit;
  VGA.PrintLine('Done.');

  VGA.Print('[PascalOS/KernelMain] IDT created in region at 0x');
  VGA.PrintHex(IDTHandle.FBase);
  VGA.Print(' to 0x');
  VGA.PrintHex(IDTHandle.FBase + IDTHandle.FLimit);
  VGA.PrintLine('.');

  VGA.Print('[PascalOS/KernelMain] Creating core ISRs... ');
  ISRInit;
  VGA.PrintLine('Done.');

  asm
    int 3
  end;
end;

end.
