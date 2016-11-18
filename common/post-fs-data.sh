#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}
MODE="post-fs-data"
LOGFILE=/cache/magisk.log
APKNAME=ViPERFX.apk
PACKAGENAME=com.audlabs.viperfx
REBOOT=false

log_print() {
  echo "v4a: $1"
  echo "v4a: $1" >> $LOGFILE
  log -p i -t v4a "$1"
}

# This script will be executed in post-fs-data mode
# More info in the main Magisk thread

/data/magisk/sepolicy-inject --live -s mediaserver -t mediaserver_tmpfs -c file -p read,write,execute
/data/magisk/sepolicy-inject --live -s audioserver -t audioserver_tmpfs -c file -p read,write,execute

# v4a Android package installation
if [ -f "/cache/ViPERFX.apk" ]; then
  cp /cache/$APKNAME /data/$APKNAME
  rm /cache/$APKNAME
fi
if [ -f "/data/$APKNAME" ]; then
  log_print "installing $APKNAME in /data"

  APKPATH=com.audlabs.viperfx-1
  for i in `ls /data/app | grep com.audlabs.viperfx-`; do
    if [ `cat /data/system/packages.xml | grep $i >/dev/null 2>&1; echo $?` -eq 0 ]; then
      APKPATH=$i
      break;
    fi
  done
  rm -rf /data/app/com.audlabs.viperfx-*

  log_print "target path: /data/app/$APKPATH"

  mkdir /data/app/$APKPATH
  chown 1000.1000 /data/app/$APKPATH
  chmod 0755 /data/app/$APKPATH
  chcon u:object_r:apk_data_file:s0 /data/app/$APKPATH

  cp /data/$APKNAME /data/app/$APKPATH/base.apk
  chown 1000.1000 /data/app/$APKPATH/base.apk
  chmod 0644 /data/app/$APKPATH/base.apk
  chcon u:object_r:apk_data_file:s0 /data/app/$APKPATH/base.apk

  rm /data/$APKNAME

  sync

  # just in case
  REBOOT=true
fi

# sometimes we need to reboot, make it so
if ($REBOOT); then
  log_print "rebooting"
  if [ "$MODE" = "post-fs-data" ]; then
    # avoid device freeze (reason unknown)
    sh -c "sleep 5; reboot" &
  else
    reboot
  fi
  exit
fi