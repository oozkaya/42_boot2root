#! /bin/bash

NAME="boot"

CURDIR=`dirname $0`

function selectMachine {
    PS3="Please select the virtual machine: "
    VM_LIST=`VBoxManage list vms`
    readarray -t OPTIONS <<<"$VM_LIST"

    OPTIONS_SIZE=${#OPTIONS[@]}
    select option in "${OPTIONS[@]}"; do
        if [ "$REPLY" -ge 1 ] && [ "$REPLY" -le $OPTIONS_SIZE ]; then
            FORMAT_NAME=`echo $option | cut -d' ' -f1 | tr -d '"'`
            VM_NAME=$FORMAT_NAME
            echo "You selected $option"; break;
        else
            echo "Incorrect Input: Select a number 1-$OPTIONS_SIZE"
        fi
    done
}

selectMachine

MAC_ADDRESS=`VBoxManage showvminfo $VM_NAME | grep -oP 'MAC: \K[^",]+' | sed -e 's/[0-9A-F]\{2\}/&:/g' -e 's/:$//'`
VM_IP=`ip neighbor | grep -i $MAC_ADDRESS | cut -d' ' -f1`

echo -e "You should set its IP as environment variable\n" 
echo "export B2R_HOST=$VM_IP"