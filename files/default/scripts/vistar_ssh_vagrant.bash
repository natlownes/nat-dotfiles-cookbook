#!/usr/bin/env bash

vm_name=$1

if [ -z "$vm_name" ]; then
  echo "requires a vm name"
  exit 1
fi

path="$HOME/src/vistar/cookbooks/environments/$vm_name"

pushd $path && vagrant ssh -p && popd
