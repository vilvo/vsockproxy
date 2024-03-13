
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
# login ghaf/ghaf and run iperf3 --vsock -s
>>> guestB.start()
# login ghaf/ghaf and run iperf3 --vsock -c 2
```

