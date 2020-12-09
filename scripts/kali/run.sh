#! /bin/bash

CURDIR=`dirname "$0"`

if [ -z ${B2R_HOST+x} ]; then read -p "VM Host: " B2R_HOST; fi
if [ -z ${B2R_PORT+x} ]; then read -p "VM Port: " B2R_PORT; fi

docker run -it \
    --rm \
    --name kali \
    -e SNOW_HOST=$B2R_HOST \
    -e SNOW_PORT=$B2R_PORT \
    kali-light