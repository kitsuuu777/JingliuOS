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
in
{
  environment.systemPackages = [
    jingliuSplash
    jingliuStartup
  ];
}
