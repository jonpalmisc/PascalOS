{*
 * PascalOS
 * Copyright (c) 2021 Jon Palmisciano
 *
 * idt.pas - IDT configuration, etc.
 *}

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

{ Configure an IDT entry }
procedure IDTSetEntry(I: Byte; Base: LongWord; Selector: Word; Options: Byte);

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
  with IDTHandle do begin
    FLimit := SizeOf(IDTEntries) - 1;
    FBase := LongWord(@IDTEntries);
  end;

  { TODO: Should probably zero out the IDT region first }

  IDTLoad;
end;

procedure IDTSetEntry(I: Byte; Base: LongWord; Selector: Word; Options: Byte);
begin
  with IDTEntries[I] do begin
    FLowBase := Base and $FFFF;
    FHighBase := (Base shr 16) and $FFFF;
    FSelector := Selector;
    FAlwaysZero := 0;
    FOptions := Options;
  end;
end;

end.
