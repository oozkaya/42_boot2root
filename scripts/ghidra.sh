mkdir -p /tmp/boot2root

curl https://raw.githubusercontent.com/mviereck/x11docker/master/x11docker > /tmp/x11docker

scp laurie@192.168.1.77:bomb /tmp/boot2root/bomb



bash /tmp/x11docker  \
    --name ghidra \
    --share /tmp/boot2root \
    --clipboard --xephyr \
    --wm=x11docker/fvwm \
    blacktop/ghidra
