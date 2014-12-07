#!/usr/bin/env bash

i3status | while :
do
  current_weather="$(bash <%= @home_dir %>/.weather/current.bash)"
  read line
  echo "$current_weather | $line" || exit 1
done
