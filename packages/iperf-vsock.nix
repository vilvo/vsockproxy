{
  stdenv,
  pkgs,
  lib,
  ...
}:
stdenv.mkDerivation {
  name = "iperf-vsock";
  src = pkgs.fetchgit {
    url = "https://github.com/stefano-garzarella/iperf-vsock.git";
    rev = "dbef83efc8c0f5ad51ffc8252f018adc1c7e9820";
    sha256 = "1zl64i3fccbyb7fzbzmmyn23zwk4ycsp7dd8r1nppji0l5w8s38f";
  };

  meta = with lib; {
    description = "iperf-vsock";
    platforms = [
      "x86_64-linux"
    ];
  };
}
