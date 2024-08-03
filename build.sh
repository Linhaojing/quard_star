#! /bin/sh

cwd=$(pwd)
CROSS_PREFIX=riscv64-linux-gnu-

cd qemu/build

if [ ! -d "${cwd}/output/qemu" ]; then
	../configure --prefix=${cwd}/output/qemu --target-list=riscv64-softmmu --enable-gtk  --enable-virtfs --disable-gio
fi

make -j 64
make install

cd -

cd ${cwd}/lowlevelboot
make clean
make
mkdir -p ${cwd}/output/lowlevelboot
rm -rf ${cwd}/output/lowlevelboot/*
cp lowlevel_boot.bin ${cwd}/output/lowlevelboot
cd -


mkdir -p ${cwd}/output/opensbi
rm -rf ${cwd}/output/opensbi/*
cd ${cwd}/opensbi
make CROSS_COMPILE=$CROSS_PREFIX PLATFORM=quard_star
cp -r ${cwd}/opensbi/build/platform/quard_star/firmware/*.bin ${cwd}/output/opensbi/
cd -

dtc -I dts -O dtb -o ${cwd}/output/opensbi/quard_star_sbi.dtb ${cwd}/dts/quard_star_sbi.dts

cd ${cwd}/output
rm -rf boot.bin
dd of=boot.bin bs=1k count=32k if=/dev/zero
dd of=boot.bin bs=1k conv=notrunc seek=0 if=lowlevelboot/lowlevel_boot.bin
dd of=boot.bin bs=1k conv=notrunc seek=512 if=opensbi/quard_star_sbi.dtb
dd of=boot.bin bs=1k conv=notrunc seek=2k if=opensbi/fw_jump.bin
cd -
