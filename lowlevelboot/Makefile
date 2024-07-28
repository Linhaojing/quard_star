TOOLPREFIX = riscv64-linux-gnu-
CC = $(TOOLPREFIX)gcc
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump

all: lowlevelboot

.PHONY: all clean

startup.o: startup.S
	$(CC) -c startup.S -o startup.o

lowlevelboot: startup.o boot.lds
	$(CC) -T./boot.lds -Wl,-Map=lowlevel_fw.map -Wl,--gc-sections startup.o -o lowlevel_boot.elf -nostartfiles
	$(OBJCOPY) -O binary -S lowlevel_boot.elf lowlevel_boot.bin
	$(OBJDUMP) --source --demangle --disassemble --reloc --wide lowlevel_boot.elf > lowlevel_boot.lst
	dd if=/dev/zero of=boot.bin bs=1k count=32k
	dd if=lowlevel_boot.bin of=boot.bin bs=1k conv=notrunc seek=0

clean:
	rm -f startup.o lowlevel_fw.map lowlevel_boot.elf lowlevel_boot.lst lowlevel_boot.bin boot.bin