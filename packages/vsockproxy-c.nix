{
  stdenv,
  pkgs,
  lib,
  ...
}:
stdenv.mkDerivation {
  name = "vsockproxy-c";

  nativeBuildInputs = with pkgs.buildPackages; [meson ninja];

  src = pkgs.fetchgit {
    url = "https://github.com/tiiuae/vsockproxy.git";
    rev = "4abe0b4eb83a29add31c82802e4882e8b9c7927e";
    sha256 = "1qfx90l6mnq62whpqcppdh2anixxq9i9vj671jvk84zjykj7pk6b";
  };

  installPhase = ''
    mkdir -p $out/bin
    install ./vsockproxy $out/bin/vsockproxy-c
  '';

  meta = with lib; {
    description = "vsockproxy-c";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}
