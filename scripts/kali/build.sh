#! /bin/bash

CURDIR=`dirname "$0"`

set -x
docker build -t kali-light $CURDIR