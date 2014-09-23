#!/usr/bin/env bash

vm_name=$1
vagrant_command=$2

if [ -z "$vm_name" ]; then
  echo "requires a vm name"
  exit 1
fi

if [ -z "$vagrant_command" ]; then
  echo "requires a quoted vagrant command, i.e. 'up'"
  exit 1
fi

path="$HOME/src/vistar/ops-cookbooks"

pushd $path

git submodule init
git submodule update
git submodule foreach git pull origin master

vagrant $vagrant_command $vm_name
popd

