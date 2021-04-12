# Build files & directories
BUILD_DIR=out
GRUB_CONFIG=$(BUILD_DIR)/boot/grub/grub.cfg
ISO_NAME=pascalos.iso


# Assembly boot core
ASM_SOURCE=kernel/core.asm
ASM_OBJECTS=$(BUILD_DIR)/core.o

# The actual kernel
PAS_SOURCE=kernel/kernel.pas
PAS_OBJECTS:=$(patsubst kernel/%.pas, $(BUILD_DIR)/%.o, $(wildcard kernel/*.pas))

# Linker script
LD_SOURCE=image/image.ld
LD_OBJECTS=$(BUILD_DIR)/image.o

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

.PHONY: clean kernel

kernel: $(PAS_SOURCE)

	mkdir -p $(BUILD_DIR)

	$(AS) $(ASFLAGS) -o $(ASM_OBJECTS) $(ASM_SOURCE)
	$(PP) $(PPFLAGS) $(PAS_SOURCE)
	$(LD) $(LDFLAGS) -T$(LD_SOURCE) -o $(LD_OBJECTS) $(PAS_OBJECTS) $(ASM_OBJECTS)

iso:	kernel

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

	@rm -rf $(BUILD_DIR)
	@rm -f *.o
	@rm -f *.ppu

	@echo "Build artifacts removed."
