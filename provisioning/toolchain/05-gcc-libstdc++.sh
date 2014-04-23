fetch http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2 a3d7d63b9cb6b6ea049469a0c4a43c9d

gxx_include_dir=/tools/$LFS_TGT/include/c++/$(cat gcc/BASE-VER)

mkdir -pv ../gcc-build
cd ../gcc-build

../gcc/libstdc++-v3/configure                   \
    --host=$LFS_TGT                             \
    --prefix=/tools                             \
    --disable-multilib                          \
    --disable-shared                            \
    --disable-nls                               \
    --disable-libstdcxx-threads                 \
    --disable-libstdcxx-pch                     \
    --with-gxx-include-dir="${gxx_include_dir}"

make

make install
