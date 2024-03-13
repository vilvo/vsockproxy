let
  nixpkgs = <nixpkgs>;
  pkgs = import nixpkgs {};
  iperf-vsock = pkgs.callPackage ../../packages/iperf-vsock.nix {};
  users.users.ghaf = {
    password = "ghaf";
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [iperf-vsock];
  };
  system.stateVersion = "23.11";
in
  pkgs.nixosTest {
    name = "test guest-to-guest throughput over vsockproxy-c";

    nodes.guestA = {
      config,
      pkgs,
      ...
    }: {
      inherit users system;
      virtualisation.qemu.options = [
        "-device"
        "vhost-vsock-pci,guest-cid=5"
        ];
    };

    nodes.guestB = {
      config,
      pkgs,
      ...
    }: {
      inherit users system;
      virtualisation.qemu.options = [
        "-device"
        "vhost-vsock-pci,guest-cid=4"
      ];
    };

    testScript = {nodes, ...}: ''
      guestA.wait_for_unit("default.target")
      guestB.wait_for_unit("default.target")
      guestA.execute("su -- ghaf -c 'iperf3 --vsock -s'")
      guestB.execute("su -- ghaf -c 'iperf3 --vsock -c 2'")
    '';
  }
