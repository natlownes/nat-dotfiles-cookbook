#!/usr/bin/env bash

src_root="$HOME/src/vistar"

projects="pub-ad-server platform geo-ui geo-rest vistar vistar-ui locus"

summary=""

for p in $projects;
do
  pushd "$src_root/$p"
  git fetch --all -p
  summary+=$(git diff --color origin/master origin/develop)
  popd
done

echo "$summary" | less -R
