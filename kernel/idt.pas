// PascalOS
// Copyright (c) 2021 Jon Palmisciano
//
// idt.pas - IDT configuration, etc.

unit idt;

interface

type

  { A single IDT entry }
  TIDTEntry = packed record
    FLowBase: Word;
    FSelector: Word;
    FAlwaysZero: Byte;
    FOptions: Byte;
    FHighBase: Word;
  end;

  { A handle to the IDT as a whole }
  TIDTHandle = packed record
    FLimit: Word;
    FBase: LongWord;
  end;

var
  IDTEntries: array [0..255] of TIDTEntry;
  IDTHandle: TIDTHandle;

{ Initialize the IDT }
procedure IDTInit;

implementation

uses vga;

procedure IDTLoad; assembler; nostackframe;
asm
  lidt [IDTHandle]
end;

procedure IDTInit;
var
  I: Integer;
begin
  with IDTHandle do
  begin
    FLimit := SizeOf(IDTEntries) - 1;
    FBase := LongWord(@IDTEntries);
  end;

  { TODO: Should zero out the IDT region first }

  IDTLoad;

  VGAPrint('[PascalOS/IDTInit] IDT initialized at 0x');
  VGAPrintHex(IDTHandle.FBase);
  VGAPrint(' to 0x');
  VGAPrintHex(IDTHandle.FBase + IDTHandle.FLimit);
  VGAPrintLine('.');
end;

end.
