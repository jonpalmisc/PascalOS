# Build directories
OUTDIR=out
BOOTDIR=$(OUTDIR)/boot
GRUBDIR=$(BOOTDIR)/grub
CFGFILE=$(GRUBDIR)/grub.cfg


# Assembly core source & object
CSRC=kernel/core.asm
COBJ=$(OUTDIR)/core.o

# Kernel source
KSRC=kernel/kernel.pas
KOBJ:=$(patsubst kernel/%.pas, $(OUTDIR)/%.o, $(wildcard kernel/*.pas))

# Image/link source
ISRC=image/image.ld
IOBJ=$(OUTDIR)/image.o

# ISO output file
ISOF=pascalos.iso

# Pascal compiler and compiler flags
PP=fpc
PPFLAGS=-Aelf -n -O3 -Op3 -Si -Sc -Sg -Xd -CX -XXs -Pi386 -Rintel -Tlinux -o"$(OUTDIR)/"

# Assembler and assembler flags
AS=nasm
ASFLAGS=-f elf32

# Linker and linker flags
LD=ld
LDFLAGS=-A elf-i386 --gc-sections -s

# QEMU and Bochs executables
QEMU=qemu-system-i386
BOCHS=bochs

.PHONY: all kernel boot img iso

prep:

	mkdir -p $(OUTDIR)
	mkdir -p $(BOOTDIR)
	mkdir -p $(GRUBDIR)

kernel: prep $(KSRC)

	$(AS) $(ASFLAGS) -o $(COBJ) $(CSRC)
	$(PP) $(PPFLAGS) $(KSRC)

img:	boot kernel $(ISRC)

	$(LD) $(LDFLAGS) -T$(ISRC) -o $(IOBJ) $(KOBJ) $(COBJ)

iso:	img

	cp $(IOBJ) $(BOOTDIR)/image.o

	@echo 'set timeout=0' > $(CFGFILE)
	@echo 'set default =0' >> $(CFGFILE)
	@echo '' >> $(CFGFILE)
	@echo 'menuentry "PascalOS" {' >> $(CFGFILE)
	@echo '  multiboot /boot/image.o' >> $(CFGFILE)
	@echo '  boot' >> $(CFGFILE)
	@echo '}' >> $(CFGFILE)

	grub-mkrescue --output=$(OUTDIR)/$(ISOF) $(OUTDIR)

runq:	iso

	$(QEMU) $(OUTDIR)/$(ISOF)

runb:	iso

	$(BOCHS) -f bochsrc.txt -q

clean:

	rm -rf $(OUTDIR)
	rm -f *.o
	rm -f *.ppu

