# Devices

## All

    [root@nixos:~]# which ls
    /run/current-system/sw/bin/ls

## nix QEMU VM

    [root@nixos:~]# lsblk
    NAME MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
    fd0    2:0    1    4K  0 disk
    sr0   11:0    1 1024M  0 rom
    vda  253:0    0    1G  0 disk /

## GNOME Boxes

    [root@nixos:~]# lsblk
    NAME  MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
    loop0   7:0    0   388M  1 loop /nix/.ro-store
    sr0    11:0    1 414.9M  0 rom  /iso
    vda   253:0    0    20G  0 disk
