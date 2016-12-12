#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}
LOGFILE=/cache/magisk.log
buildname="custom_build.prop"
RESETPROP=""$RESETPROP""
MODNAME="ViPERAtmos"

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
  
  # VENDOR SPECIFIC DOLBY ATMOS TWEAKS
  "$RESETPROP" dmid 3067269873
  "$RESETPROP" audio.ds1.metainfo.key 273
  "$RESETPROP" audio.dolby.ds2.enabled true
  "$RESETPROP" audio.dolby.ds2.hardbypass true
  "$RESETPROP" dolby.audio.sink.info speaker
  "$RESETPROP" dolby.ds.dialogenhancer.state on
  "$RESETPROP" dolby.ds.graphiceq.state on
  "$RESETPROP" dolby.ds.intelligenteq.preset ieq_on
  "$RESETPROP" dolby.ds.intelligenteq.state on
  "$RESETPROP" dolby.ds.profile.name Music
  "$RESETPROP" dolby.ds.state on
  "$RESETPROP" dolby.ds.virt.bluetooth on
  "$RESETPROP" dolby.ds.virt.hdmi on
  "$RESETPROP" dolby.ds.virt.headphone_port on
  "$RESETPROP" dolby.ds.virt.internal_speaker on
  "$RESETPROP" dolby.ds.virt.miracast on
  "$RESETPROP" dolby.ds.virt.usb on
  "$RESETPROP" dolby.ds.volumeleveler.state off
  "$RESETPROP" dolby.monospeaker false

fi

log_print "Resetprop done."

# Set SELinux Permissive
log_print "Set SELinux Permissive"
setenforce 0

# KEEP DOLBY ATMOS IN MEMORY(temporarily unavailable)
#"$RESETPROP" sys.keep_app_2 com.atmos
#PPID=$(pidof com.atmos)
#echo "-17" > /proc/$PPID/oom_adj
#renice -18 $PPID

# SCRIPT BY ahrion@XDA originally
