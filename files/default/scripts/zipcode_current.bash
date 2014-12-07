#!/usr/bin/env bash

curl http://ipinfo.io/json | grep postal | sed 's/[^0-9]//g'
