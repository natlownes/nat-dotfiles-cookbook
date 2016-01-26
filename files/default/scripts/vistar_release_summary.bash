#!/usr/bin/env bash

# git log --before=`date -dlast-monday +%Y-%m-%d` --oneline | head -1

src_root="$HOME/src/vistar"

projects="pub-ad-server platform geo-ui geo-rest vistar vistar-ui locus trafficking"

summary=""

for p in $projects;
do
  pushd "$src_root/$p"
  git fetch --all -p
  summary+=$(git diff --color origin/master origin/develop)
  popd
done

echo "$summary" | less -R
