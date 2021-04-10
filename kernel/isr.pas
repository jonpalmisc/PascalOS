{*
 * PascalOS
 * Copyright (c) 2021 Jon Palmisciano

 * isr.pas - ISR setup and handling
 *}

unit isr;

interface

{ Create IDT entries for the common ISRs }
procedure RegisterHandlers;

implementation

uses idt, vga;

{ Common ISR handler }
procedure KernelCommon; [public, alias: 'ISRKernelCommon'];
begin
  VGA.PrintLine('[PascalOS/ISRKernelCommon] Interrupt recieved!');
end;

{ References to the macro-generated ISR handlers in core.asm }
procedure Handle0; external name 'ISR0';
procedure Handle1; external name 'ISR1';
procedure Handle2; external name 'ISR2';
procedure Handle3; external name 'ISR3';
procedure Handle4; external name 'ISR4';
procedure Handle5; external name 'ISR5';
procedure Handle6; external name 'ISR6';
procedure Handle7; external name 'ISR7';
procedure Handle8; external name 'ISR8';
procedure Handle9; external name 'ISR9';
procedure Handle10; external name 'ISR10';
procedure Handle11; external name 'ISR11';
procedure Handle12; external name 'ISR12';
procedure Handle13; external name 'ISR13';
procedure Handle14; external name 'ISR14';
procedure Handle15; external name 'ISR15';
procedure Handle16; external name 'ISR16';
procedure Handle17; external name 'ISR17';
procedure Handle18; external name 'ISR18';
procedure Handle19; external name 'ISR19';
procedure Handle20; external name 'ISR20';
procedure Handle21; external name 'ISR21';
procedure Handle22; external name 'ISR22';
procedure Handle23; external name 'ISR23';
procedure Handle24; external name 'ISR24';
procedure Handle25; external name 'ISR25';
procedure Handle26; external name 'ISR26';
procedure Handle27; external name 'ISR27';
procedure Handle28; external name 'ISR28';
procedure Handle29; external name 'ISR29';
procedure Handle30; external name 'ISR30';
procedure Handle31; external name 'ISR31';

procedure RegisterHandlers;
begin
  IDT.SetEntry(0, LongWord(@Handle0), $08, $8E);
  IDT.SetEntry(1, LongWord(@Handle1), $08, $8E);
  IDT.SetEntry(2, LongWord(@Handle2), $08, $8E);
  IDT.SetEntry(3, LongWord(@Handle3), $08, $8E);
  IDT.SetEntry(4, LongWord(@Handle4), $08, $8E);
  IDT.SetEntry(5, LongWord(@Handle5), $08, $8E);
  IDT.SetEntry(6, LongWord(@Handle6), $08, $8E);
  IDT.SetEntry(7, LongWord(@Handle7), $08, $8E);
  IDT.SetEntry(8, LongWord(@Handle8), $08, $8E);
  IDT.SetEntry(9, LongWord(@Handle9), $08, $8E);
  IDT.SetEntry(10, LongWord(@Handle10), $08, $8E);
  IDT.SetEntry(11, LongWord(@Handle11), $08, $8E);
  IDT.SetEntry(12, LongWord(@Handle12), $08, $8E);
  IDT.SetEntry(13, LongWord(@Handle13), $08, $8E);
  IDT.SetEntry(14, LongWord(@Handle14), $08, $8E);
  IDT.SetEntry(15, LongWord(@Handle15), $08, $8E);
  IDT.SetEntry(16, LongWord(@Handle16), $08, $8E);
  IDT.SetEntry(17, LongWord(@Handle17), $08, $8E);
  IDT.SetEntry(18, LongWord(@Handle18), $08, $8E);
  IDT.SetEntry(19, LongWord(@Handle19), $08, $8E);
  IDT.SetEntry(20, LongWord(@Handle20), $08, $8E);
  IDT.SetEntry(21, LongWord(@Handle21), $08, $8E);
  IDT.SetEntry(22, LongWord(@Handle22), $08, $8E);
  IDT.SetEntry(23, LongWord(@Handle23), $08, $8E);
  IDT.SetEntry(24, LongWord(@Handle24), $08, $8E);
  IDT.SetEntry(25, LongWord(@Handle25), $08, $8E);
  IDT.SetEntry(26, LongWord(@Handle26), $08, $8E);
  IDT.SetEntry(27, LongWord(@Handle27), $08, $8E);
  IDT.SetEntry(28, LongWord(@Handle28), $08, $8E);
  IDT.SetEntry(29, LongWord(@Handle29), $08, $8E);
  IDT.SetEntry(30, LongWord(@Handle30), $08, $8E);
  IDT.SetEntry(31, LongWord(@Handle31), $08, $8E);
end;

end.
