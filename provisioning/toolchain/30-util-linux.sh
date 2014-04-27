fetch https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.2.tar.xz 3f191727a0d28f7204b755cf1b6ea0aa

./configure --prefix=${tools}              \
            --disable-makeinstall-chown    \
            --without-systemdsystemunitdir \
            PKG_CONFIG=""

make

make install
