#!/usr/bin/env bash

action=$1
user=`whoami`
userid=$(awk -F"[=(]" '{print $2,$4}' <(id "$user"))
home_dir="/home/$user"
mount_dir_root="$HOME/opt/local/mnt/home"
mount_points=('home')
mount_dirs=("${mount_points[@]}")

if [[ "mount" == "$action" ]]; then
  [[ ! -d $mount_dir_root ]] && mkdir -p $mount_dir_root
  for dir_name in ${mount_dirs[@]}; do
    mount_point="$mount_dir_root/$dir_name"
    encmount_point="$mount_dir_root/.$dir_name"
    [[ ! -d $mount_point ]] && mkdir "$mount_point"
    [[ ! -d $encmount_point ]] && mkdir "$encmount_point"
  done
  # mount physical
  sudo mount -o nosuid,uid="${userid% *}",gid="${userid#* }" /dev/disk/by-partlabel/home $HOME/opt/local/mnt/home || exit 1

  for dir_name in ${mount_dirs[@]}; do
    mount_point="$mount_dir_root/$dir_name"
    encmount_point="$mount_dir_root/.$dir_name"
    encfs $encmount_point $mount_point
  done
fi

if [[ "umount" == "$action" ]]; then
  sudo umount -fl $HOME/opt/local/mnt/home/home
  sudo umount -fl $HOME/opt/local/mnt/home
fi

