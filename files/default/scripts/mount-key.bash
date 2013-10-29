#!/usr/bin/env bash

action=$1


if [[ "$action" == "open" ]]; then
  mkdir -p  ~/opt/local/mnt/home
  sudo mount /dev/disk/by-label/HOME ~/opt/local/mnt/home
fi

if [[ "$action" == "close" ]]; then
  sudo umount -fl ~/opt/local/mnt/home
fi
