#!/usr/bin/env bash

if env |grep -q ^SSH_AUTH_SOCK; then
  ln -sfv $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
fi
