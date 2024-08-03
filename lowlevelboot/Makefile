TOOLPREFIX = riscv64-linux-gnu-
CC = $(TOOLPREFIX)gcc
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump

all: lowlevelboot

.PHONY: all clean

startup.o: startup.S
	$(CC) -x assembler-with-cpp -c startup.S -o startup.o -g

lowlevelboot: startup.o boot.lds
	$(CC) -T./boot.lds -Wl,-Map=lowlevel_fw.map -Wl,--gc-sections startup.o -o lowlevel_boot.elf -nostartfiles
	$(OBJCOPY) -O binary -S lowlevel_boot.elf lowlevel_boot.bin
	$(OBJDUMP) --source --demangle --disassemble --reloc --wide lowlevel_boot.elf > lowlevel_boot.lst

clean:
	rm -f startup.o lowlevel_fw.map lowlevel_boot.elf lowlevel_boot.lst lowlevel_boot.bin boot.bin