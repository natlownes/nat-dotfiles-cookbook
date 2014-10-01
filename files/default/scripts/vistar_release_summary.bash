#!/usr/bin/env bash

src_root="$HOME/src/vistar"

projects="pub-ad-server platform geo-ui geo-rest vistar vistar-ui locus"
tempfile=/tmp/vistar-release-summary-$(date +%Y-%m-%d).diff

: > $tempfile

for p in $projects;
do
  pushd "$src_root/$p"
  git fetch --all -p
  git diff --color origin/master origin/develop >> $tempfile
  popd
done

less -R $tempfile && rm $tempfile
