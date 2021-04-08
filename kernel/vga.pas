unit vga;

interface

procedure VGAClear;

implementation

var
  VGABuffer: PChar = PChar($B8000);

procedure VGAClear;
var
  i: Integer;
begin
  for i := 0 to 3999 do
    VGABuffer[i] := #0;
end;

end.
