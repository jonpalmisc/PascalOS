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
    LowBase: Word;
    Selector: Word;
    AlwaysZero: Byte;
    Options: Byte;
    HighBase: Word;
  end;

  { A handle to the IDT as a whole }
  TIDTRegion = packed record
    Limit: Word;
    Base: LongWord;
  end;

  TInterruptState = record
    GS, FS, ES, DS: LongWord;
    EDI, ESI, EBP, ESP, EBX, EDX, ECX, EAX: LongWord;
    Interrupt, ErrorCode: LongWord;
    EIP, CS, EFLAGS, UserESP, SS: LongWord;
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
    Limit := SizeOf(Entries) - 1;
    Base := LongWord(@Entries);
  end;

  { TODO: Should probably zero out the IDT region first }

  Load;
end;

procedure SetEntry(I: Byte; Base: LongWord; Selector: Word; Options: Byte);
begin
  Entries[I].LowBase := Base and $FFFF;
  Entries[I].HighBase := (Base shr 16) and $FFFF;
  Entries[I].Selector := Selector;
  Entries[I].AlwaysZero := 0;
  Entries[I].Options := Options;
end;

end.
