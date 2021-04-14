{*
 * PascalOS
 * Copyright (c) 2021 Jon Palmisciano

 * port.pas - IO port communication
 *}

unit port;

interface

{ Read a byte from an IO port }
function Read(Port: Word): Byte;

{ Write a byte to an IO port }
procedure Write(Port: Word; Data: Byte);

implementation

function Read(Port: Word): Byte; assembler;
asm
  mov edx, Port
  xor eax, eax
  in al, dx
end;

procedure Write(Port: Word; Data: Byte); assembler;
asm
  mov edx, Port
  mov al, Data
  out dx, al
end;

end.