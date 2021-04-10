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
  TIDTRegion = packed record
    FLimit: Word;
    FBase: LongWord;
  end;

var
  Entries: array [0..255] of TIDTEntry;
  Region: TIDTRegion;

{ Initialize the IDT }
procedure Init;

{ Configure an IDT entry }
procedure SetEntry(I: Byte; Base: LongWord; Selector: Word; Options: Byte);

implementation

uses vga;

procedure Load; assembler; nostackframe;
asm
  lidt [Region]
end;

procedure Init;
var
  I: Integer;
begin
  with Region do begin
    FLimit := SizeOf(Entries) - 1;
    FBase := LongWord(@Entries);
  end;

  { TODO: Should probably zero out the IDT region first }

  Load;
end;

procedure SetEntry(I: Byte; Base: LongWord; Selector: Word; Options: Byte);
begin
  with Entries[I] do begin
    FLowBase := Base and $FFFF;
    FHighBase := (Base shr 16) and $FFFF;
    FSelector := Selector;
    FAlwaysZero := 0;
    FOptions := Options;
  end;
end;

end.
