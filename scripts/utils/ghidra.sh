#! /bin/bash

SHARED_FOLDER="/tmp/boot2root"
mkdir -p $SHARED_FOLDER

installLinuxGnu () {
    if ! dpkg -s xclip >/dev/null 2>&1; then
        local DISTRIB=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
        if [[ ${DISTRIB} =~ "Ubuntu"* ]] || [[ ${DISTRIB} =~ "Debian"* ]]; then
            sudo apt update
            apt install -y xclip
        elif [[ ${DISTRIB} =~ "CentOS"* ]] || [[ ${DISTRIB} =~ "Fedora"* ]]; then
            sudo yum update
            yum install xclip -y
        fi
    fi

    curl -s https://raw.githubusercontent.com/mviereck/x11docker/master/x11docker > /tmp/x11docker
}

installDarwin () {
    brew list xquartz || brew cask install xquartz
    brew list socat || brew install socat
    open -a XQuartz # make sure you "Allow connections from network clients"
    xhost + 127.0.0.1
    socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
}

# Only tested on Ubuntu 18.04 only
runLinuxGnu () {
    bash /tmp/x11docker  \
        --name ghidra \
        --share "$SHARED_FOLDER" \
        --clipboard --xephyr \
        --wm=x11docker/fvwm \
        blacktop/ghidra
}

# Not Tested ! Source : https://github.com/blacktop/docker-ghidra
runDarwin () {
    docker run --init -it --rm \
        --name ghidra \
        --cpus 2 \
        --memory 2g \
        -e MAXMEM=2G \
        -e DISPLAY=host.docker.internal:0 \
        -v "$SHARED_FOLDER":/root \
        blacktop/ghidra
}

read -p "Do you want install ghidra requirements and run it on docker container ? [yY] " -n 1 -r
if [[ $REPLY =~ ^[yY]$ ]]; then
    echo
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        installLinuxGnu
        runLinuxGnu
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        installDarwin
        runDarwin
    else
        echo "OS not supported. Please install manually ghidra"
    fi
fi
