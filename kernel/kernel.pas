{*
 * PascalOS
 * Copyright (c) 2021 Jon Palmisciano
 *
 * kernel.pas - Pascal-side kernel core
 *}

unit kernel;

interface

uses gdt, idt, isr, irq, vga;

procedure Main;

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

procedure Main; [public, alias: 'KernelMain'];
begin
  VGA.Clear;
  PrintBanner;

  VGA.PrintLine('[Kernel.Main] Kernel entrypoint reached.');

  VGA.Print('[Kernel.Main] Initializing GDT... ');
  GDT.Init;
  VGA.PrintLine('Done.');

  VGA.Print('[Kernel.Main] Initializing IDT...');
  IDT.Init;
  VGA.PrintLine('Done.');

  VGA.Print('[Kernel.Main] IDT region created at 0x');
  VGA.PrintHex(IDT.Region.Base);
  VGA.Print(' to 0x');
  VGA.PrintHex(IDT.Region.Base + IDT.Region.Limit);
  VGA.PrintLine('.');

  VGA.Print('[Kernel.Main] Creating core ISR handlers... ');
  ISR.RegisterHandlers;
  VGA.PrintLine('Done.');

  VGA.Print('[Kernel.Main] Creating core IRQ handlers... ');
  IRQ.RegisterHandlers;
  VGA.PrintLine('Done.');

  asm
    int 3
    int 47
  end;
end;

end.
