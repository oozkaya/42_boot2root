# Boot2Root

## About

> Boot2Root is a security challenge. In a group, we had to search for various means to pass root on the given ISO.

This is the fourth project of the Security branch at School 42 Paris

Subjects:

- [boot2root.en.pdf](docs/boot2root.en.pdf)
- [boot2root.fr.pdf](docs/boot2root.fr.pdf)

---

## Solutions

Different ways to become root on this ISO:

|                         |                                                                                                   |
| ----------------------- | ------------------------------------------------------------------------------------------------- |
| [Method 1](writeup1.md) | Main hunter game created by the ISO author                                                        |
| [Method 2](writeup2.md) | Dirty CoW using an exploit that generates a new password hash on the fly and modifies /etc/passwd |
| [Method 3](writeup3.md) | Dirty CoW using an exploit that injects a shellcode into a SUID file                              |
| [Method 4](writeup4.md) | Boot to shell through the boot loader                                                             |

---

## Setup VM (Ubuntu/Debian)

Requirements:

- VirtualBox
- VirtualBox Guest Addition

```shell
./scripts/createVM.sh
./scripts/startVM.sh
```
