fetch http://www.zlib.net/zlib-1.2.8.tar.xz 28f1205d8dd2001f26fec1e8c2cebe37

PKG_CONFIG_PATH="${tools}/lib/pkgconfig" \
./configure --prefix=${tools}

make

make install
