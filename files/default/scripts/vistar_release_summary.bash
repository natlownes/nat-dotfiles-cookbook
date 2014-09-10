#!/usr/bin/env bash

src_root="$HOME/src/vistar"

projects="pub-ad-server platform geo-ui geo-rest vistar vistar-ui \
platform-scripts locus"

for p in $projects;
do
  pushd "$src_root/$p"
  git fetch --all -p
  git diff origin/develop origin/master
done
