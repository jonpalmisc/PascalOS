{*
 * PascalOS
 * Copyright (c) 2021 Jon Palmisciano

 * irq.pas - Interrupt request (IRQ) setup and handling
 *}

unit irq;

interface

{ Create IDT entries for IRQ handlers }
procedure RegisterHandlers;

implementation

uses idt, port, vga;

{ Common IRQ handler }
procedure HandleCommon(var State: TInterruptState); cdecl; [public, alias: 'IRQHandleCommon'];
begin
  VGA.Print('[IRQ.HandleCommon] Interrupt request 0x');
  VGA.PrintHex(State.Interrupt);
  VGA.PrintLine(' received!');
end;

{ References to the macro-generated IRQ handlers in core.asm }
procedure Handle0; external name 'IRQ0';
procedure Handle1; external name 'IRQ1';
procedure Handle2; external name 'IRQ2';
procedure Handle3; external name 'IRQ3';
procedure Handle4; external name 'IRQ4';
procedure Handle5; external name 'IRQ5';
procedure Handle6; external name 'IRQ6';
procedure Handle7; external name 'IRQ7';
procedure Handle8; external name 'IRQ8';
procedure Handle9; external name 'IRQ9';
procedure Handle10; external name 'IRQ10';
procedure Handle11; external name 'IRQ11';
procedure Handle12; external name 'IRQ12';
procedure Handle13; external name 'IRQ13';
procedure Handle14; external name 'IRQ14';
procedure Handle15; external name 'IRQ15';

{ Tell the PIC to remap IRQs 0-15 to IDT entries 32-47 }
procedure Remap;
begin
  Port.Write($20, $11);
  Port.Write($A0, $11);
  Port.Write($21, $20);
  Port.Write($A1, $28);
  Port.Write($21, $04);
  Port.Write($A1, $02);
  Port.Write($21, $01);
  Port.Write($A1, $01);
  Port.Write($21, $0);
  Port.Write($A1, $0);
end;

procedure RegisterHandlers;
begin
  IDT.SetEntry(32, LongWord(@Handle0), $08, $8E);
  IDT.SetEntry(33, LongWord(@Handle1), $08, $8E);
  IDT.SetEntry(34, LongWord(@Handle2), $08, $8E);
  IDT.SetEntry(35, LongWord(@Handle3), $08, $8E);
  IDT.SetEntry(36, LongWord(@Handle4), $08, $8E);
  IDT.SetEntry(37, LongWord(@Handle5), $08, $8E);
  IDT.SetEntry(38, LongWord(@Handle6), $08, $8E);
  IDT.SetEntry(39, LongWord(@Handle7), $08, $8E);
  IDT.SetEntry(40, LongWord(@Handle8), $08, $8E);
  IDT.SetEntry(41, LongWord(@Handle9), $08, $8E);
  IDT.SetEntry(42, LongWord(@Handle10), $08, $8E);
  IDT.SetEntry(43, LongWord(@Handle11), $08, $8E);
  IDT.SetEntry(44, LongWord(@Handle12), $08, $8E);
  IDT.SetEntry(45, LongWord(@Handle13), $08, $8E);
  IDT.SetEntry(46, LongWord(@Handle14), $08, $8E);
  IDT.SetEntry(47, LongWord(@Handle15), $08, $8E);

  asm
    sti
  end;
end;

end.
