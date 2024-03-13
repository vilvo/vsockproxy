
## Manually

### one shell
```
[~/vsockproxy]$ nix develop
[~/vsockproxy]$ vsockproxy-c 5201 5 5201 # 5 is CID
```

### another shell
```
[~/vsockproxy/tests/integration]$
$(nix-build -A driverInteractive vsockproxy-guests-throughput.nix)/bin/nixos-test-driver
>>> guestA.start()
>>> guestB.start()
```

### Known issues

NixOSTest seems not to start the test VMs with vsock support.
TODO: find a way to pass `vsock` required parameters to [`qemu-vm.nix`](https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/virtualisation/qemu-vm.nix)
```
$ ps aux|grep -i qemu
vilvo     186522  6.3  2.3 3065312 378368 pts/1  Sl+  11:33   0:11
/nix/store/hfpplp0a97q0pi0z6ymy58b8jc0f79qv-qemu-8.1.3/bin/qemu-system-aarch64
 -machine virt,gic-version=max,accel=kvm:tcg -cpu max -name guestA -m
 1024 -smp 1 -device virtio-rng-pci -net
 nic,netdev=user.0,model=virtio
 -netdev user,id=user.0, -virtfs
 local,path=/nix/store,security_model=none,mount_tag=nix-store
 -virtfs
 local,path=/tmp/nix-shell.vk78Ar/shared-xchg,security_model=none,mount_tag=shared
 -virtfs
 local,path=/tmp/nix-shell.vk78Ar/vm-state-guestA/xchg,security_model=none,mount_tag=xchg
 -drive
 cache=writeback,file=/tmp/nix-shell.vk78Ar/vm-state-guestA/guestA.qcow2,id=drive1,if=none,index=1,werror=report
 -device virtio-blk-pci,bootindex=1,drive=drive1,serial=root
 -device virtio-net-pci,netdev=vlan1,mac=52:54:00:12:01:01
 -netdev vde,id=vlan1,sock=/tmp/nix-shell.vk78Ar/vde1.ctl
 -device virtio-keyboard -device virtio-gpu-pci -device
 usb-ehci,id=usb0
 -device usb-kbd -device usb-tablet
 -kernel
 /nix/store/720sd2a5dccgc5vpd4nrx5ldwqzm9z75-nixos-system-guestA-24.05.20231219.54aac08/kernel
 -initrd
 /nix/store/2hfprryb4i5kbpdigbdkf6akrychagf5-initrd-linux-6.1.68/initrd
 -append console=ttyAMA0 panic=1 boot.panic_on_fail clock=acpi_pm
 loglevel=7 net.ifnames=0
 init=/nix/store/720sd2a5dccgc5vpd4nrx5ldwqzm9z75-nixos-system-guestA-24.05.20231219.54aac08/init
 regInfo=/nix/store/hw95xl381v4ciwjdv5b7fd18a4887yzp-closure-info/registration
 console=ttyAMA0
 -qmp
 unix:/tmp/nix-shell.vk78Ar/vm-state-guestA/qmp,server=on,wait=off
 -monitor unix:/tmp/nix-shell.vk78Ar/vm-state-guestA/monitor
 -chardev
 socket,id=shell,path=/tmp/nix-shell.vk78Ar/vm-state-guestA/shell
 -device virtio-serial -device virtconsole,chardev=shell
 -device virtio-rng-pci -serial stdio -no-reboot
vilvo     186650  8.2  2.3 2674992 374992 pts/1  Sl+  11:34   0:11
/nix/store/hfpplp0a97q0pi0z6ymy58b8jc0f79qv-qemu-8.1.3/bin/qemu-system-aarch64
 -machine virt,gic-version=max,accel=kvm:tcg -cpu max -name guestB -m
 ...
```
