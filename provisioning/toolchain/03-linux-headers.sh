fetch https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.2.tar.xz 28b68cde77997ddafab3c4e16cefae7d

make mrproper

make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* ${tools}/include
