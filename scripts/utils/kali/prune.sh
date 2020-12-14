#! /bin/bash

IMAGE="kali-light"
CONTAINER="kali"

read -p $'\e[93mRemove the container "'$CONTAINER$'" ? \e[0m[yY] ' -n 1 -r
if [[ $REPLY =~ ^[yY]$ ]]; then
    echo
    (set -x; docker rm -f $CONTAINER)
fi

echo

read -p $'\e[93mRemove the image "'$IMAGE$'" ? \e[0m[yY] (long to rebuild) ' -n 1 -r
if [[ $REPLY =~ ^[yY]$ ]]; then
    echo
    (set -x; docker image rm $IMAGE)
fi
