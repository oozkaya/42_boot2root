#!/bin/bash

CURDIR=`dirname "$(readlink -f "$0")"`

USER="laurie"
PASS="330b845f32185747e4f8ca15d40ca59796035c89ea809fb5d30f4da83ecf45a4"
B2R_PORT=22

REMOTE_FILES="{README,bomb}"
LOCAL_DEST="/tmp/boot2root/bomb"

GHIDRA_SCRIPT="$CURDIR/../../utils/ghidra.sh"

if [ -z ${B2R_HOST+x} ]; then read -p "VM Host: " B2R_HOST; fi

if dpkg -s sshpass >/dev/null 2>&1; then
    export SSHPASS=$PASS
    SSHP="sshpass -e"
fi

# Connect to level and run the script
echo -e "$USER password is: $PASS\n"
(set -x
    mkdir -p $LOCAL_DEST

    $SSHP \
    scp -q -o StrictHostKeyChecking=no \
        -P $B2R_PORT \
        $USER@$B2R_HOST:$REMOTE_FILES \
        $LOCAL_DEST

    ls -lR $LOCAL_DEST
)

echo && read -p "Do you want run ghidra (shared folder: /tmp/boot2root)? [yY] " -n 1 -r
if [[ $REPLY =~ ^[yY]$ ]]; then
    echo && $GHIDRA_SCRIPT
fi

