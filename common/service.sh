#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}
LOGFILE=/cache/magisk.log
buildname="custom_build.prop"
RESETPROP="/data/magisk/resetprop"
MODNAME=${MODDIR#/magisk}

log_print() {
  echo "$MODNAME: $1"
  echo "$MODNAME: $1" >> $LOGFILE
  log -p i -t $MODNAME "$1"
}

# This script will be executed in late_start service mode
# More info in the main Magisk thread

if [ -f "$MODDIR/$buildname" ]; then
  log_print "Setting props through $MODDIR/$buildname"
  "$RESETPROP" --file "$MODDIR/$buildname"
elif [ -f "/magisk/tweakprop/$buildname" ]; then
  log_print "Setting props through /magisk/tweakprop/$buildname"
  "$RESETPROP" --file "/magisk/tweakprop/$buildname"
else
  # Set any prop (with trigger)
  log_print "Setting props through servie.sh"
  # LOW POWER AUDIO TWEAKS
  "$RESETPROP" lpa.decode false
  "$RESETPROP" lpa.releaselock false
  "$RESETPROP" lpa.use-stagefright false
  "$RESETPROP" tunnel.decode false
  
  # OTHER AUDIO TWEAKS
  "$RESETPROP" audio.deep_buffer.media false
  "$RESETPROP" tunnel.audiovideo.decode false
  "$RESETPROP" persist.sys.media.use-awesome 1
  "$RESETPROP" ro.audio.samplerate 48000
  "$RESETPROP" ro.audio.pcm.samplerate 48000

fi

log_print "Resetprop done."
