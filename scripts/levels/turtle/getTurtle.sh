#!/bin/bash

CURDIR=`dirname "$(readlink -f "$0")"`

USER="thor"
PASS="Publicspeakingisveryeasy.126241207201b2149opekmq426135"
B2R_PORT=22

REMOTE_FILES="{README,turtle}"
LOCAL_DEST="/tmp/boot2root/turtle"

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

