{*
 * PascalOS
 * Copyright (c) 2021 Jon Palmisciano

 * isr.pas - ISR setup and handling
 *}

unit isr;

interface

{ Create IDT entries for the common ISRs }
procedure ISRInit;

implementation

uses idt, vga;

{ Common ISR handler }
procedure ISRKernelCommon; [public, alias: 'ISRKernelCommon'];
begin
  VGAPrintLine('[PascalOS/ISRKernelCommon] Interrupt recieved!');
end;

{ References to the macro-generated ISR handlers in core.asm }
procedure ISR0; external name 'ISR0';
procedure ISR1; external name 'ISR1';
procedure ISR2; external name 'ISR2';
procedure ISR3; external name 'ISR3';
procedure ISR4; external name 'ISR4';
procedure ISR5; external name 'ISR5';
procedure ISR6; external name 'ISR6';
procedure ISR7; external name 'ISR7';
procedure ISR8; external name 'ISR8';
procedure ISR9; external name 'ISR9';
procedure ISR10; external name 'ISR10';
procedure ISR11; external name 'ISR11';
procedure ISR12; external name 'ISR12';
procedure ISR13; external name 'ISR13';
procedure ISR14; external name 'ISR14';
procedure ISR15; external name 'ISR15';
procedure ISR16; external name 'ISR16';
procedure ISR17; external name 'ISR17';
procedure ISR18; external name 'ISR18';
procedure ISR19; external name 'ISR19';
procedure ISR20; external name 'ISR20';
procedure ISR21; external name 'ISR21';
procedure ISR22; external name 'ISR22';
procedure ISR23; external name 'ISR23';
procedure ISR24; external name 'ISR24';
procedure ISR25; external name 'ISR25';
procedure ISR26; external name 'ISR26';
procedure ISR27; external name 'ISR27';
procedure ISR28; external name 'ISR28';
procedure ISR29; external name 'ISR29';
procedure ISR30; external name 'ISR30';
procedure ISR31; external name 'ISR31';

procedure ISRInit;
begin
  IDTSetEntry(0, LongWord(@ISR0), $08, $8E);
  IDTSetEntry(1, LongWord(@ISR1), $08, $8E);
  IDTSetEntry(2, LongWord(@ISR2), $08, $8E);
  IDTSetEntry(3, LongWord(@ISR3), $08, $8E);
  IDTSetEntry(4, LongWord(@ISR4), $08, $8E);
  IDTSetEntry(5, LongWord(@ISR5), $08, $8E);
  IDTSetEntry(6, LongWord(@ISR6), $08, $8E);
  IDTSetEntry(7, LongWord(@ISR7), $08, $8E);
  IDTSetEntry(8, LongWord(@ISR8), $08, $8E);
  IDTSetEntry(9, LongWord(@ISR9), $08, $8E);
  IDTSetEntry(10, LongWord(@ISR10), $08, $8E);
  IDTSetEntry(11, LongWord(@ISR11), $08, $8E);
  IDTSetEntry(12, LongWord(@ISR12), $08, $8E);
  IDTSetEntry(13, LongWord(@ISR13), $08, $8E);
  IDTSetEntry(14, LongWord(@ISR14), $08, $8E);
  IDTSetEntry(15, LongWord(@ISR15), $08, $8E);
  IDTSetEntry(16, LongWord(@ISR16), $08, $8E);
  IDTSetEntry(17, LongWord(@ISR17), $08, $8E);
  IDTSetEntry(18, LongWord(@ISR18), $08, $8E);
  IDTSetEntry(19, LongWord(@ISR19), $08, $8E);
  IDTSetEntry(20, LongWord(@ISR20), $08, $8E);
  IDTSetEntry(21, LongWord(@ISR21), $08, $8E);
  IDTSetEntry(22, LongWord(@ISR22), $08, $8E);
  IDTSetEntry(23, LongWord(@ISR23), $08, $8E);
  IDTSetEntry(24, LongWord(@ISR24), $08, $8E);
  IDTSetEntry(25, LongWord(@ISR25), $08, $8E);
  IDTSetEntry(26, LongWord(@ISR26), $08, $8E);
  IDTSetEntry(27, LongWord(@ISR27), $08, $8E);
  IDTSetEntry(28, LongWord(@ISR28), $08, $8E);
  IDTSetEntry(29, LongWord(@ISR29), $08, $8E);
  IDTSetEntry(30, LongWord(@ISR30), $08, $8E);
  IDTSetEntry(31, LongWord(@ISR31), $08, $8E);
end;

end.
