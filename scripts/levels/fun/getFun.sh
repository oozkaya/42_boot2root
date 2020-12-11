#!/bin/bash

CURDIR=`dirname "$(readlink -f "$0")"`

USER="lmezard"
PASS='G!%40M6f4Eatau{sF"' # @ is replaced with %40
B2R_PORT=21

REMOTE_FILES=("README" "fun")
LOCAL_DEST="/tmp/boot2root/fun"

GHIDRA_SCRIPT="$CURDIR/../../utils/ghidra.sh"

if [ -z ${B2R_HOST+x} ]; then read -p "VM Host: " B2R_HOST; fi

# Connect to level and run the script
echo -e "$USER password is: $PASS\n"
(set -x
    mkdir -p $LOCAL_DEST

    for file in ${REMOTE_FILES[*]}
    do
        wget --continue ftp://$USER:$PASS@$B2R_HOST:$B2R_PORT/$file -P $LOCAL_DEST > /dev/null
    done

    ls -l $LOCAL_DEST
)

echo && read -p "Do you want extract the archive ? [yY] " -n 1 -r
if [[ $REPLY =~ ^[yY]$ ]]; then
    echo
    tar -xvf $LOCAL_DEST/fun -C $LOCAL_DEST > /dev/null
    echo "extract folder: $LOCAL_DEST/ft_fun"
fi

echo && read -p "Do you want create a single output of pcap files ? [yY] " -n 1 -r
if [[ $REPLY =~ ^[yY]$ ]]; then
    echo
    cd $LOCAL_DEST
    awk 'FNR==1 {print FILENAME}; {print "\t" $0}' $LOCAL_DEST/ft_fun/* > $LOCAL_DEST/output

    echo "output is available at: $LOCAL_DEST/output"
fi

