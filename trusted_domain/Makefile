TOOLPREFIX = riscv64-linux-gnu-
CC = $(TOOLPREFIX)gcc
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump

all: trusted_domain

.PHONY: all clean

startup.o: startup.s
	$(CC) -x assembler-with-cpp -c startup.s -o startup.o -g

trusted_domain: startup.o link.lds
	$(CC) -T./link.lds -Wl,-Map=lowlevel_fw.map -Wl,--gc-sections startup.o -o trusted_domain.elf -nostartfiles
	$(OBJCOPY) -O binary -S trusted_domain.elf trusted_domain.bin
	$(OBJDUMP) --source --demangle --disassemble --reloc --wide trusted_domain.elf > trusted_domain.lst

clean:
	rm -f startup.o lowlevel_fw.map trusted_domain.elf trusted_domain.lst trusted_domain.bin