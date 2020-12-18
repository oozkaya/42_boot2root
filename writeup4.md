# Root privilege escalation - Method 4: Boot to shell through the boot loader

There are three ways to pass options to the kernel and thus control its behaviour:

1. When building the kernel—in the kernel's config file
2. **When starting the kernel—using command line parameters (usually through a boot loader)**
3. At runtime—through the files in /proc/sys/ (see sysctl) and /sys/

The idea is to use the second method while appending the `init=/bin/bash` kernel parameter to our boot loader's boot entry.

### How to

During boot, press and hold `Shift`. This will bring up a boot promt.

```shell
boot: _
```

Considering, the [documentation](https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html), we could run a specified binary instead of `/sbin/init` as init process.

```
init=           [KNL]
                Format: <full_path>
                Run specified binary instead of /sbin/init as init process.
```

```shell
boot: init=/bin/sh
Could not find kernel image: init=/bin/sh
```

Unfortunately, it does not work...

```
boot: <TAB>
  live
```

While pressing <kbd>TAB</kbd>, the only option is "live". As the virtual machine is booting on the ISO image, we need to specify it as prefix.

```
boot: live init=/bin/sh
# whoami
  root
```

## Sources

- [How do I boot into a root shell?](https://askubuntu.com/questions/92556/how-do-i-boot-into-a-root-shell)

- [Reset lost root password - Using bash as init](https://wiki.archlinux.org/index.php/Reset_lost_root_password)

- [Kernel parameters](https://wiki.archlinux.org/index.php/Kernel_parameters)

- [The kernel’s command-line parameters](https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html)
