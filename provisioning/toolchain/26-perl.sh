. ./_setup.sh

fetch http://www.cpan.org/src/5.0/perl-5.18.2.tar.bz2 d549b16ee4e9210988da39193a9389c1

curl http://www.linuxfromscratch.org/patches/lfs/systemd/perl-5.18.2-libc-1.patch | patch -Np1

sh Configure -des -Dprefix=/tools

make

make DESTDIR=perl_tools install.perl

cp -v perl_tools/tools/bin/{perl,pod2man} /tools/bin
cp -R perl_tools/tools/lib/perl5 /tools/lib
