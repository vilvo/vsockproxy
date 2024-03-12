let
  nixpkgs = <nixpkgs>;
  pkgs = import nixpkgs {};
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

      services.xserver.enable = true;
      services.xserver.displayManager.gdm.enable = true;
      services.xserver.desktopManager.gnome.enable = true;

      users.users.ghaf = {
        isNormalUser = true;
        extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
        packages = with pkgs; [
          firefox
        ];
      };

      system.stateVersion = "23.11";
    };

    testScript = {nodes, ...}: ''
      machine.wait_for_unit("default.target")
      machine.succeed("su -- ghaf -c 'which firefox'")
      machine.fail("su -- root -c 'which firefox'")
    '';
  }
