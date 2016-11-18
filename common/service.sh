#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in late_start service mode
# More info in the main Magisk thread

# Set any prop (with trigger)

# LOW POWER AUDIO TWEAKS
/data/magisk/resetprop lpa.decode false
/data/magisk/resetprop lpa.releaselock false
/data/magisk/resetprop lpa.use-stagefright false
/data/magisk/resetprop tunnel.decode false

# OTHER AUDIO TWEAKS
/data/magisk/resetprop audio.deep_buffer.media false
/data/magisk/resetprop tunnel.audiovideo.decode false
/data/magisk/resetprop persist.sys.media.use-awesome 1
/data/magisk/resetprop ro.audio.samplerate 48000
/data/magisk/resetprop ro.audio.pcm.samplerate 48000
