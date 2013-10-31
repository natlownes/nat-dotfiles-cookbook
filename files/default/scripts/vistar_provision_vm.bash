#!/usr/bin/env bash

env=$1

cd ~/src/vistar/cookbooks
git submodule foreach git pull origin master

cd ~/src/vistar/cookbooks/environments/$env && vagrant provision
