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

# VENDOR SPECIFIC DOLBY ATMOS TWEAKS
/data/magisk/resetprop dmid 3067269873
/data/magisk/resetprop audio.ds1.metainfo.key 273
/data/magisk/resetprop audio.dolby.ds2.enabled true
/data/magisk/resetprop audio.dolby.ds2.hardbypass true
/data/magisk/resetprop dolby.audio.sink.info speaker
/data/magisk/resetprop dolby.ds.dialogenhancer.state on
/data/magisk/resetprop dolby.ds.graphiceq.state on
/data/magisk/resetprop dolby.ds.intelligenteq.preset ieq_on
/data/magisk/resetprop dolby.ds.intelligenteq.state on
/data/magisk/resetprop dolby.ds.profile.name Music
/data/magisk/resetprop dolby.ds.state on
/data/magisk/resetprop dolby.ds.virt.bluetooth on
/data/magisk/resetprop dolby.ds.virt.hdmi on
/data/magisk/resetprop dolby.ds.virt.headphone_port on
/data/magisk/resetprop dolby.ds.virt.internal_speaker on
/data/magisk/resetprop dolby.ds.virt.miracast on
/data/magisk/resetprop dolby.ds.virt.usb on
/data/magisk/resetprop dolby.ds.volumeleveler.state off
/data/magisk/resetprop dolby.monospeaker false

# Ser SELinux Permissive
setenforce 0

# KEEP DOLBY ATMOS IN MEMORY(temporarily unavailable)
#/data/magisk/resetprop sys.keep_app_2 com.atmos
#PPID=$(pidof com.atmos)
#echo "-17" > /proc/$PPID/oom_adj
#renice -18 $PPID

# SCRIPT BY ahrion@XDA originally
