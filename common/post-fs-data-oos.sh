#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in post-fs-data mode
# More info in the main Magisk thread

/data/magisk/sepolicy-inject --live -s mediaserver -t mediaserver_tmpfs -c file -p read,write,execute
/data/magisk/sepolicy-inject --live -s audioserver -t audioserver_tmpfs -c file -p read,write,execute

# Set any prop (with trigger)
#/data/magisk/resetprop ro.audio.samplerate 48000
#/data/magisk/resetprop ro.audio.pcm.samplerate 48000
/data/magisk/resetprop audio.deep_buffer.media false
#/data/magisk/resetprop lpa.decode false
#/data/magisk/resetprop tunnel.decode false
#/data/magisk/resetprop tunnel.audiovideo.decode false
#/data/magisk/resetprop lpa.releaselock false
#/data/magisk/resetprop lpa.use-stagefright false
/data/magisk/resetprop persist.sys.media.use-awesome 1
