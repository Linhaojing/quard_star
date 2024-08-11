#! /bin/sh

cwd=$(pwd)
DEFAULT_VC="1280x720"

${cwd}/output/qemu/bin/qemu-system-riscv64 \
-M quard-star \
-m 1G \
-smp 8 \
-drive if=pflash,bus=0,unit=0,format=raw,file=${cwd}/output/boot.bin \
--parallel none \
--serial vc:$DEFAULT_VC --serial vc:$DEFAULT_VC --serial vc:$DEFAULT_VC --monitor vc:$DEFAULT_VC \
# -S -s
# -nographic \


# -nographic
