# PascalOS

In an attempt to learn how to write an operating system and to relive the
nostalgia of tinkering with Delphi as a kid, I have decided to begin writing an
operating system in Object Pascal. This is simply a toy project to work on when
I am bored.

## Build instructions

**WARNING**: The current Makefile makes some pretty strong assumptions about
your build environment and is NOT portable. I am developing PascalOS inside a
32-bit Debian 10 virtual machine because I am too lazy to set up proper cross
compilation. To set up a development environment on Debian, run the following
command to install all necessary packages (I might be forgetting some):

```sh
sudo apt install build-essential fpc git qemu-system-i386
```

If for some reason you still want to build this, you can like so:

```sh
git clone https://github.com/jonpalmisc/PascalOS.git
cd PascalOS
make iso
```

## Running the OS

To run the OS after building the ISO, use the included run targets:

```sh
make runb # to run with Bochs; or
make runq # to run with QEMU
```

## License

This project is licensed under the Mozilla Public License v2. For more
information, see the LICENSE.txt file.
