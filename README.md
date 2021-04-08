# PascalOS

In an attempt to learn how to write an operating system and to relive the
nostalgia of tinkering with Delphi as a kid, I have decided to begin writing an
operating system in Object Pascal. This is simply a toy project to work on when
I am bored.

## Build

**WARNING**: The current Makefile makes some pretty strong assumptions about
your build environment and is NOT portable. I am developing PascalOS inside a
32-bit Debian 10 virtual machine because I am too lazy to set up proper cross
compilation.

If for some reason you want to build this, you can like so:

```sh
git clone https://github.com/jonpalmisc/PascalOS.git
cd PascalOS
make iso
```

## Testing

To run the OS after building the ISO, use the included run target:

```sh
make run
```

## License

This project is licensed under the Mozilla Public License v2. For more
information, see the LICENSE.txt file.
