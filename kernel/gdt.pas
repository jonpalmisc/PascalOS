unit gdt;

interface

type
  TGDTEntry = packed record
    FLowLimit: Word;
    FLowBase: Word;
    FMiddleBase: Byte;
    FAccess: Byte;
    FGranularity: Byte;
    FHighBase: Byte;
  end;

  TGDTHandle = packed record
    FLimit: Word;
    FBase: LongWord;
  end;

var
  GDTEntries: array [0..4] of TGDTEntry;
  GDTHandle: TGDTHandle; export name 'GDTHandle';

procedure GDTSetGate(Index: Byte; Base, Limit: LongWord; Access, Granularity: Byte);
procedure GDTInit;

implementation

procedure GDTFlush; external name 'GDTFlush';

procedure GDTSetGate(Index: Byte; Base, Limit: LongWord; Access, Granularity: Byte);
begin
  with GDTEntries[Index] do
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

  GDTSetGate(0, 0, 0, 0, 0);
  GDTSetGate(1, 0, $FFFFFFFF, $9A, $CF);
  GDTSetGate(2, 0, $FFFFFFFF, $92, $CF);
  GDTSetGate(3, 0, $FFFFFFFF, $FA, $CF);
  GDTSetGate(4, 0, $FFFFFFFF, $F2, $CF);

  GDTFlush;
end;

end.
