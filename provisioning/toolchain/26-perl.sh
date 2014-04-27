fetch http://www.cpan.org/src/5.0/perl-5.18.2.tar.bz2 d549b16ee4e9210988da39193a9389c1

patch -Np1 <<"EOF"
--- perl-5.16.0-orig/hints/linux.sh	2012-06-04 19:23:04.000000000 +0000
+++ perl-5.16.0/hints/linux.sh	2012-06-04 19:23:56.000000000 +0000
@@ -66,9 +66,9 @@ libswanted="$libswanted gdbm_compat"
 # We don't use __GLIBC__ and  __GLIBC_MINOR__ because they
 # are insufficiently precise to distinguish things like
 # libc-2.0.6 and libc-2.0.7.
-if test -L /lib/libc.so.6; then
+if test -L ${prefix}/lib/libc.so.6; then
     libc=`ls -l /lib/libc.so.6 | awk '{print $NF}'`
-    libc=/lib/$libc
+    libc=${prefix}/lib/$libc
 fi

 # Configure may fail to find lstat() since it's a static/inline
@@ -167,11 +167,11 @@ esac
 # we don't want its libraries. So we try to prefer the system gcc
 # Still, as an escape hatch, allow Configure command line overrides to
 # plibpth to bypass this check.
-if [ -x /usr/bin/gcc ] ; then
-    gcc=/usr/bin/gcc
-else
+#if [ -x /usr/bin/gcc ] ; then
+#    gcc=/usr/bin/gcc
+#else
     gcc=gcc
-fi
+#fi

 case "$plibpth" in
 '') plibpth=`LANG=C LC_ALL=C $gcc -print-search-dirs | grep libraries |
@@ -466,3 +466,8 @@ case "$libdb_needs_pthread" in
     libswanted="$libswanted pthread"
     ;;
 esac
+
+locincpth=""
+loclibpth=""
+glibpth="${prefix}/lib"
+usrinc="${prefix}/include"

EOF

cat hints/linux.sh

sh Configure -des -Dprefix=${tools}

make

make DESTDIR=perl_tools install.perl

cp -v perl_tools${tools}/bin/{perl,pod2man} ${tools}/bin
cp -R perl_tools${tools}/lib/perl5 ${tools}/lib
