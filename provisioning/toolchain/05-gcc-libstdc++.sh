fetch http://ftp.gnu.org/gnu/gcc/gcc-4.9.0/gcc-4.9.0.tar.bz2 9709b49ae0e904cbb0a6a1b62853b556

gxx_include_dir=${tools}/$LFS_TGT/include/c++/$(cat gcc/BASE-VER)

mkdir -pv ../gcc-build
cd ../gcc-build

../gcc/libstdc++-v3/configure                   \
    --host=$LFS_TGT                             \
    --prefix=${tools}                           \
    --disable-multilib                          \
    --disable-shared                            \
    --disable-nls                               \
    --disable-libstdcxx-threads                 \
    --disable-libstdcxx-pch                     \
    --with-gxx-include-dir="${gxx_include_dir}"

make

make install
