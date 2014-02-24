#!/usr/bin/env bash

env=$1

pushd ~/src/vistar/ops-cookbooks
git submodule foreach git pull origin master

popd

cd ~/src/vistar/ops-cookbooks && vagrant provision $env && popd
