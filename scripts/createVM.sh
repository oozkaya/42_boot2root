#! /bin/bash

CURDIR=`dirname $0`

MACHINENAME="Boot2root"
ISOPATH="$CURDIR/BornToSecHackMe-v1.1.iso"
ISO_INTRA_LOCATION="https://projects.intra.42.fr/uploads/document/document/2527/BornToSecHackMe-v1.1.iso"
START_VM_SCRIPT="$CURDIR/startVM.sh"

function checkVM {
    IS_VM_EXIST=`VBoxManage list vms | grep -i $MACHINENAME | wc -l`
    if [ "$IS_VM_EXIST" -gt 0 ]; then
        (set -x; VBoxManage list vms | grep -i $MACHINENAME)
        echo "The VM $NAME already exists"
        read -p $'\e[93mDo you want to remove $MACHINENAME ? \e[0m(Please type "yesIdo" to confirm) '
        if [ "$REPLY" = "yesIdo" ]; then
            VBoxManage controlvm $MACHINENAME poweroff 2>/dev/null || true
            VBoxManage unregistervm --delete $MACHINENAME
        else
            echo "Installation stopped"
            exit 1;
        fi
    fi
}

function downloadISO {
    if [ ! -f "$ISOPATH" ]; then
        echo "$ISOPATH does not exist"
        read -p "Download $MACHINENAME ? [yY] " -n 1 -r
        if [[ $REPLY =~ ^[yY]$ ]]; then
            echo
            (set -x; (curl -L $ISO_INTRA_LOCATION > $ISOPATH))
        else
            exit 1;
        fi
    fi
}

function installVM {
    read -p "Install $MACHINENAME ? [yY] " -n 1 -r
    if [[ ! $REPLY =~ ^[yY]$ ]]; then exit 1; fi

    #Create VM
    VBoxManage createvm --name $MACHINENAME --ostype "Linux_64" --register --basefolder $CURDIR
    
    #Set memory and network
    selectBridgedInterface
    VBoxManage modifyvm $MACHINENAME --nic1 bridged --bridgeadapter1 $BRIDGED_INTERFACE
    VBoxManage modifyvm $MACHINENAME --memory 1024 --vram 128
    
    #Create Disk and connect Iso
    VBoxManage createhd --filename $CURDIR/$MACHINENAME/$MACHINENAME_DISK.vdi --size 2000 --format VDI
    VBoxManage storagectl $MACHINENAME --name "SATA Controller" --add sata --controller IntelAhci
    VBoxManage storageattach $MACHINENAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $CURDIR/$MACHINENAME/$MACHINENAME_DISK.vdi
    VBoxManage storagectl $MACHINENAME --name "IDE Controller" --add ide --controller PIIX4
    VBoxManage storageattach $MACHINENAME --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $ISOPATH
    VBoxManage modifyvm $MACHINENAME --boot1 dvd --boot2 disk --boot3 none --boot4 none
}

function selectBridgedInterface {
    PS3='Please select the bridged interface: '
    BRIDGED_IFS=`VBoxManage list bridgedifs | grep '^Name:' | awk -F ' ' '{print $2}'`
    readarray -t OPTIONS <<<"$BRIDGED_IFS"

    OPTIONS_SIZE=${#OPTIONS[@]}
    select option in "${OPTIONS[@]}"; do
        if [ "$REPLY" -ge 1 ] && [ "$REPLY" -le $OPTIONS_SIZE ]; then
            BRIDGED_INTERFACE=$option
            echo "You selected $option"; break;
        else
            echo "Incorrect Input: Select a number 1-$OPTIONS_SIZE"
        fi
    done
}

function startVM {
    read -p "Start the VM $MACHINENAME ? [yY] " -n 1 -r
    if [[ $REPLY =~ ^[yY]$ ]]; then
        echo
        $START_VM_SCRIPT
    fi
}

set -e
checkVM
downloadISO
installVM
startVM
