#! /bin/sh

cwd=$(pwd)

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
cp boot.bin ${cwd}/output/lowlevelboot
cd -
