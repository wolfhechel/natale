fetch https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz b621207b3f6ecbb67db18b13258f8ea8

make mrproper

make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* ${tools}/include
