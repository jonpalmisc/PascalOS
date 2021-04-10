{*
 * PascalOS
 * Copyright (c) 2021 Jon Palmisciano
 *
 * gdt.pas - GDT setup interface
 *}

unit gdt;

interface

type

  { An entry in the GDT }
  TGDTEntry = packed record
    FLowLimit: Word;
    FLowBase: Word;
    FMiddleBase: Byte;
    FAccess: Byte;
    FGranularity: Byte;
    FHighBase: Byte;
  end;

  { The GDT memory region }
  TGDTRegion = packed record
    FLimit: Word;
    FBase: LongWord;
  end;

var

  { Global array for GDT entries/content }
  Entries: array [0..2] of TGDTEntry;

  { Global GDT region variable }
  Region: TGDTRegion; export name 'GDTRegion';

{ Configure a single GDT entry at index I }
procedure SetEntry(I: Byte; Base, Limit: LongWord; Access, Granularity: Byte);

{ Initialize the GDT }
procedure Init;

implementation

procedure Flush; external name 'GDTFlush';

procedure SetEntry(I: Byte; Base, Limit: LongWord; Access, Granularity: Byte);
begin
  with Entries[I] do begin
    FLowBase := (Base and $FFFF);
    FMiddleBase := (Base shr 16) and $FF;
    FHighBase := (Base shr 24) and $FF;
    FLowLimit := (Limit and $FFFF);
    FGranularity := ((Limit shr 16) and $F) or (Granularity and $F0);
    FAccess := Access;
  end;
end;

procedure Init;
begin
  with Region do begin
    FLimit := SizeOf(Entries) - 1;
    FBase := LongWord(@Entries);
  end;

  { Create null segment }
  SetEntry(0, 0, 0, 0, 0);

  { Create kernel code segment }
  SetEntry(1, 0, $FFFFFFFF, $9A, $CF);

  { Create kernel data segment }
  SetEntry(2, 0, $FFFFFFFF, $92, $CF);

  Flush;
end;

end.
