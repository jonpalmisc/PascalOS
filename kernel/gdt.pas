// PascalOS
// Copyright (c) 2021 Jon Palmisciano
//
// gdt.pas - GDT setup interface

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

  { A handle/pointer to the GDT }
  TGDTHandle = packed record
    FLimit: Word;
    FBase: LongWord;
  end;

var

  { Global variable for GDT entries/content }
  GDTEntries: array [0..2] of TGDTEntry;

  { Global handle/pointer to the GDT itself }
  GDTHandle: TGDTHandle; export name 'GDTHandle';

{ Configure a single GDT entry at index I }
procedure GDTSetGate(I: Byte; Base, Limit: LongWord; Access, Granularity: Byte);

{ Initialize the GDT }
procedure GDTInit;

implementation

procedure GDTFlush; external name 'GDTFlush';

procedure GDTSetGate(I: Byte; Base, Limit: LongWord; Access, Granularity: Byte);
begin
  with GDTEntries[I] do
  begin
    FLowBase := (Base and $FFFF);
    FMiddleBase := (Base shr 16) and $FF;
    FHighBase := (Base shr 24) and $FF;
    FLowLimit := (Limit and $FFFF);
    FGranularity := ((Limit shr 16) and $F) or (Granularity and $F0);
    FAccess := Access;
  end;
end;

procedure GDTInit;
begin
  with GDTHandle do
  begin
    FLimit := SizeOf(GDTEntries) - 1;
    FBase := LongWord(@GDTEntries);
  end;

  GDTSetGate(0, 0, 0, 0, 0);              { Create null segment }
  GDTSetGate(1, 0, $FFFFFFFF, $9A, $CF);  { Create kernel code segment }
  GDTSetGate(2, 0, $FFFFFFFF, $92, $CF);  { Create kernel data segment }

  GDTFlush;
end;

end.
