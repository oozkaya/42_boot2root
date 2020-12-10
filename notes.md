# Some notes

## Identification

```shell
cat /etc/*-release
  DISTRIB_ID=Ubuntu
  DISTRIB_RELEASE=12.04
  DISTRIB_CODENAME=precise
  DISTRIB_DESCRIPTION="Ubuntu 12.04.5 LTS"
  NAME="Ubuntu"
  VERSION="12.04.5 LTS, Precise Pangolin"
  ID=ubuntu
  ID_LIKE=debian
  PRETTY_NAME="Ubuntu precise (12.04.5 LTS)"
  VERSION_ID="12.04"

uname -a
  Linux BornToSecHackMe 3.2.0-91-generic-pae \#129-Ubuntu SMP Wed Sep 9 11:27:47 UTC 2015 i686 i686 i386 GNU/Linux
```

## LinEnum.sh

LinEnum — is a bash-script that can do all the nasty job for you making all the adjustments described here cheat sheet’e. By and large, it has about 65 different checking operations, ranging from getting an information about the kernel version to searching potentially interesting SUID/GUID files. Besides, you can send a lock world to script that it would search in the all configurations and log-files. You can launch the checking like this: ./LinEnum.sh -k keyword -r report -e /tmp/ -t. After the scanning is complete you will get a detail report where the most interesting points will be highlighted with the yellow colour.

[https://github.com/rebootuser/LinEnum](https://github.com/rebootuser/LinEnum)

```shell
curl https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh > /tmp/LinEnum.sh
chmod +x /tmp/LinEnum.sh

/tmp/LinEnum.sh -k keyword -r report -e /tmp/
```

[Report here](logs/LinEnum-export-10-12-20)
