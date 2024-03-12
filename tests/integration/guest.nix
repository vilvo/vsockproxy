let
  nixpkgs = <nixpkgs>;
  pkgs = import nixpkgs {};
  iperf-vsock = pkgs.callPackage ../../packages/iperf-vsock.nix {};
in
  pkgs.nixosTest {
    name = "test2";
    nodes.machine = {
      config,
      pkgs,
      ...
    }: {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      users.users.ghaf = {
        isNormalUser = true;
        extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
        packages = with pkgs; [
          iperf-vsock
        ];
      };

      system.stateVersion = "23.11";
    };

    testScript = {nodes, ...}: ''
      machine.wait_for_unit("default.target")
      machine.succeed("su -- ghaf -c 'which iperf3'")
    '';
  }
