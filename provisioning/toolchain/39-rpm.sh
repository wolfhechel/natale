fetch http://rpm.org/releases/rpm-4.11.x/rpm-4.11.2.tar.bz2 876ac9948a88367054f8ddb5c0e87173

fetch http://download.oracle.com/berkeley-db/db-5.3.21.tar.gz ad28eb86ad3203b5422844db179c585b dl-only

PKG_CONFIG_PATH='/tools/lib/pkgconfig'                    \
CPPFLAGS="-I${tools}/include/nspr -I${tools}/include/nss" \
./configure --prefix=/tools                               \
            --disable-static                              \
            --without-lua

make

make install

sed -e '/\%optflags/s/-O2 -g -march=i686/-O2 -march=i486 -mtune=i686 -pipe/' \
    -e '/\%_localstatedir/s/%{_prefix}//'                                    \
    -e '/\%_sharedstatedir/s/%{_prefix}\/com/\/var\/lib/'                    \
    -e '/\%_sysconfdir/s/%{_prefix}//'                                       \
    -i ${tools}/lib/rpm/platform/i686-linux/macros

sed -e '/\%_var/s/%{_prefix}//'	\
    -e 's|\${prefix}||'		      \
    -e 's|%{getenv:HOME}||'	    \
    -i ${tools}/lib/rpm/macros
