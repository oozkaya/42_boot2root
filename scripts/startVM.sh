#! /bin/bash

NAME="boot"

CURDIR=`dirname $0`

# set -x
VM_NAME=`VBoxManage list vms | grep -i $NAME | head -1 | grep -oP '\"\K[^" ]+'`
if [ -z "$VM_NAME" ]; then
    echo "The VM $NAME does not exist. Please install it first"
    exit 1;
fi

IS_VM_RUNNING=`vboxmanage showvminfo "$VM_NAME" | grep -c "running (since"`
if [ "$IS_VM_RUNNING" -eq "0" ]; then
    VBoxManage startvm $VM_NAME --type headless
else
    echo "VM $VM_NAME is already running"
fi

echo "Waiting for the IP..."
n=0
until [ "$n" -ge 60 ]
do
    MAC_ADDRESS=`VBoxManage showvminfo $VM_NAME | grep -oP 'MAC: \K[^",]+' | sed -e 's/[0-9A-F]\{2\}/&:/g' -e 's/:$//'`
    # VM_IP=`ip neighbor | grep -i $MAC_ADDRESS | cut -d' ' -f1`
    # VM_IP=`VBoxManage guestproperty enumerate $VM_NAME | grep -i ip | grep -ioP 'value: \K[^,]+'`
    VM_IP=`vboxmanage guestproperty get Boot2root "/VirtualBox/GuestInfo/Net/0/V4/IP" | sed -n 's/Value: //p'`
    if [ -n "$VM_IP" ]; then break; fi
    n=$((n+1)) 
    sleep 1
done
if [ -z "$VM_IP" ]; then
    echo -e "Failed to get the IP. Please run the following command and try again\n"
    echo "sudo service virtualbox restart"
    exit 1;
fi

echo -e "You should set its IP as environment variable\n"
echo "export B2R_HOST=$VM_IP"
echo "export B2R_PORT=$VM_PORT"