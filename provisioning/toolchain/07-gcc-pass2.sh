fetch http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2 a3d7d63b9cb6b6ea049469a0c4a43c9d

cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h

case `uname -m` in
  i?86) sed -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in ;;
esac

for file in \
 $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done

fetch http://www.mpfr.org/mpfr-3.1.2/mpfr-3.1.2.tar.xz            e3d203d188b8fe60bb6578dd3152e05c dl-only
fetch http://www.multiprecision.org/mpc/download/mpc-1.0.2.tar.gz 68fadff3358fb3e7976c7a398a0af4c3 dl-only
fetch http://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.xz                1e6da4e434553d2811437aa42c7f7c76 dl-only

mkdir -v ../gcc-build
cd ../gcc-build

CC=$LFS_TGT-gcc                                    \
CXX=$LFS_TGT-g++                                   \
AR=$LFS_TGT-ar                                     \
RANLIB=$LFS_TGT-ranlib                             \
../gcc/configure                                   \
    --prefix=/tools                                \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --enable-clocale=gnu                           \
    --enable-shared                                \
    --enable-threads=posix                         \
    --enable-__cxa_atexit                          \
    --enable-languages=c,c++                       \
    --disable-libstdcxx-pch                        \
    --disable-multilib                             \
    --disable-bootstrap                            \
    --disable-libgomp                              \
    --with-mpfr-include=$(pwd)/../gcc/mpfr/src     \
    --with-mpfr-lib=$(pwd)/mpfr/src/.libs

make

make install

ln -sv gcc /tools/bin/cc
