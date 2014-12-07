#!/usr/bin/env bash

lightblue='\033[1;34m'
red='\033[0;31m'
nocolor='\033[0m'

i3status | while read -e line :
do
  current_weather="$(bash <%= @home_dir %>/.weather/current.bash)"
  echo "$current_weather | $line" || exit 1
done
