#!/usr/bin/env bash

action=$1
user=`who -m | awk '{print $1;}'`
userid=$(awk -F"[=(]" '{print $2,$4}' <(id "$user"))
home_dir="/home/$user"

if [[ "mount" == "$action" ]]; then
  mkdir -p $HOME/opt/local/mnt/home
  mkdir -p $HOME/opt/local/mnt/keys
  mkdir -p $HOME/opt/local/mnt/src
  sudo mount -o nosuid,uid="${userid% *}",gid="${userid#* }" /dev/disk/by-label/HOME $HOME/opt/local/mnt/home || exit 1
  truecrypt -t --mount --fs-options=force,nosuid,uid="${userid% *}",gid="${userid#* }" $HOME/opt/local/mnt/home/keys.tc ~/opt/local/mnt/keys
  truecrypt -t --mount --fs-options=force,nosuid,uid="${userid% *}",gid="${userid#* }" $HOME/opt/local/mnt/home/src-secure.tc ~/opt/local/mnt/src
fi

if [[ "umount" == "$action" ]]; then
  truecrypt -t -d
  sudo umount $HOME/opt/local/mnt/home
fi

