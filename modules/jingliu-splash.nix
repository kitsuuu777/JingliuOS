{ nixpkgs-unstable, pkgs, ... }:

let
  unstable = nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  jingliuSplash = pkgs.callPackage ../packages/jingliu-splash.nix { };

  jingliuStartup = pkgs.writeShellApplication {
    name = "jingliu-startup";

    runtimeInputs = with pkgs; [
      bash
      coreutils
      gnugrep
      hyprland
      unstable.noctalia-shell
      uwsm
    ];

    text = builtins.readFile ../scripts/jingliu-startup;
  };

  hsrDashboardIcon = pkgs.runCommand "hsr-dashboard-icon" { } ''
    mkdir -p $out/share/icons/hicolor/512x512/apps
    cp ${../assets/jingliu-splash/assets/nixos-icon.png} \
      $out/share/icons/hicolor/512x512/apps/hsr-dashboard.png
  '';

  hsrDashboardDesktopItem = pkgs.makeDesktopItem {
    name = "hsr-dashboard";
    desktopName = "HSR Dashboard";
    exec = "kitty --class hsr-dashboard --hold fastfetch";
    icon = "hsr-dashboard";
    startupWMClass = "hsr-dashboard";
    terminal = false;
    categories = [ "Utility" ];
  };
in
{
  environment.systemPackages = [
    jingliuSplash
    jingliuStartup
    hsrDashboardIcon
    hsrDashboardDesktopItem
  ];
}
