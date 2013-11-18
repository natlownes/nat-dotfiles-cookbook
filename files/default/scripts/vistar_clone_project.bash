#!/usr/bin/env bash

src_dir="$HOME/src/vistar"
url_base="ssh://gerrit.vistarmedia.com:29418/"
project_name=$1
destination_dir=$src_dir/$project_name

user_real_name="nat"
user_vistar_email="nat@vistarmedia.com"

if [ -z "$project_name" ]; then
  echo "requires a project name"
  exit 1
fi

project_url="${url_base}${project_name}.git"

function git_clone () {
  git clone $project_url $destination_dir
}


function git_update_user_info () {
cd $destination_dir && git config user.name $user_real_name && git config user.email $user_vistar_email
}

mkdir -p $src_dir

pushd $src_dir && git_clone && git_update_user_info && popd
