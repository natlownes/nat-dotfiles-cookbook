#!/usr/bin/env bash

src_dir="$HOME/src/vistar"
url_base="ssh://gerrit.vistarmedia.com:29418/"
project_name=$1

user_real_name="nat"
user_vistar_email="nat@vistarmedia.com"

if [ -z "$project_name" ]; then
  echo "requires a project name"
  exit 1
fi

project_url="${url_base}${project_name}.git"

mkdir -p $src_dir

pushd $src_dir && git clone $project_url && git config user.name $user_real_name
&& git config user.email $user_vistar_email && popd
