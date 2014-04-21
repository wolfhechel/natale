. ./_setup.sh

fetch https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.1.tar.xz 88d46ae23ca599ac5af9cf96b531590f

./configure --prefix=/tools                \
            --disable-makeinstall-chown    \
            --without-systemdsystemunitdir \
            PKG_CONFIG=""

make

make install
