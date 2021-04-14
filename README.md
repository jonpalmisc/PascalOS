# PascalOS

In an attempt to learn how to write an operating system and to relive the
nostalgia of tinkering with Delphi as a kid, I have decided to begin writing an
operating system in Object Pascal. This is simply a toy project to work on when
I am bored.

## Progress and features

Despite having "OS" in the name, PascalOS is far from an operating system
right now. Here's a summary of what is and isn't currently implemented:

- [x] Boot to kernel entrypoint
- [x] Basic GDT setup
- [x] Bare-minimum IDT setup and ISR handling
- [x] Bare-minimum IRQ handling
- [ ] Keyboard support
- [ ] Virtual memeory (paging)
- [ ] Dynamic memory allocation
- [ ] Filesystem support
- [ ] Multitasking
- [ ] User mode
- [ ] Everything else

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

## Acknowledgements

This project would not have been possible without the following resources:

- The [OSDev Wiki](https://wiki.osdev.org/Expanded_Main_Page)
- [James Molloy's Kernel Development Tutorials](http://www.jamesmolloy.co.uk/tutorial_html/)
- [Bran's Kernel Development Tutorials](http://www.osdever.net/bkerndev/index.php)

## License

This project is licensed under the Mozilla Public License v2. For more
information, see the LICENSE.txt file.
