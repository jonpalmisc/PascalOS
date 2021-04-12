# Build directories
BUILD_DIR=out
GRUB_CONFIG=$(BUILD_DIR)/boot/grub/grub.cfg


# Assembly core source & object
ASM_SOURCE=kernel/core.asm
ASM_OBJECTS=$(BUILD_DIR)/core.o

# Kernel source
PAS_SOURCE=kernel/kernel.pas
PAS_OBJECTS:=$(patsubst kernel/%.pas, $(BUILD_DIR)/%.o, $(wildcard kernel/*.pas))

# Image/link source
LD_SOURCE=image/image.ld
LD_OBJECTS=$(BUILD_DIR)/image.o

# ISO output file
ISO_NAME=pascalos.iso

# Pascal compiler and compiler flags
PP=fpc
PPFLAGS=-Aelf -n -O3 -Op3 -Si -Sc -Sg -Xd -CX -XXs -Pi386 -Rintel -Tlinux -o"$(BUILD_DIR)/"

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

	mkdir -p $(BUILD_DIR)

kernel: prep $(PAS_SOURCE)

	$(AS) $(ASFLAGS) -o $(ASM_OBJECTS) $(ASM_SOURCE)
	$(PP) $(PPFLAGS) $(PAS_SOURCE)

img:	boot kernel $(LD_SOURCE)

	$(LD) $(LDFLAGS) -T$(LD_SOURCE) -o $(LD_OBJECTS) $(PAS_OBJECTS) $(ASM_OBJECTS)

iso:	img

	mkdir -p $(BUILD_DIR)/boot/grub
	cp $(LD_OBJECTS) $(BUILD_DIR)/boot/image.o

	@echo 'set timeout=0' > $(GRUB_CONFIG)
	@echo 'set default =0' >> $(GRUB_CONFIG)
	@echo '' >> $(GRUB_CONFIG)
	@echo 'menuentry "PascalOS" {' >> $(GRUB_CONFIG)
	@echo '  multiboot /boot/image.o' >> $(GRUB_CONFIG)
	@echo '  boot' >> $(GRUB_CONFIG)
	@echo '}' >> $(GRUB_CONFIG)

	grub-mkrescue --output=$(BUILD_DIR)/$(ISO_NAME) $(BUILD_DIR)

runq:	iso

	$(QEMU) $(BUILD_DIR)/$(ISO_NAME)

runb:	iso

	$(BOCHS) -f bochsrc.txt -q

clean:

	rm -rf $(BUILD_DIR)
	rm -f *.o
	rm -f *.ppu

