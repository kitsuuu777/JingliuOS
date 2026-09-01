{ config, nixpkgs-unstable, pkgs, ... }:

let
  unstable = import nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
  };

  gamingWatcher = pkgs.writeShellApplication {
    name = "gaming-watcher";

    runtimeInputs = with pkgs; [
      jq
      hyprland
      power-profiles-daemon
      unstable.noctalia-shell
    ];

    text = builtins.readFile ../scripts/gaming-watcher;
  };

  honkersLauncher = pkgs.writeShellApplication {
    name = "honkers-railway-launcher-fixed";

    runtimeInputs = [
      config.programs.honkers-railway-launcher.package
    ];

    text = ''
      cd "$HOME"
      exec honkers-railway-launcher "$@"
    '';
  };

in
{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    unstable.heroic
    gamescope
    mangohud
    gamemode
    honkersLauncher
  ];

  programs.gamemode.enable = true;

  services.power-profiles-daemon.enable = true;

  systemd.user.services.gaming-watcher = {
    description = "JingliuOS Gaming Watcher";

    wantedBy = [ "default.target" ];
    after = [ "default.target" ];

    serviceConfig = {
      Type = "simple";

      ExecStart = "${gamingWatcher}/bin/gaming-watcher";

      Restart = "on-failure";
      RestartSec = 2;

      Environment = [
        "XDG_RUNTIME_DIR=/run/user/%U"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/%U/bus"
      ];

      StandardOutput = "journal";
      StandardError = "journal";
    };
  };
}
