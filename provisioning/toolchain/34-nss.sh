fetch http://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/NSS_3_16_RTM/src/nss-3.16-with-nspr-4.10.4.tar.gz 324e5b83e4b44ca612aec1d960625b21

make USE_64=1 BUILD_OPT=1 nss_build_all

cd ../dist

install -v -m755 Linux*/lib/*.so ${tools}/lib
install -v -m644 Linux*/lib/{*.chk,libcrmf.a} ${tools}/lib

cp -v -RL Linux*/include ${tools}/include/nspr
cp -v -RL public/nss ${tools}/include/nss
cp -v -RL private/nss ${tools}/include/nss/private

install -v -m755 Linux*/bin/{certutil,pk12util} ${tools}/bin
