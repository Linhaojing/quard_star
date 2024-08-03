#! /bin/sh

cwd=$(pwd)

${cwd}/output/qemu/bin/qemu-system-riscv64 \
-M quard-star \
-m 1G \
-smp 8 \
-drive if=pflash,bus=0,unit=0,format=raw,file=${cwd}/output/boot.bin \
--parallel none \
-nographic \
# -S -s

# -nographic
