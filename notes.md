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

[Report here](logs/LinEnum-export-10-12-20.html)

## linPEAS.sh

LinPEAS is a script that search for possible paths to escalate privileges on Linux/Unix\* hosts. The checks are explained on book.hacktricks.xyz

Check the Local Linux Privilege Escalation checklist from [book.hacktricks.xyz](https://book.hacktricks.xyz/linux-unix/privilege-escalation)

[https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS)

```shell
curl https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/linPEAS/linpeas.sh | sh > linPEAS.log
```

[Report here](logs/linPEAS.html)

## LES: Linux privilege escalation auditing tool

LES tool is designed to assist in detecting security deficiencies for given Linux kernel/Linux-based machine. It provides following functionality:

- Assessing kernel exposure on publicly known exploits
- Verifying state of kernel hardening security measures

[https://github.com/mzet-/linux-exploit-suggester](https://github.com/mzet-/linux-exploit-suggester)

```shell
wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh
bash les.sh > les.log
```

[Report here](logs/)
