#!/usr/bin/env bash

while true; do
  if test -n "`tmux showb 2> /dev/null`"; then
    tmux showb > /tmp/buff.log
    tmux saveb - |pbcopy && tmux deleteb
  fi
  sleep 0.5
done
