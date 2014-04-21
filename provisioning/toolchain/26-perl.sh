. ./_setup.sh

fetch http://www.cpan.org/src/5.0/perl-5.18.2.tar.bz2 d549b16ee4e9210988da39193a9389c1


cat >> hints/linux.sh << "EOF"
locincpth=""
loclibpth=""
glibpth="${prefix}/lib"
usrinc="${prefix}/include"
libc="$(cd ${prefix}/lib; echo $PWD/$(readlink libc.so.6))"
gcc=gcc
EOF

sh Configure -des -Dprefix=/tools

make

make DESTDIR=perl_tools install.perl

cp -v perl_tools/tools/bin/{perl,pod2man} /tools/bin
cp -R perl_tools/tools/lib/perl5 /tools/lib
