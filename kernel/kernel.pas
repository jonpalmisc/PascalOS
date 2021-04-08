unit kernel;

interface

uses vga;

procedure KernelMain; cdecl;

implementation

procedure KernelMain; cdecl; [public, alias: 'KernelMain'];
begin
  VGAClear;
  VGAPrint('Welcome to PascalOS!');
end;

end.
