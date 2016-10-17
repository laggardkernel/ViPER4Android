#!/system/bin/sh

# This script will be executed in post_fs_data mode
# More info in the main Magisk thread

/data/magisk/sepolicy-inject --live -s mediaserver -t mediaserver_tmpfs -c file -p read,write,execute
/data/magisk/sepolicy-inject --live -s audioserver -t audioserver_tmpfs -c file -p read,write,execute

#setprop ro.audio.samplerate 48000
#setprop ro.audio.pcm.samplerate 48000
setprop audio.deep_buffer.media false
#setprop lpa.decode false
#setprop tunnel.decode false
#setprop tunnel.audiovideo.decode false
#setprop lpa.releaselock false
#setprop lpa.use-stagefright false
setprop persist.sys.media.use-awesome 1