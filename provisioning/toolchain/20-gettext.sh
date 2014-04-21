. ./_setup.sh

fetch http://ftp.gnu.org/gnu/gettext/gettext-0.18.3.2.tar.gz 241aba309d07aa428252c74b40a818ef

cd gettext-tools
EMACS="no" ./configure --prefix=/tools --disable-shared

make -C gnulib-lib
make -C src msgfmt
make -C src msgmerge
make -C src xgettext

cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin
