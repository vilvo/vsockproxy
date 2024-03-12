nix-prefetch-git --url "https://github.com/stefano-garzarella/iperf-vsock.git" --rev "dbef83efc8c0f5ad51ffc8252f018adc1c7e9820"

nix-build --keep-failed --expr 'with import <nixpkgs> {}; callPackage ./iperf-vsock.nix {}'
