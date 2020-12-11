#! /bin/bash

function install {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        local DISTRIB=$(awk -F= '/^NAME/{print $2}' /etc/os-release)

        if [[ ${DISTRIB} =~ "Ubuntu"* ]] || [[ ${DISTRIB} =~ "Debian"* ]]; then
            (set -x
            sudo apt install sshpass -y)
        fi
        if [[ ${DISTRIB} =~ "CentOS"* ]] || [[ ${DISTRIB} =~ "Fedora"* ]]; then
            (set -x
            sudo yum install sshpass -y)
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        (set -x
        brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb)
    else
        echo "Please install manually sshpass"
    fi
}

if dpkg -s sshpass >/dev/null 2>&1; then
    echo "sshpass is already installed"
    exit 1
fi

read -p "Do you want install sshpass on local machine ? [yY] " -n 1 -r
if [[ $REPLY =~ ^[yY]$ ]]; then
    echo
    install
fi