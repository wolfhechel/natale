strip --strip-debug /tools/lib/*
/usr/bin/strip --strip-unneeded /tools/{,s}bin/*

rm -rf /tools/{,share}/{info,man,doc}

find /tools/lib/perl5 -type d -iname pod -exec rm -r {} \;
find /tools/lib/perl5 -type f -iname \*.pod -delete
