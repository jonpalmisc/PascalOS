{*
 * PascalOS
 * Copyright (c) 2021 Jon Palmisciano
 *
 * vga.pas - VGA buffer display & manipulation
 *}

unit vga;

interface

{ Clear the VGA Buffer (fill with space characters) }
procedure VGAClear;

{ Write a string to the VGA buffer }
procedure VGAPrint(Message: PChar);

{ Write a number to the VGA buffer in hexadecimal }
procedure VGAPrintHex(N: Integer);

{ Write a string to the VGA buffer and jump to the next line }
procedure VGAPrintLine(Message: PChar);

implementation

var
  CursorX: Integer = 0;
  CursorY: Integer = 0;
  VGABuffer: PChar = PChar($B8000);

const
  HexCharMap: array[0..15] of char = '0123456789ABCDEF';

procedure VGAClear;
var
  i: Integer;
begin
  for i := 0 to 3999 do VGABuffer[i] := #0;
end;

procedure VGAPrint(Message: PChar);
var
  Offset, I: Integer;
begin
  Offset := (CursorX shl 1) + (CursorY * 160);
  I := 0;

  { Wrap lines }
  if (CursorY > 24) then CursorY := 0;

  { Wrap columns }
  if (CursorX > 79) then CursorX := 0;

  while (Message[I] <> Char($0)) do begin

    { Write the next character to the VGA buffer }
    VGABuffer[Offset] := message[I];
    Offset += 1;

    { Write the foreground/background color to the VGA buffer }
    VGABuffer[Offset] := #7;
    Offset += 1;

    I += 1;
  end;

  { Update the cursor position }
  CursorX := (Offset mod 160);
  CursorY := (Offset - CursorX) div 160;
  CursorX := CursorX shr 1;
end;

procedure VGAPrintHex(N: Integer);
var
  HexString: array[0..8] of Char;
  PHexString: PChar;
  I: Integer;
begin
  for I := 0 to 7 do begin
    HexString[7 - i] := HexCharMap[N and 15];
    N := N shr 4;
  end;

  PHexString := @HexString;
  VGAPrint(PHexString);
end;

procedure VGAPrintLine(Message: PChar);
begin
  VGAPrint(Message);
  CursorY += 1;
  CursorX := 0;
end;

end.
