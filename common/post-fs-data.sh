#!/system/bin/sh

/data/magisk/sepolicy-inject --live -s mediaserver -t mediaserver_tmpfs -c file -p read,write,execute
/data/magisk/sepolicy-inject --live -s audioserver -t audioserver_tmpfs -c file -p read,write,execute
