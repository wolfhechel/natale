fetch http://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v4.10.4/src/nspr-4.10.4.tar.gz db8e5c40dadcf3f71a20c01f503c573a

cd nspr

sed -ri 's#^(RELEASE_BINS =).*#\1#' pr/src/misc/Makefile.in
sed -i 's#$(LIBRARY) ##' config/rules.mk

PKG_CONFIG_PATH="${tools}/lib/pkgconfig" \
./configure --prefix=${tools} \
            --disable-static  \
            --with-mozilla    \
            --with-pthreads   \
            --enable-64bit

make

make install
