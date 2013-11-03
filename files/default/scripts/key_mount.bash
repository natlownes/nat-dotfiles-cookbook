#!/usr/bin/env bash

action=$1
user=`who -m | awk '{print $1;}'`
userid=$(awk -F"[=(]" '{print $2,$4}' <(id "$user"))
home_dir="/home/$user"
mount_dir_root="$HOME/opt/local/mnt"
images=('keys.tc' 'src-secure.tc')
mount_points=('home')
mount_dirs=("${images[@]}" "${mount_points[@]}")
images_root="$HOME/opt/local/mnt/home"

if [[ "mount" == "$action" ]]; then
  [[ ! -d $mount_dir_root ]] && mkdir -p $mount_dir_root
  for dir_name in ${mount_dirs[@]}; do
    mount_point="$mount_dir_root/$dir_name"
    [[ ! -d $mount_point ]] && mkdir "$mount_point"
  done
  # mount physical
  sudo mount -o nosuid,uid="${userid% *}",gid="${userid#* }" /dev/disk/by-label/HOME $HOME/opt/local/mnt/home || exit 1

  for image_name in ${images[@]}; do
    truecrypt -t --mount --fs-options=force,nosuid,uid="${userid% *}",gid="${userid#* }" "$images_root/$image_name" "$mount_dir_root/$image_name"
  done
fi

if [[ "umount" == "$action" ]]; then
  truecrypt -t -d
  sudo umount $HOME/opt/local/mnt/home
fi

