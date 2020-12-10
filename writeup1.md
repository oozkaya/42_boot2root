# Root privilege escalation - Method 1

## Get VM IP

```shell
# On host machine
VM_NAME="boot2Root"

MAC_ADDRESS=`VBoxManage showvminfo $VM_NAME | grep -oP 'MAC: \K[^",]+' | sed -e 's/[0-9A-F]\{2\}/&:/g' -e 's/:$//'`
ip neighbor | grep -i $MAC_ADDRESS | cut -d' ' -f1

  192.168.1.72
```

We could export this value an environment variable: `export B2R_HOST=192.168.1.72`

---

## Scan Ports

Requirements: nmap

```shell
nmap $B2R_HOST

  Starting Nmap 7.60 ( https://nmap.org ) at 2020-12-09 11:20 CET
  Nmap scan report for BornToSecHackMe-1.home (192.168.1.72)
  Host is up (0.00016s latency).
  Not shown: 994 closed ports
  PORT    STATE SERVICE
  21/tcp  open  ftp
  22/tcp  open  ssh
  80/tcp  open  http
  143/tcp open  imap
  443/tcp open  https
  993/tcp open  imaps

  Nmap done: 1 IP address (1 host up) scanned in 0.06 seconds
```

---

### Sources

## Hack

-[DIRB](https://www.kali-linux.fr/forum/index.php?topic=1916.0)

## VM

-[Find IP of VM](https://unix.stackexchange.com/questions/350913/how-to-find-ip-of-virtual-machine)

## Man
